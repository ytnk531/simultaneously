Sidekiq.configure_server do |config|
  config.redis = {url: Rails.application.config.x.redis.url}
end

Sidekiq.configure_client do |config|
  config.redis = {url: Rails.application.config.x.redis.url}
end
