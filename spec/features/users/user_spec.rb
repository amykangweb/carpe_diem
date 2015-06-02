require 'rails_helper'
require 'support/test_helpers'

describe "User" do
  context "gets error message" do
    it "when username is blank on sign up" do
      visit '/goals'
      click_link 'Sign Up'
      fill_in 'Username', with: ' '
      fill_in 'Email', with: 'fake@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content("Username can't be blank")
    end
  end

  it "redirects to home page on successful sign in" do
    sign_in
    expect(page).to have_content("Signed in successfully.")
  end
end
