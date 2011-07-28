Feature: Viewing posts
	In order to find a post
	As a user
	I want to be able to see a list of posts

    Background:
		Given there is a post called "My post"
		Given there is a draft post called "My draft post"
		And I am on the homepage
        Then I should see "My post"
      
	Scenario: Listing all posts
		When I follow "My post"
		Then I should be on the post page for "My post"

	Scenario: Listing shouldn't show draft posts for public users
		Then I should not see "My draft post"

	Scenario: Listing should show draft posts for admins
        Given I am signed in as an admin
		When I follow "My draft post"
		Then I should be on the post page for "My draft post"

