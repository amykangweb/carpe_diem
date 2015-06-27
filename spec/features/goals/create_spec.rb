require 'rails_helper'

describe "Creating goal" do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
  end

  it "redirects to the goal page on success" do
    create_goal("Learn to paint")
    expect(page).to have_content("Learn to paint")
  end

  it "returns error message when description is blank" do
    create_goal(" ")
    expect(page).to have_content("Description can't be blank")
  end
end
