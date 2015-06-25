require 'rails_helper'
require 'support/test_helpers'

describe "Comments" do
  before do
    create_friend
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
  end

  it "redirects to goal page upon successful creation" do
    visit '/goals'
    click_link 'Learn to play the piano.'
    fill_in 'Comment', with: 'Me too.'
    click_button 'Create Comment'
    expect(page).to have_content('Me too.')
  end

  it "shows error message when comment is blank" do
    visit '/goals'
    click_link 'Learn to play the piano.'
    fill_in 'Comment', with: ''
    click_button 'Create Comment'
    expect(page).to have_content("Comment can't be blank")
  end
end
