Feature: Deleting users
	In order to delete users in the system
	As an admin
	I want to be able to delete them through the backend

	Background:
		Given there are the following users:
			| email           | admin |
			| admin@posts.com | true  |
			| user@posts.com  | false |
		And I am signed in as "admin@posts.com"
		Given I am on the homepage
		When I follow "Admin"
		And I follow "Users"

	Scenario: Deleting a user
		And I follow "user@posts.com"
		And I follow "Delete"
		Then I should see "User has been deleted."
		And I should not see "user@posts.com"

	Scenario: Deleting the current user fails
		And I follow "admin@posts.com"
		And I follow "Delete"
		Then I should see "You cannot delete yourself."
