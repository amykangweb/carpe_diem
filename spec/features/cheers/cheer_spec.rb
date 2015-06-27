require 'rails_helper'

describe 'Cheering entries' do
  before do
    create_friend
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Find a job')
    create_entry('Fill out applications')
  end

  it 'redirects to sign in page if not signed in' do
    click_link 'Sign Out'
    click_link 'Find a job'
    click_link '0 cheers'
    expect(page).to have_content('You need to sign in or sign up before
      continuing.')
  end

  it 'updates entry with cheer count and success message' do
    click_link '0 cheers'
    expect(page).to have_content('1 cheers')
    expect(page).to have_content('Thank you for cheering!')
  end

  context 'from view entry page' do
    it 'updates entry page with cheer count and username' do
      visit '/goals'
      click_link 'Learn to play the piano.'
      click_link 'View Entry'
      click_link '0 cheers'
      expect(page).to have_content('1 cheers')
      expect(page).to have_content('Wilbur cheered this.')
    end
  end
end
