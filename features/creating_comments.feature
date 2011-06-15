Feature: Creating comments
	In order to create a comment for a post
	As a user
	I want to be able to select a post and add a comment

	Background:
		Given there is a post called "An interesting post"
		And I am on the homepage
		When I follow "An interesting post"
		And I follow "Add Comment"

	Scenario:
		When I fill in "Comment" with "Cool post"
		And I fill in "Nickname" with "me"
		And I press "Create Comment"
		Then I should see "Comment has been added."

	Scenario:
		When I press "Create Comment"
		Then I should see "Comment has not been created."
		And I should see "Comment can't be blank"
		And I should see "Nickname can't be blank"
