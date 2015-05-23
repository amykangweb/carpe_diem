require 'rails_helper'
require 'support/test_helpers'

describe "Creating user" do

  it "redirects to home page on successful sign in" do
    sign_in
    expect(page).to have_content("Signed in successfully.")
  end
end
