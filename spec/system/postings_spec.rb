require "rails_helper"

RSpec.describe "Postings", type: :system do
  it "reserve a post" do
    visit root_path
    click_on "ログイン"
    visit new_post_path
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021\t17:15"

    expect { click_reserve }.to(
      change { Post.count }.by(1).and(
        enqueue_job(TwitterPostJob)
      )
    )

    expect(Post.last).to have_attributes(
      content: "Test posting.",
      time: "2021/10/1 17:15".in_time_zone
    )
    expect(page).to have_content "予約しました"
    expect(page).to have_content "Test posting."
    expect(page).to have_content "2021/10/1 17:15:00"
  end

  it "requests authentication to non-login user" do
    visit new_post_path
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021"
    click_reserve

    expect(page).to have_content("アカウント登録もしくはログインしてください")
  end

  it "registers postiong" do
    visit new_post_path
    click_on "ログイン"
    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021\t17:15"
    click_reserve

    expect(page).to have_content "2021/10/1 17:15:00"
    expect(page).to have_content "Test posting."
  end

  it "supports user to fix long tweet" do
    visit new_post_path
    click_on "ログイン"

    fill_in "post[content]", with: "Test posting." * 100
    fill_in "post[time]", with: "10/01/2021\t17:15"
    click_reserve

    expect(page).to have_content "本文は140文字以内で入力してください"

    fill_in "post[content]", with: "Test posting."
    fill_in "post[time]", with: "10/01/2021\t17:15"
    click_reserve

    expect(page).to have_content "2021/10/1 17:15:00"
    expect(page).to have_content "Test posting."
  end

  it "show what index page dose" do
    visit posts_path

    expect(page).to have_content "投稿予定のツイートがある場合、こちらで確認できます。"
  end
end
