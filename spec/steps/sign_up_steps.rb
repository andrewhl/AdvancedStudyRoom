module SignUpSteps
  step 'I go to the sign up page' do
    visit signup_path
    find('#new_user').should be_true
  end

  step 'I sign up with :email and :password' do |email, password|

  end

  step 'I should be signed in' do

  end
end