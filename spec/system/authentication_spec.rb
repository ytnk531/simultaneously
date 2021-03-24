require "rails_helper"

RSpec.describe "authentication", type: :system do
  it "registers new user" do
    visit root_path

    expect { click_on "ログイン" }.to change { User.count }.by(1)
    expect(page).to have_link "ログアウト"
    expect(page).not_to have_link "ログイン"
  end

  it "authenticates user" do
    mock_omni_auth('token', 'secret2')
    User.create( twitter_token: "token", twitter_secret: "secret2",)
    visit root_path

    expect { click_on "ログイン" }.not_to change { User.count }
    expect(page).to have_link "ログアウト"
    expect(page).not_to have_link "ログイン"
  end

  it "allows logout to authenticated user" do
    visit root_path
    click_on "ログイン"
    click_on "ログアウト"
    expect(page).to have_link "ログイン"
  end
end
