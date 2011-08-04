Feature: Creating blog posts
	In order to create a blog post
	As a blog owner
	I want to create them easily

	Background:
		Given there are the following users:
			| email           | password | admin |
			| admin@posts.com | password | true  |
			| userA@posts.com | password | true  |
			| userB@posts.com | password | true  |
		And I am signed in as "admin@posts.com"
        Given there are the following groups:
            | name  | members         |
            | Alpha | userA@posts.com |
            | Beta  | userB@posts.com |
		And I am on the homepage
		When I follow "New Post"

	Scenario: Creating a post
		And I fill in "Title" with "Interesting post"
		And I fill in "Blog" with "Some text"
		And I press "Create Post"
		Then I should see "Post has been created."
		And I should be on the post page for "Interesting post"
		And I should see "Interesting post"
		And I should see "Draft"
        And I should see "Viewable by everyone"

	Scenario: Creating a published post without a title
		And I uncheck "Draft"
		And I press "Create Post"
		Then I should see "Post has not been created."
		And I should see "Title can't be blank"

	Scenario: Creating a published post without some content
		And I uncheck "Draft"
		And I fill in "Title" with "Another post"
		And I press "Create Post"
		Then I should see "Post has not been created."
		And I should see "Blog can't be blank"

	Scenario: Creating a published post 
		And I uncheck "Draft"
		And I fill in "Title" with "Another post"
		And I fill in "Blog" with "Some content"
		And I press "Create Post"
		Then I should see "Post has been created."
        And I should see "Viewable by everyone"
		And I should not see "Draft"

    Scenario: Creating a published post with a group assigned
		And I uncheck "Draft"
		And I fill in "Title" with "Another post"
		And I fill in "Blog" with "Some content"
        And I check "Alpha"
		And I press "Create Post"
		Then I should see "Post has been created."
        Then I should see "Viewable by groups"
        Then I should see "Alpha"

    Scenario: Creating a published post with multiple groups assigned
		And I uncheck "Draft"
		And I fill in "Title" with "Another post"
		And I fill in "Blog" with "Some content"
        And I check "Alpha"
        And I check "Beta"
		And I press "Create Post"
		Then I should see "Post has been created."
        Then I should see "Viewable by groups"
        Then I should see "Alpha"
        Then I should see "Beta"

