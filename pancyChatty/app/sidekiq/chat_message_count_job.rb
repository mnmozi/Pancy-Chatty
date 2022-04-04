class ChatMessageCountJob
  include Sidekiq::Job

  def perform(*args)
    puts "executing the msg count job!"
    chat = Chat.find(args[0]);
    puts chat.as_json()
    if !chat.nil?
        # app.update(chatCount:  Rails.cache.redis.HGET("apps_chat_count",app.token))

      if chat.update_attribute(:msgCount,  Rails.cache.redis.HGET("chat_message_count",chat.id))
        puts "successfully update the count!"
        Rails.cache.redis.HDEL("chat_message_count_job", chat.id)
        puts "count updated for #{chat.id}" 
      else 
          Rails.cache.redis.HDEL("chat_message_count_job", chat.id)
          puts "count updated failed for #{chat.id}"
        
      end
    end
  end
end
