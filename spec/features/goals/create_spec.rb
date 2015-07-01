require 'rails_helper'

describe "Creating goal" do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
  end

  # check if private goal shows up for admin or friend on profile page
  def private_goal(user)
    create_goal("Learn to paint", "true")
    create_goal("Play the piano")
    click_link 'Sign Out'
    other_user(user)
    click_link 'Wilbur'
  end

  it "redirects to the goal page on success" do
    create_goal("Learn to paint")
    expect(page).to have_content("Learn to paint")
  end

  it "returns error message when description is blank" do
    create_goal(" ")
    expect(page).to have_content("Description can't be blank")
  end

  context "checked private doesn't show up" do
    it "on front page" do
      create_goal("Learn to paint", "true")
      visit "/goals"
      expect(page).not_to have_content("Learn to paint")
    end

    it "on profile page for other users" do
      private_goal("friend")
      expect(page).not_to have_content("Learn to paint")
    end
  end

  it "checked private shows up on user profile page for admin" do
    private_goal("admin")
    expect(page).to have_content("Learn to paint")
  end
end
