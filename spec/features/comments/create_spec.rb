require 'rails_helper'
require 'support/test_helpers'

describe "Comments" do
  before do
    create_friend
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
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
    create_comment('Me too.')
    expect(page).to have_content('You need to sign in or sign up before
    continuing.')
  end
end
