# Given /^I am an admin$/ do
#   @admin_user = FactoryGirl.create(:admin)
#   @admin_user.should be_valid
# end

# Then /^I should be able to login as an admin$/ do
#   visit root_path
#   click_link "Log In"
#   fill_in "Email", with: "admin@admin.com"
#   fill_in "Password", with: "foobar"
#   click_button "Log In"
#   page.should have_content("Logged in")
# end

