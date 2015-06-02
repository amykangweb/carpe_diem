require 'rails_helper'
require 'support/test_helpers'

describe "Creating goal" do
  before do
    sign_in
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
