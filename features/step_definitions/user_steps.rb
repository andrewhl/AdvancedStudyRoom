Given /^I am (?:a|an) (.+)$/ do |user_type|
  if user_type == "admin"
    @admin_user = FactoryGirl.create(:admin)
    @admin_user.should be_valid
  else
    @user = FactoryGirl.create(:user)
    @user.should be_valid
  end
end

Then /^I login as (?:a|an) (.+)$/ do |user_type|
  # binding.pry
  visit root_path
  click_link "Log In"
  if user_type == "admin"
    fill_in "Email", with: "admin@admin.com"
    fill_in "Password", with: "foobar"
  else
    fill_in "Email", with: "johndoe@example.com"
    fill_in "Password", with: "foobar"
  end
  click_button "Log In"
  # visit root_path
  page.should have_content("Logged in")
end

Then /^I should be able to logout$/ do
  step "I login as an admin"
  visit root_path
  click_link "Log Out"
  page.should have_content("Log In")
end

Then /^I can visit my home page$/ do
  visit user_path(@user)
end

When /^I visit the league registration page$/ do
  visit registration_path
end

Then /^I can signup for the league$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit the new account page$/ do
  visit new_account_path
end

Then /^I create an account$/ do
  fill_in "Handle", with: "kabradarf"
  fill_in "Rank", with: 3
  select 'KGS', from: "Server"
  binding.pry
  click_button "Create Account"
end

Then /^I signup for the league$/ do
  pending # express the regexp above with the code you wish you had
end