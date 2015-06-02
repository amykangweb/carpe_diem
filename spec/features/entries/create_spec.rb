require 'rails_helper'
require 'support/test_helpers'

describe "Creating entry items" do
  before do
    sign_in
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
