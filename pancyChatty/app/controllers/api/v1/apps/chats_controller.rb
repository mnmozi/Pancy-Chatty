module Api
    module V1
        module Apps
            class ChatsController < ApplicationController
                
                before_action :set_app
                MAX_PAGINATION_LIMIT=100
                def index
                    puts "Getting all the chats for this app!"
                    if !@app
                        render json:{message: 'cant find app with this data', status: :notfound}
                    end
                    chats = @app.chats.limit(limit).offset(params[:offset])
                    render json: chats
                end
                def create
                    puts "Creating new Chat!"
                    # check if this chat have a count in my cache
                    if Rails.cache.redis.HEXISTS("apps_chat_count",@app.token) == 0
                        puts "This chat doesn't contain a count in the cache"
                        number = Chat.where(app_id: @app.id).select('MAX(number) as max').group(:app_id).as_json()
                        if number.size() == {}
                            number = [{'max':0}]
                        end 

                        Rails.cache.redis.hset("apps_chat_count", @app.token, number[0].max[1])
                    end
                    
                    chat = @app.chats.new(number:  Rails.cache.redis.HINCRBY("apps_chat_count",@app.token, 1))
                    if chat.save
                        # creating a msg count for this chat in the cache
                        Rails.cache.redis.hset("chat_message_count", chat.id, 0)

                        if Rails.cache.redis.HEXISTS("apps_chat_count_job",@app.token) == 0
                            puts "Adding a job to update the count in 30 minutes!"
                            Rails.cache.redis.hset("apps_chat_count_job", @app.token, 1)
                            AppChatCountJob.perform_in(30.minutes, @app.token)
                        else 
                            puts "Job already exists for this chat to update the count!"
                        end
                        render json:{chat: {number: chat.number }}, status: :created

                    else 
                        render json: {error: chat.errors}, status: :unprocessable_entity
                    end
                end

                def set_app
                    @app = App.find_by(token: params[:app_token])
                    if @app.nil?
                        render json:{message: 'cant find app with this id'}, status: :not_found
                        return
                    end
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