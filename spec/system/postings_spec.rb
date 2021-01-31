require "rails_helper"

RSpec.describe "Postings" do
  before do
    driven_by(:rack_test)
  end

  scenario "reserve a post" do
    visit new_post_path
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "2021/10/1"

    expect { click_on "Create Post" }.to change { Post.count }.to(1)
    expect(Post.last).to have_attributes(
      content: "Test posting.",
      time: "2021/10/1".in_time_zone
    )
    expect(page).to have_content "Done"
    expect(page).to have_content "Test posting."
    expect(page).to have_content "2021-10-01"
  end
end
