require 'rails_helper'

describe "Creating entry items" do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal("Learn to paint")
  end

  it "redirects to goal page upon successful creation" do
    create_entry("Bought brushes")
    expect(page).to have_content("Entry was successfully created.")

    within("ul.entries") do
      expect(page).to have_content("Bought brushes")
    end
  end

  it "returns error message when content is blank" do
    create_entry(" ")
    expect(page).to have_content("Content can't be blank")
  end
end
