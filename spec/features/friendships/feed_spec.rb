require 'rails_helper'

describe 'Friendships' do
  before do
    create_friend
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    click_link 'Amy'
    click_button 'Follow'
  end

  it 'creates activity feed of friend when following' do
    click_link 'Profile'
    click_link 'Activity Feed'
    expect(page).to have_content('Buy a piano.')
    expect(page).to have_content('Learn to play the piano.')
  end

  it 'removes acitivity feed of friend when unfollowed' do
    visit '/goals'
    click_link 'Amy'
    click_button 'Unfollow'
    click_link 'Profile'
    click_link 'Activity Feed'
    expect(page).to_not have_content('Buy a piano.')
    expect(page).to_not have_content('Learn to play the piano.')
  end
end
