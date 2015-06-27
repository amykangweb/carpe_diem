require 'rails_helper'

describe 'Edit Comment' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
    create_entry('Buy brushes')
    create_comment('Cool!')
  end

  # other users and admins navigate to @user entry page
  def check_others(method)
    click_link 'Sign Out'
    send(method)
    click_link 'Learn to paint'
    click_link 'View Entry'
  end

  # edit the comment
  def edit_comment
    within('.comments') do
      click_link 'Edit'
    end
    fill_in 'Comment', with: 'Wow!'
    click_button 'Update Comment'
    expect(page).to have_content("Comment was successfully updated.")
    expect(page).not_to have_content('Cool!')
    expect(page).to have_content('Wow!')
  end

  context 'link is present and working' do
    it 'for comment owner' do
      edit_comment
    end

    it 'for admin' do
      check_others("create_admin")
      edit_comment
    end
  end

  it 'link is not present for other users' do
    check_others("other_user")

    within('.comments') do
      expect(page).not_to have_link('Edit')
    end
  end
end
