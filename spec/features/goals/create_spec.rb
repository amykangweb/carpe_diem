require 'rails_helper'
require 'support/test_helpers'

describe "Creating goal" do

  it "redirects to the goal page on success" do
    sign_in
    create_goal
    expect(page).to have_content("Learn to paint")
  end
end
