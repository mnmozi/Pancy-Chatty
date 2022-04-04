module Api
   module V1
    class AppsController < ApplicationController

      def index
        puts "listing all app's tokens"
        render json: App.all.select("token").as_json(:except => :id)
      end
      def search
        puts "Getting the token by the name of the app";
        render json: App.select("token").find_by(name: params[:name]).as_json(:except => :id)
      end
      def create
          puts "Creating new app!"
          # generating a random token for each app
          token = SecureRandom.hex(16)
          App.transaction do
          app = App.new(app_params.merge(token: token))

          # Adding the count for the chats for this new app
          Rails.cache.redis.hset("apps_chat_count", token, 0)
          
          if app.save
            render json: {token: app.token}, status: :created
          else
            render json: app.errors, status: :unprocessable_entity
          end 
        end
      end

      def app_params
        params.require(:app).permit(:name)
      end
    end
  end
end