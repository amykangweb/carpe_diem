require 'rails_helper'
require 'support/test_helpers'

describe 'Friends' do
  before do
    @user2 = FactoryGirl.build(:user, username: 'Amy', email: 'amy@mail.com',
                                password: 'password')
    @user2.save
    sign_in(@user2)
    create_goal('Learn to play the piano.')
    click_link 'Sign Out'
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
  end

  context 'returns error message on following' do
    it 'when user not signed in' do
      visit '/goals'
      click_link 'Learn to play the piano'
      click_link 'Follow'
      expect(page).to have_content('You need to sign in or sign up before
      continuing.')
    end

    it 'when user already following friend' do
      visit '/goals'
      click_link 'Learn to play the piano'
      click_link 'Follow'
      expect(page).to have_content('You are already following this user.')
    end
  end

  context 'returns success message when' do
    it 'user followed from profile page' do
      click_link 'Amy'
      click_link 'Follow'
      expect(page).to have_content('Successfully followed user.')
      click_link 'Profile'

      within("h2.following") do
        expect(page).to have_link('Amy')
      end
    end

    it 'user followed from goal page' do
      click_link 'Learn to play the piano.'
      click_link 'Follow'
      expect(page).to have_content('Successfully followed user.')
      click_link 'Profile'

      within("h2.following") do
        expect(page).to have_link('Amy')
      end
    end

    it 'user unfollowed from profile page' do
      click_link 'Amy'
      click_link 'Unfollow'
      expect(page).to have_content('Successfully unfollowed user.')
      click_link 'Profile'

      within("h2.following") do
        expect(page).to_not have_link('Amy')
      end
    end

    it 'user unfollowed from goal page' do
      click_link 'Learn to play the piano.'
      click_link 'Unfollow'
      expect(page).to have_content('Successfully unfollowed user.')
      click_link 'Profile'

      within("h2.following") do
        expect(page).to_not have_link('Amy')
      end
    end
  end
end
