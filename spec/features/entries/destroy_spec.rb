require 'rails_helper'

describe 'Destroy Entry' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
    create_entry('Buy brushes')
  end

  # other users and admins navigate to @user profile and goal pages
  def check_others(user)
    click_link 'Sign Out'
    other_user(user)
    click_link 'Wilbur'
  end

  # destroy the entry
  def destroy_entry
    within(".entries") do
      expect(page).to have_content('Buy brushes')
      click_link 'Destroy'
    end
    expect(page).to have_content("Entry was successfully destroyed.")
    expect(page).not_to have_content('Buy brushes')
  end

  context 'link is present and working' do
    it 'for goal owner on Goal page' do
      destroy_entry
    end

    it 'for admin on Goal page' do
      check_others("admin")
      click_link 'Learn to paint'
      destroy_entry
    end
  end

  context 'link is not present for other users' do
    it 'on Goal page' do
      check_others("friend")
      click_link 'Learn to paint'

      within("div.entries") do
        expect(page).not_to have_content('Destroy')
      end
    end
  end
end
