require 'rails_helper'

RSpec.describe "Postings", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "reserve a post" do
      visit new_post_path
      fill_in 'post[content]', with: "Test posting."
      click_on 'Create Post'
      expect(page).to have_content 'when?'

      fill_in :time, '2021/10/1'
      click_on 'OK'
      expect(page).to have_content 'check'

      expect { click_on 'OK' }.to change { Post.count }.to(1)
      expect(Post.last).to have_attributes(
                             content: "Test postiong",
                             time: '2021/10/1'
                           )
      expect(page).to have_content 'Done'
  end
end
