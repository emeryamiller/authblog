Feature: Creating groups
	In order to create administrative groups
	As an admin
	I want to be able to administer them

	Background:
		Given there are the following users:
			| email             | password | admin |
			| admin@posts.com   | password | true  |
            | family@posts.com  | password | false |
            | family2@posts.com | password | false |
		And I am signed in as "admin@posts.com"
        Given there are the following groups:
            | name    | member            |
            | Utility | family2@posts.com |
		And I am on the homepage
        When I follow "Admin"
		And I follow "Groups"
        Then I should see "Utility"
        And I follow "New Group"

	Scenario: Creating a group
        And I fill in "Name" with "Family"
        And I press "Create Group"
        Then I should see "Group has been created."
        Then I should see "Family"

    Scenario: Assigning a user
        And I fill in "Name" with "Family"
        When I check "family@posts.com"
        And I press "Create Group"
        Then I should see "Group has been created."
        Then I should see "Family"

    Scenario: Leaving fields blank
        And I press "Create Group"
        Then I should see "Group has not been created."
        And I should see "Name can't be blank"
		
	
	
