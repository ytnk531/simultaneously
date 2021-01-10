class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    client.update(@post.content)
    redirect_to new_post_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret]
      config.access_token        = session["credentials"]["token"]
      config.access_token_secret = session["credentials"]["secret"]
    end
  end
end
