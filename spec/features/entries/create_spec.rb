require 'rails_helper'
require 'support/test_helpers'

describe "Creating entry items" do
  # subject(:goal) { Goal.create(description: "Learn to paint") }

  it "redirects to goal page upon successful creation" do
    sign_in
    create_goal
    click_link "New Entry"
    fill_in "Content", with: "Bought brushes"
    click_button "Create Entry"
    expect(page).to have_content("Entry was successfully created.")

    within("ul.entries") do
      expect(page).to have_content("Bought brushes")
    end
  end
end
