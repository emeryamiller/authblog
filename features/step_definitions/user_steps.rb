Custom_link = "I don't use any of these services"

Given /^there are the following users:$/ do |table|
  table.hashes.each do |attr|
    @user = create_user(attr)
  end
end

Given /^I am (?:signed|logged) in as an admin$/ do 
  @user = create_user(email:"admin@posts.com", admin:true) 
  steps("Given I am signed in as them")
end

Given /^I am (?:signed|logged) in as "([^\"]*)"$/ do |email|
  @user = User.find_by_email(email)
  @user = create_user(email:email) unless @user
  steps("Given I am signed in as them")
end

Given /^I am (?:signed|logged) in as them$/ do 
  steps(%Q{
  Given I am on the homepage
  When I follow "Sign in"
  When I follow "#{Custom_link}"
  And I fill in "Email" with "#{@user.email}"
  And I fill in "Password" with "password"
  And I press "Sign in"
  Then I should see "Signed in successfully."
  })
end

Given /^user's "([^\"]*)" account is invalid$/ do |service|
  add_invalid_oa_mock(service)
end

Then /^I should (not )?see custom sign in link$/ do |negation|
 steps(%Q{Then I should #{negation}see "#{Custom_link}"})
end

When /^I follow custom sign in link$/ do
  steps(%Q{When I follow "#{Custom_link}"}) 
end

