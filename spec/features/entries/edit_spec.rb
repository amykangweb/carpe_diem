require 'rails_helper'

describe 'Edit Entry' do
  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in(@user)
    create_goal('Learn to paint')
    create_entry('Buy brushes')
  end

  # edit the entry
  def edit_entry(element)
    within(element) do
      click_link 'Edit'
    end
    fill_in 'Content', with: 'Buy paint'
    click_button 'Update Entry'
    expect(page).to have_content("Entry was successfully updated.")
    expect(page).not_to have_content('Buy brushes')
    expect(page).to have_content('Buy paint')
  end

  context 'link is present and working on goal page' do
    it 'for entry owner' do
      edit_entry(".entries")
    end

    it 'for admin' do
      click_link 'Sign Out'
      create_admin
      click_link 'Learn to paint'
      edit_entry(".entries")
    end
  end

  context "link is present and working on entry page" do
    it 'for entry owner' do
      click_link 'View Entry'
      edit_entry(".control")
    end

    it 'for admin' do
      click_link 'Sign Out'
      create_admin
      click_link 'Learn to paint'
      click_link 'View Entry'
      edit_entry(".control")
    end
  end
end
