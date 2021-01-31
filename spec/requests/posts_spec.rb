# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/posts", type: :request do
  describe "GET /new" do
    it "renders a successful response" do
      get new_posts_url
      expect(response).to be_successful
    end
  end

  describe "POST /" do
    let(:valid_attributes) do
      {content: "Post to be reserved.iidsafa"}
    end
    context "with valid request" do
      it "renders time input" do
        post post_url
        expect(response).to have_content("")
      end
    end
    context "with invalid request" do
      it "returns error" do
      end
    end
  end
end
