require 'rails_helper'

describe "Creating goal" do
  def create_goal(options={})
    options[:description] = "Learn to paint"

    visit '/goals'
    click_link "New Goal"
    expect(page).to have_content("New Goal")

    fill_in "Description", with: options[:description]
    click_button "Create Goal"
  end

  it "redirects to the goal page on success" do
    create_goal
    expect(page).to have_content("Learn to paint")
  end
end
