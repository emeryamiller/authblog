Feature: Creating blog posts
	In order to create a blog post
	As a user
	I want to create them easily

	Background:
		Given I am on the homepage
		When I follow "New Post"

	Scenario: Creating a post
		And I fill in "Title" with "Interesting post"
		And I fill in "Blog" with "Some text"
		And I press "Create Post"
		Then I should see "Post has been created."
		And I should be on the post page for "Interesting post"
		And I should see "Interesting post"

	Scenario: Creating a post without a title
		And I press "Create Post"
		Then I should see "Post has not been created."
		And I should see "Title can't be blank"

