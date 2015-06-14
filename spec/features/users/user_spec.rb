require 'rails_helper'
require 'support/test_helpers'

describe 'User' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
  end

  def sign_up(username=nil)
    visit '/goals'
      click_link 'Sign Up'
      fill_in 'Username', with: username
      fill_in 'Email', with: 'fake@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
  end

  context 'gets error message' do
    it 'when username is blank on sign up' do
      sign_up(' ')
      expect(page).to have_content("Username can't be blank")
    end

    it 'when username is already taken' do
      sign_up('Wilbur')
      expect(page).to have_content('Username has already been taken')
    end
  end

  it 'redirects to home page on successful sign in' do
    sign_in(@user)
    expect(page).to have_content('Signed in successfully.')
  end
end
