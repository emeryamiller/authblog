Feature: Creating groups
	In order to create administrative groups
	As an admin
	I want to be able to administer them

	Background:
		Given there are the following users:
			| email             | admin |
			| admin@posts.com   | true  |
            | family@posts.com  | false |
            | family2@posts.com | false |
            | family3@posts.com | false |
		And I am signed in as "admin@posts.com"
        Given there are the following groups:
            | name    | members           |
            | Utility | family2@posts.com |
		And I am on the homepage
        When I follow "Admin"
		And I follow "Groups"
        Then I should see "Utility"
	    Then I should see "family2@posts.com"
        And I should not see "family@posts.com"
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
        Then I should see "family@posts.com"

    Scenario: Leaving fields blank
        And I press "Create Group"
        Then I should see "Group has not been created."
        And I should see "Name can't be blank"
		
    Scenario: I can add multiple users to a group at once
        And I fill in "Name" with "Family"
        When I check "family@posts.com"
        When I check "family3@posts.com"
        And I press "Create Group"
        Then I should see "Group has been created."
        Then I should see "Family"
        Then I should see "family@posts.com"
        Then I should see "family3@posts.com"
