module SignUpSteps
  step 'I go to the sign up page' do
    FactoryGirl.create(:server, :name => 'KGS')
    visit signup_path
    find('form#new_user').should be_true
  end

  step 'I sign up with :username, :email, :password and :handle' do |username, email, password, handle|
    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    # TODO: replace this handle with user_handle, using a presenter
    fill_in 'user_accounts_attributes_0_handle', with: password
    click_button('Sign Up')
  end

  step 'I should be signed in' do
    page.has_content?('My Profile')
  end
end
