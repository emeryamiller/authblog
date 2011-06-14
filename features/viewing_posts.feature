Feature: Viewing posts
	In order to find a post
	As a user
	I want to be able to see a list of posts

	Scenario: Listing all posts
		Given there is a post called "My post"
		And I am on the homepage
		When I follow "My post"
		Then I should be on the post page for "My post"
