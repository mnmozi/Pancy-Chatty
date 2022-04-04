class AppChatCountJob
  include Sidekiq::Job

  def perform(*args)
    puts "executing the job!"
    app = App.find_by(token: args[0]);
    puts app.as_json()
    if !app.nil?
        # app.update(chatCount:  Rails.cache.redis.HGET("apps_chat_count",app.token))

      if app.update_attribute(:chatCount,  Rails.cache.redis.HGET("apps_chat_count",app.token))
        Rails.cache.redis.HDEL("apps_chat_count_job", app.token)
        puts "count updated for "+ app.token
      else 
          Rails.cache.redis.HDEL("apps_chat_count_job", app.token)
          puts "count updated failed for "+ app.token
        
      end
    end
    
  end
end
