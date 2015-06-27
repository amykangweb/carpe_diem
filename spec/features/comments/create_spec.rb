require 'rails_helper'

describe "Comments" do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
    create_entry('Buy brushes')
  end

  it "page shows comment when valid comment" do
    create_comment('Me too.')
    expect(page).to have_content('Me too.')
  end

  it "shows error message when comment is blank" do
    create_comment('')
    expect(page).to have_content("Comment can't be blank")
  end

  it "redirects to sign in page when user not signed in" do
    click_link 'Sign Out'
    click_link 'Learn to paint'
    create_comment('Me too.')
    expect(page).to have_content('You need to sign in or sign up before
    continuing.')
  end
end
