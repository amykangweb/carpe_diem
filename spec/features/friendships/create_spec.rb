require 'rails_helper'

describe 'Friendships' do
  before do
    create_friend
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

      within('li.following') do
        click_link '1'
      end

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

    it 'when user not signed in' do
      click_link 'Sign Out'
      visit '/goals'
      click_link 'Amy'
      expect(page).to_not have_button('Follow')
    end
  end
end
