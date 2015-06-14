require 'rails_helper'
require 'support/test_helpers'

describe 'Friendships' do
  before do
    @user2 = FactoryGirl.build(:user, username: 'Amy', email: 'amy@mail.com',
                                password: 'password')
    @user2.save
    sign_in(@user2)
    create_goal('Learn to play the piano.')
    click_link 'Sign Out'
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

      within('ul.following') do
        expect(page).to_not have_link('Amy')
      end
    end

    it 'from goal page' do
      click_link 'Learn to play the piano.'
      click_button 'Unfollow'
      expect(page).to have_content('Successfully unfollowed user.')
      click_link 'Profile'

      within('ul.following') do
        expect(page).to_not have_link('Amy')
      end
    end
  end
end
