def sign_in(user)
  visit '/goals'
  click_link "Sign In"

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def create_friend
  @user2 = FactoryGirl.build(:user, username: 'Amy', email: 'amy@mail.com',
                              password: 'password')
  @user2.save
  sign_in(@user2)
  create_goal('Learn to play the piano.')
  create_entry('Buy a piano.')
  click_link 'Sign Out'
end

def create_goal(description=nil)
  visit '/goals'
  click_link "New Goal"
  expect(page).to have_content("New Goal")

  fill_in "Description", with: description
  click_button "Create Goal"
end

def create_entry(content=nil)
  click_link "New Entry"
  expect(page).to have_content("New Entry")

  fill_in "Content", with: content
  click_button "Create Entry"
end
