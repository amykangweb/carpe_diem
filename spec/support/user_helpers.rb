def sign_in(user)
  visit '/goals'
  click_link "Sign In"

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

# options admin or friend
def other_user(user)
  @user2 = FactoryGirl.build(user)
  @user2.save
  sign_in(@user2)
end

#options friend only
def create_friend
  other_user("friend")
  create_goal('Learn to play the piano.')
  create_entry('Buy a piano.')
  click_link 'Sign Out'
end
