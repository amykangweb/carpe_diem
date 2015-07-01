require 'rails_helper'

describe 'Edit Goal' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
  end

  # edit the goal
  def edit_goal
    within(".control") do
      expect(page).to have_content('Edit')
      click_link 'Edit'
    end
    fill_in 'Description', with: 'Learn to draw'
    click_button 'Update Goal'
    expect(page).to have_content("Goal was successfully updated.")
    expect(page).to have_content('Learn to draw')
  end

  context 'link is present and working for goal user' do
    it 'on Profile page' do
      click_link 'Profile'
      edit_goal
    end

    it 'on Goal page' do
      edit_goal
    end
  end

  context 'link is present and working for admin' do
    it 'on Profile page' do
      click_link 'Sign Out'
      other_user("admin")
      click_link 'Wilbur'
      edit_goal
    end

    it 'on Goal page' do
      click_link 'Sign Out'
      other_user("admin")
      click_link 'Learn to paint'
      edit_goal
    end
  end
end
