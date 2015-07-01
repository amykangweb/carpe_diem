def create_goal(description=nil, private=false)
  visit '/goals'
  click_link "New Goal"
  expect(page).to have_content("New Goal")

  fill_in "Description", with: description
  find(:css, "#private").set(private)
  click_button "Create Goal"
end

def create_entry(content=nil)
  click_link "New Entry"
  expect(page).to have_content("New Entry")

  fill_in "Content", with: content
  click_button "Create Entry"
end

def create_comment(content=nil)
  click_link 'View Entry'
  fill_in 'Comment', with: content
  click_button 'Create Comment'
end
