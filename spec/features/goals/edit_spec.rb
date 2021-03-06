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
    it 'on Goal page' do
      edit_goal
    end
  end

  context 'link is present and working for admin' do
    it 'on Goal page' do
      click_link 'Sign Out'
      other_user("admin")
      click_link 'Learn to paint'
      edit_goal
    end
  end

  it 'returns success message on marking complete' do
    click_link 'Mark as Completed.'
    expect(page).to have_content("Goal has been marked as completed!")
  end

  it 'returns notice on marking incomplete' do
    click_link 'Mark as Completed.'
    click_link 'Goal Completed.'
    expect(page).to have_content("Goal has been marked as incomplete.")
  end

  it 'does not show mark as complete for other user' do
    click_link 'Sign Out'
    other_user("friend")
    click_link 'Learn to paint'
    expect(page).not_to have_content('Mark as Completed')
  end
end
