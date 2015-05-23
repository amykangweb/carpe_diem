def sign_in
  user = FactoryGirl.build(:user)
  user.save

  visit '/goals'
  click_link "Sign In"

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def create_goal(options={})
  options[:description] = "Learn to paint"

  visit '/goals'
  click_link "New Goal"
  expect(page).to have_content("New Goal")

  fill_in "Description", with: options[:description]
  click_button "Create Goal"
end
