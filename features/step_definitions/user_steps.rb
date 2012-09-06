Given /^I fill out the signup form$/ do
  visit signup_path
  fill_in "Email", :with => "good@example.com"
  fill_in "Password", :with => "foobar"
  fill_in "Password confirmation", :with => "foobar"
  click_button "Sign Up"
end

Then /^my user account should be created$/ do
  step "I fill out the signup form"
  expect { FactoryGirl.create(:user) }.to change(User, :count).by(1)
  # expect { step "I fill out the signup form" }.to change(User, :count).by(1)
end

Then /^I should be logged in$/ do
  step "I fill out the signup form"
  visit root_path
  page.should have_content("Logged in as")
end

Given /^I visit the home page before signing up$/ do
  visit root_path
end

Then /^I should not be logged in$/ do
  step "I visit the home page before signing up"
  page.should_not have_content("Logged in as")
end

Given /^I am signed in$/ do
  visit root_path
  click_link "Log In"
  fill_in "Email", :with => "good@example.com"
  fill_in "Password", :with => "foobar"
  click_button "Log In"
  visit root_path
  page.should have_content("Logged in as")
end

When /^I sign out$/ do
  step "I am signed in"
  visit root_path
  click_link "Log Out"
end

Then /^I should be taken to the home page$/ do
  step "I should be logged in"
  step 'I sign out'
  page.should have_content(flash[:notice])
end

Then /^I should be logged out$/ do
  pending # express the regexp above with the code you wish you had
end