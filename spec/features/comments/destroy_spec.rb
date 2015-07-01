require 'rails_helper'

describe 'Destroy Comment' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
    create_entry('Buy brushes')
    create_comment('Cool!')
  end

  # other users and admins navigate to @user entry page
  def check_others(user)
    click_link 'Sign Out'
    other_user(user)
    click_link 'Learn to paint'
    click_link 'View Entry'
  end

  # destroy the comment
  def destroy_comment
    within('.comments') do
      click_link 'Destroy'
    end
    expect(page).to have_content("Comment was successfully destroyed.")
    expect(page).not_to have_content('Cool!')
  end

  context 'link is present and working' do
    it 'for entry owner' do
      destroy_comment
    end

    it 'for admin' do
      check_others("admin")
      destroy_comment
    end
  end

  it 'link is not present for other users' do
    check_others("friend")

    within('.comments') do
      expect(page).not_to have_link('Destroy')
    end
  end
end
