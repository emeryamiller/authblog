Given /^there are the following users:$/ do |table|
  table.hashes.each do |attr|
    unconfirmed = Boolean(attr.delete("unconfirmed"))
    admin = Boolean(attr.delete("admin"))
    attr.merge!(:password => "password") unless attr["passward"]
    @user = User.create!(
      attr.merge!(:password_confirmation => attr[:password])
    )
    @user.admin = true if admin
    @user.confirm! unless unconfirmed
    @user.save!
  end
end

Given /^I am (?:signed|logged) in as an admin$/ do 
  @user = User.create!({email:"admin@posts.com", password:"password", password_confirmation:"password" })
  @user.admin = true
  @user.confirm!
  @user.save!
  steps("Given I am signed in as them")
end

Given /^I am (?:signed|logged) in as "([^\"]*)"$/ do |email|
  @user = User.find_by_email(email)
  steps("Given I am signed in as them")
end

Given /^I am (?:signed|logged) in as them$/ do 
  steps(%Q{
  Given I am on the homepage
  When I follow "Sign in"
  And I fill in "Email" with "#{@user.email}"
  And I fill in "Password" with "#{@user.password||"password"}"
  And I press "Sign in"
  Then I should see "Signed in successfully."
  })
end
