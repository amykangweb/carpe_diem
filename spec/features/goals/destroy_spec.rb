require 'rails_helper'

describe 'Destroy Goal' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
  end

  # other users and admins navigate to @user profile and goal pages
  def check_others(user)
    click_link 'Sign Out'
    other_user(user)
    click_link 'Wilbur'
  end

  # destroy the goal
  def destroy_goal
    expect(page).to have_content('Destroy')
    click_link 'Destroy'
    expect(page).to have_content("Goal was successfully destroyed.")
    expect(page).not_to have_content('Learn to paint')
  end

  context 'link is present and working for goal user' do
    it 'on Profile page' do
      click_link 'Profile'
      destroy_goal
    end

    it 'on Goal page' do
      destroy_goal
    end
  end

  context 'link is present and working for admin' do
    it 'on Profile page' do
      check_others("admin")
      destroy_goal
    end

    it 'on Goal page' do
      check_others("admin")
      click_link 'Learn to paint'
      destroy_goal
    end
  end

  context 'link is not present for other users' do
    it 'on Profile page' do
      check_others("friend")
      expect(page).not_to have_content('Destroy')
    end

    it 'on Goal page' do
      check_others("friend")
      click_link 'Learn to paint'
      expect(page).not_to have_content('Destroy')
    end
  end
end
