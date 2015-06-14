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

  context 'returns success message when user followed' do
    before do
      @user = FactoryGirl.build(:user)
      @user.save
      sign_in(@user)
    end

    it 'from profile page' do
      click_link 'Amy'
      click_button 'Follow'
      expect(page).to have_content('Successfully followed user.')
      click_link 'Profile'

      within('ul.following') do
        expect(page).to have_link('Amy')
      end
    end

    it 'from goal page' do
      click_link 'Learn to play the piano.'
      click_button 'Follow'
      expect(page).to have_content('Successfully followed user.')
      click_link 'Profile'

      within('ul.following') do
        expect(page).to have_link('Amy')
      end
    end
  end

  context 'does not show follow link' do
    before do
      @user = FactoryGirl.build(:user)
      @user.save
      sign_in(@user)
    end

    it 'when already following user' do
      visit '/goals'
      click_link 'Amy'
      click_button 'Follow'
      expect(page).to_not have_button('Follow')
    end

    it 'on current user profile page' do
      visit '/goals'
      click_link 'Profile'
      expect(page).to_not have_button('Follow')
    end

    it 'on current user goal page' do
      create_goal('Study physics')
      expect(page).to_not have_button('Follow')
    end

    it 'when user not signed in' do
      click_link 'Sign Out'
      visit '/goals'
      click_link 'Learn to play the piano'
      expect(page).to_not have_button('Follow')
    end
  end
end
