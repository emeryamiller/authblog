Feature: Editing groups
	In order to edit groups in the system
	As an admin
	I want to be able to edit them through the backend

	Background:
		Given there are the following users:
			| email            | admin |
			| admin@posts.com  | true  |
			| userA@posts.com  | false |
			| userB@posts.com  | false |
		And I am signed in as "admin@posts.com"
        Given there are the following groups:
            | name  | members                          |
            | Alpha | userA@posts.com                  |
            | Beta  | userB@posts.com                  |
            | Omega | userA@posts.com, userB@posts.com |
		Given I am on the homepage
		When I follow "Admin"
		And I follow "Groups"
		And I follow "Alpha"
		And I follow "Edit"

	Scenario: Editing a new group
		And I fill in "Name" with "Deuterium"
		And I press "Update Group"
		Then I should see "Group has been updated."
		And I should see "Deuterium"
		And I should not see "Alpha"

	Scenario: Update with an already existing name
		And I fill in "Name" with "Beta"
		And I press "Update Group"
		Then I should see "Group has not been updated."
		And I should see "Name has already been taken"

    Scenario: Update a group to have different users
        And I check "userB@posts.com"
        And I check "admin@posts.com"
        And I uncheck "userA@posts.com"
        And I press "Update Group"
        Then I should see "Group has been updated."
        And I should see "admin@posts.com"
