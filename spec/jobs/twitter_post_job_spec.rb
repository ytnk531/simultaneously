require "rails_helper"

RSpec.describe "TwitterPostJob" do
  let!(:stub) {
    stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json")
      .to_return(
        headers: {content_type: "application/json"},
        body: <<~JSON
          {
            "id": 1050118621198921700,
            "id_str": "1050118621198921728"
          }
        JSON
      )
  }

  it "posts status with authentication information" do
    user = User.new(twitter_token: "twitter_token", twitter_secret: "twitter_secret")
    post = Post.create!(content: "test message", user: user, time: Time.current)
    TwitterPostJob.perform_now(post.id)

    expect(WebMock).to have_requested(:post, "https://api.twitter.com/1.1/statuses/update.json")
      .with(
        body: {"status" => "test message"},
        headers: {"Authorization" => /oauth_token="twitter_token"/}
      )
  end
end
