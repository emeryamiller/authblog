Feature: Deleting posts
	In order to remove posts
	As a content author
	I want to make them disappear

	Scenario: Deleting a post
		Given there are the following users:
			| email           | password | admin |
			| admin@posts.com | password | true  |
		And I am signed in as them
		Given there is a post called "A bad post"
		And I am on the homepage
		When I follow "A bad post"
		And I follow "Delete"
		Then I should see "Post has been deleted."
		Then I should not see "A bad post"
