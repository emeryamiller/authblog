Feature: Editing users
	In order to edit users in the system
	As an admin
	I want to be able to edit them through the backend

	Background:
		Given there are the following users:
			| email			| password | admin|
			| admin@posts.com| password| true |
			| user@posts.com| password | false|
		And I am signed in as "admin@posts.com"
		Given I am on the homepage
		When I follow "Admin"
		And I follow "Users"
		And I follow "user@posts.com"
		And I follow "Edit"

	Scenario: Editing a new user
		And I fill in "Email" with "new_guy@posts.com"
		And I press "Update User"
		Then I should see "User has been updated."
		And I should see "new_guy@posts.com"
		And I should not see "user@posts.com"

	Scenario: Update with an invalid email
		And I fill in "Email" with "fakefakefake"
		And I press "Update User"
		Then I should see "User has not been updated."
		And I should see "Email is invalid"
