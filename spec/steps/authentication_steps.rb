module AuthenticationSteps
  step 'I should be signed in' do
    page.has_content?('My Profile').should be_true
  end

  step 'I should not be signed in' do
    page.has_content?('My Profile').should be_false
  end
end