require "rails_helper"

RSpec.describe "authentication", type: :system do
  it "authenticates user" do
    visit root_path
    click_on "Login"
    expect(page).to have_link "Logout"
    expect(page).not_to have_link "Login"
  end

  it "allows logout to authenticated user" do
    visit root_path
    click_on "Login"
    click_on "Logout"
    expect(page).not_to have_link "Login"
  end
end
