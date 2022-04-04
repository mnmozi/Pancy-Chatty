module Api
    module V1
        module Apps
            module Chats
                class MessagesController < ApplicationController
                    before_action :set_chat
                    MAX_PAGINATION_LIMIT=100
                    def index
                        puts "Getting the msgs for this chat limited to 100 and can specify offset!"
                        messages = @chat.messages.limit(limit).offset(params[:offset]).select('content, number').as_json(:except => :id)
                        render json: messages
                    end
                    def search 
                        
                        messages = Message.search(params[:content], where: {chat_id: @chat.id}, limit: limit, offset: params[:offset])
                        messagesResult = []
                        messages.each do |message|
                            puts message.content
                            messagesResult.push(message.content)
                          end
                        
                        render json: messagesResult
                    end
                    def create

                        if Rails.cache.redis.HEXISTS("chat_message_count",@chat.id) == 0
                            number = Message.where(chat_id: @chat.id).select('MAX(number) as max').group(:chat_id).as_json()
                            if number.size() == {}
                                number = [{'max':0}]
                            end
                            Rails.cache.redis.hset("chat_message_count", @chat.id, number[0]['max'].to_i)
                        end

                        message = @chat.messages.new(message_create_params.merge(number: Rails.cache.redis.HINCRBY("chat_message_count",@chat.id, 1) ))
                        if message.save
                            if Rails.cache.redis.HEXISTS("chat_message_count_job",@chat.id) == 0
                                puts "Adding a job to update the msgs count for a chat"
                                Rails.cache.redis.hset("chat_message_count_job", @chat.id, 1)
                                ChatMessageCountJob.perform_in(45.minutes, @chat.id)
                            else 
                                puts "Job already exists"
                            end
                            render json:{message: message.content, number: message.number},status: :created
                        else 
                            render json: {error: message.errors}, status: :unprocessable_entity
                        end
                        
                    end
    
                    def set_chat
                        app = App.find_by(token: params[:app_token])
                        if app.nil?
                            render json:{message: 'cant find app with this token'}, status: :not_found
                            return
                        end
                        @chat = Chat.where(number: params[:chat_number], app_id: app.id).first
                        if @chat.nil?
                            render json:{message: 'cant find chat with this data'}, status: :not_found
                            return
                        end
                    end
                    def message_create_params
                        params.require(:message).permit(:content)
                    end
                    def limit 
                        [
                            params.fetch(:limit,MAX_PAGINATION_LIMIT).to_i,
                            MAX_PAGINATION_LIMIT
                        ].min
                    end
                end
            end
        end
    end
end