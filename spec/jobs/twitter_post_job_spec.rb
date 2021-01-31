require 'rails_helper'

RSpec.describe "TwitterPostJob" do
  it 'post' do
    post = Post.new(content: 'ddfs')
    TwitterPostJob.perform_now(post)
  end
end