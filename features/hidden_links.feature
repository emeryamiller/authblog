Feature: Hidden Links
	In order to clean up the user experience
	As the system
	I want to hide links from users who can't act on them

	Background:
		Given there are the following users:
			| email           | password | admin |
			| user@posts.com  | password | false |
			| admin@posts.com | password | true  |
		And there is a post called "I am good"
		Given I am on the homepage

	Scenario: New post link is hidden from non-signed-in users
		Then I should not see the "New Post" link

	Scenario: Edit post link is hidden from non-signed-in users
		When I follow "I am good"
		Then I should not see the "Edit" link

	Scenario: Delete post link is hidden from non-signed-in users
		When I follow "I am good"
		Then I should not see the "Delete" link

	Scenario: New post link is hidden for signed-in users
		And I am signed in as "user@posts.com"
		Then I should not see the "New Post" link

	Scenario: Edit post link is hidden for signed-in users
		And I am signed in as "user@posts.com"
		When I follow "I am good"
		Then I should not see the "Edit" link

	Scenario: Delete post link is hidden for signed-in users
		And I am signed in as "user@posts.com"
		When I follow "I am good"
		Then I should not see the "Delete" link

	Scenario: New post link is shown to admins
		And I am signed in as "admin@posts.com"
		Then I should see the "New Post" link

	Scenario: Edit post link is shown to admins
		And I am signed in as "admin@posts.com"
		When I follow "I am good"
		Then I should see the "Edit" link

	Scenario: Delete post link is shown to admins
		And I am signed in as "admin@posts.com"
		When I follow "I am good"
		Then I should see the "Delete" link

	
