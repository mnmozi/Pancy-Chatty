Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://imdb:6379/1') }
end
  
Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://imdb:6379/1') }
end