Feature: Signing in
	In order to use the site
	As a user
	I want to be able to sign in
    # Need to add authorization by admin

	Background:
		Given there are the following users:
			| email           | unconfirmed | provider |
			| user@posts.com  | true        |          |
			| user2@posts.com | false       |          |
            | user@gmail.com  | false       | google   |
            | user2@yahoo.com | true        | yahoo    |
            | user@yahoo.com  | false       | yahoo    |
        
	Scenario: Signing in via confirmation
		And "user@posts.com" opens the email with subject "Confirmation instructions"
		And they click the first link in the email
		Then I should see "Your account was successfully confirmed"
		Then I should see "Signed in as user@posts.com"

	Scenario: Signing in via a form
		And I am on the homepage
		When I follow "Sign in"
        When I follow custom sign in link
		And I fill in "Email" with "user2@posts.com"
		And I fill in "Password" with "password"
		And I press "Sign in"
		Then I should see "Signed in successfully."
        Then I should not see "Sign in"
        When I follow "Sign out"
        Then I should see "Signed out successfully."
        Then I should see "Sign in"

    Scenario: Signing in via Google
        And I am on the homepage
		When I follow "Sign in"
        When I follow "Google"
        Then I should see "Successfully authorized from Google account."
        Then I should see "Signed in as user@gmail.com"
        Then I should not see "Sign in"
	
    Scenario: Signing in via Yahoo
        And I am on the homepage
		When I follow "Sign in"
        When I follow "Yahoo"
        Then I should see "Successfully authorized from Yahoo account."
        Then I should see "Signed in as user@yahoo.com"
        Then I should not see "Sign in"
	
    Scenario: Signing in via Google invalid id
        Given user's "google" account is invalid
        And I am on the homepage
		When I follow "Sign in"
        When I follow "Google"
        Then I should see "Could not authorize you from Google because" 
        Then I should see "Invalid credentials"
        Then I should see "Sign in"

    Scenario: Signing in via confirmation
        Given I will sign in as "user2@yahoo.com" through the "Yahoo" service
        And I am on the homepage
        When I follow "Sign in"
        And I follow "Yahoo"
        Then I should see "Sign in"
        Then I should see "You have to confirm your account before continuing."
        And "user2@yahoo.com" opens the email with subject "Confirmation instructions"
        And they click the first link in the email
        # TODO - Ensure the confirmation flash message appears even for service logins
        #Then I should see "Your account was successfully confirmed"
        Then I should see "Signed in as user2@yahoo.com"
