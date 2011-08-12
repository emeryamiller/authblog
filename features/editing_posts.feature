Feature: Editing posts
	In order to update post information
	As a user
	I want to be able to do that through an interface

	Background:
		Given there are the following users:
			| email           | admin |
			| admin@posts.com | true  |
		And I am signed in as them
		Given there is a post called "A post"
		And I am on the homepage
		When I follow "A post"
		And I follow "Edit"

	Scenario: Updating a post
		And I fill in "Title" with "An even better post"
		And I press "Update Post"
		Then I should see "Post has been updated."
		Then I should be on the post page for "An even better post"

	Scenario: Updating a post with invalid attributes
		And I fill in "Title" with ""
		And I press "Update Post"
		Then I should see "Post has not been updated."
