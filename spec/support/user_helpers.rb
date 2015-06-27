def sign_in(user)
  visit '/goals'
  click_link "Sign In"

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def other_user
  @user2 = FactoryGirl.build(
    :user,
    username: 'Amy',
    email: 'amy@mail.com',
    password: 'password'
    )
  @user2.save
  sign_in(@user2)
end

def create_friend
  other_user
  create_goal('Learn to play the piano.')
  create_entry('Buy a piano.')
  click_link 'Sign Out'
end

def create_admin
  @user3 = FactoryGirl.build(
    :user,
    username: 'Admin',
    email: 'admin@mail.com',
    password: 'password',
    admin: true
  )
  @user3.save
  sign_in(@user3)
end
