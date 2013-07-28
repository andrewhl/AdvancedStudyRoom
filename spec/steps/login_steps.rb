module LoginSteps
  step 'I go to the login page' do
    visit login_path
    find('form#new_user_session').should be_true
  end

  step 'I login with :email and :password' do |email, password|
    FactoryGirl.create(:user, email: email, password: password, password_confirmation: password)
    fill_in 'user_session_login', with: email
    fill_in 'user_session_password', with: password
    click_button 'Log In'
  end

end