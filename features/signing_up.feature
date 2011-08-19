Feature: Signing up
	In order to be attributed for my comments and posts
	As a user
	I want to be able to sign up

    Background:
		Given I am on the homepage
        When I follow "Sign in"
      
	Scenario: Signing up through this website
        When I follow custom sign in link
        And I follow "Sign up"
		When I fill in "Email" with "user@posts.com"
		And I fill in "Password" with "password"
		And I fill in "Password confirmation" with "password"
		And I press "Sign up"
		Then I should see "You have signed up successfully."
        Then I should see "However, we could not sign you in because your account is unconfirmed."

    Scenario: Signing up through a service (google)
        Given I will login as "user@gmail.com" through the "Google" service
        When I follow "Google"
        Then I should see "Successfully authorized from Google account"
        Then I should see "You have to confirm your account before continuing."
