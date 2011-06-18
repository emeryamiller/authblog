Feature: Signing in
	In order to use the site
	As a user
	I want to be able to sign in

	Background:
		Given there are the following users:
			|email | password | unconfirmed |
			| user@posts.com | password | true |

	Scenario: Signing in via confirmation
		And "user@posts.com" opens the email with subject "Confirmation instructions"
		And they click the first link in the email
		Then I should see "Your account was successfully confirmed"
		Then I should see "Signed in as user@posts.com"
	
