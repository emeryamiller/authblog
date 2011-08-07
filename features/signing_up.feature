Feature: Signing up
	In order to be attributed for my comments and posts
	As a user
	I want to be able to sign up

    Background:
		Given I am on the homepage
		When I follow "Sign up"
      
	Scenario: Signing up through this website
		And I fill in "Email" with "user@posts.com"
		And I fill in "Password" with "password"
		And I fill in "Password confirmation" with "password"
		And I press "Sign up"
		Then I should see "You have signed up successfully."


