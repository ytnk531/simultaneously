require 'rails_helper'

RSpec.describe "TwitterPostJob" do
  it 'post' do
    user = User.new(twitter_token: 'twitter_token', twitter_secret: 'twitter_secret')
    post = Post.new(content: 'ddfs', user: user)
    TwitterPostJob.perform_now(post)
  end
end