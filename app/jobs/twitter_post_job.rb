class TwitterPostJob < ApplicationJob
  def perform(post_id)
    post = Post.find_by id: post_id
    return if post.blank?

    client(post.user).update(post.content)
  end

  def client(user)
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.configuration.twitter[:api_key]
      config.consumer_secret = Rails.configuration.twitter[:api_secret]
      config.access_token = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end
  end
end
