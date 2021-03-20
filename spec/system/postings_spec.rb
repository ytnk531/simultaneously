require "rails_helper"

RSpec.describe "Postings", type: :system do
  it "reserve a post" do
    visit root_path
    click_on "Login"
    visit new_post_path
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021\t07:15"

    expect { click_on "Create Post" }.to(
      change { Post.count }.by(1).and(
        enqueue_job(TwitterPostJob).with(have_attributes(content: "Test posting."))
      )
    )

    expect(Post.last).to have_attributes(
      content: "Test posting.",
      time: "2021/10/1 7:15".in_time_zone
    )
    expect(page).to have_content "Done"
    expect(page).to have_content "Test posting."
    expect(page).to have_content "2021/10/1 7:15:00"
  end

  it "requests authentication to non-login user" do
    visit new_post_path
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021"
    click_on "Create Post"

    expect(page).to have_content("You need to sign in")
  end

  it "registers postiong" do
    visit new_post_path
    click_on "Login"
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021\t07:15"
    click_on "Create Post"

    expect(page).to have_content "2021/10/1 7:15:00"
    expect(page).to have_content "Test posting."
  end
end
