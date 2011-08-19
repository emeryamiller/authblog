Feature: Signing in with multiple ids
	In order to use the site
	As a user
	I want to be able to sign in with multiple ids for a single user

	Background:
		Given there are the following users:
			| email           | provider |
			| user@posts.com  |          |
			| user2@posts.com |          |
            | user@gmail.com  | google   |
            | user@yahoo.com  | yahoo    |

	Scenario: Signing in via a form first
		And I am on the homepage
		When I follow "Sign in"
        When I follow "Custom"
		And I fill in "Email" with "user@posts.com"
		And I fill in "Password" with "password"
		And I press "Sign in"
		Then I should see "Signed in successfully."
        Then I should not see "Sign in"
        Then I follow "Account"
        Then I should not see "Custom"
        Given I will sign in as "user2@gmail.com" through the "Google" service
        When I follow "Google"
        Then I should see "Successfully authorized from Google account."
        Then I should see the service "Google"
        Then I should not see a link to the "Google" service
        Given I will sign in as "user2@yahoo.com" through the "Yahoo" service
        When I follow "Yahoo"
        Then I should see "Successfully authorized from Yahoo account."
        Then I should see the service "Yahoo"
        Then I should not see a link to the "Yahoo" service
        When I follow "Sign out"
        When I follow "Sign in"
        When I follow "Google"
        Then I should see "Successfully authorized from Google account."
        Then I should not see "You have to confirm your account before continuing."
        Then I should see "Posts"
        When I follow "Sign out"
        When I follow "Sign in"
        When I follow "Yahoo"
        Then I should see "Successfully authorized from Yahoo account."
        Then I should not see "You have to confirm your account before continuing."
        Then I should see "Posts"

    Scenario: Signing in via external provider first
        And I am on the homepage
		When I follow "Sign in"
        Then I should see "Custom"
        When I follow "Google"
        Then I should see "Successfully authorized from Google account."
        Then I should see "Signed in as user@gmail.com"
        Then I should not see "Custom"
        Then I follow "Account"
        Then I should see the service "Google"
        Then I should not see a link to the "Google" service
        Then I should not see "You have to confirm your account before continuing."
        When I follow "Yahoo"
        Then I should see "Successfully authorized from Yahoo account."
        Then I should see "Signed in as user@gmail.com"
        Then I should see the service "Yahoo"
        Then I should not see a link to the "Yahoo" service
        Then I should not see "You have to confirm your account before continuing."

