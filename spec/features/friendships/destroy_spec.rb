require 'rails_helper'

describe 'Friendships' do
  before do
    create_friend
  end

  context 'returns success message when user unfollowed' do
    before do
      @user = FactoryGirl.build(:user)
      @user.save
      sign_in(@user)
      click_link 'Amy'
      click_button 'Follow'
      visit '/goals'
    end

    it 'from profile page' do
      click_link 'Amy'
      click_button 'Unfollow'
      expect(page).to have_content('Successfully unfollowed user.')
      click_link 'Profile'
      click_link 'Following (0)'

      within('ul.following') do
        expect(page).to_not have_link('Amy')
      end
    end

    it 'from goal page' do
      click_link 'Learn to play the piano.'
      click_button 'Unfollow'
      expect(page).to have_content('Successfully unfollowed user.')
      click_link 'Profile'
      click_link 'Following (0)'

      within('ul.following') do
        expect(page).to_not have_link('Amy')
      end
    end
  end
end
