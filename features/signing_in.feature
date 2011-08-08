Feature: Signing in
	In order to use the site
	As a user
	I want to be able to sign in

	Background:
		Given there are the following users:
			| email           | unconfirmed |
			| user@posts.com  | true        |
			| user2@posts.com | false       |
            | user@gmail.com  | false       |
            | user@yahoo.com  | false       |

	Scenario: Signing in via confirmation
		And "user@posts.com" opens the email with subject "Confirmation instructions"
		And they click the first link in the email
		Then I should see "Your account was successfully confirmed"
		Then I should see "Signed in as user@posts.com"

	Scenario: Signing in via a form
		And I am on the homepage
		When I follow "Sign in"
		And I fill in "Email" with "user2@posts.com"
		And I fill in "Password" with "password"
		And I press "Sign in"
		Then I should see "Signed in successfully."
        When I follow "Sign out"
        Then I should see "Signed out successfully."
        Then I should see "Sign in"

    Scenario: Signing in via Google
        And I am on the homepage
        When I follow "Sign in with Google"
        Then I should see "Successfully authorized from Google account."
        Then I should see "Signed in as user@gmail.com"
	
    Scenario: Signing in via Yahoo
        And I am on the homepage
        When I follow "Sign in with Yahoo"
        Then I should see "Successfully authorized from Yahoo account."
        Then I should see "Signed in as user@yahoo.com"
	
    Scenario: Signing in via Google invalid id
        Given user's "google" account is invalid
        And I am on the homepage
        When I follow "Sign in with Google"
        Then I should see "Could not authorize you from Google because" 
        Then I should see "Invalid credentials"
        Then I should see "Sign in"
        
