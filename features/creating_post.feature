Feature: Creating blog posts
	In order to create a blog post
	As a user
	I want to create them easily

	Scenario: Creating a post
		Given I am on the homepage
		When I follow "New Post"
		And I fill in "Title" with "Interesting post"
		And I fill in "Blog" with "Some text"
		And I press "Create Post"
		Then I should see "Post has been created."
		And I should be on the post page for "Interesting post"
		And I should see "Interesting post"

