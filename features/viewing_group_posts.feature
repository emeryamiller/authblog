Feature: Viewing group posts 
    In order to view posts created for a group
    As a user
    I should be able to view the posts I'm authorized to see

    Background:
        Given there are the following users:
            | email           | admin |
            | usera@posts.com | false |
            | userb@posts.com | false |
            | user@posts.com  | false |
            | admin@posts.com | true  |

        Given there are the following groups:
            | name | members         |
            | A    | usera@posts.com |
            | B    | userb@posts.com |

        Given there are the following posts:
            | title         | group | draft |
            | For group A   | A     | false |
            | For group B   | B     | false |
            | For groups AB | B, A  | false |
            | For everyone  |       | false |
            | In draft mode |       | true  |

        And I am on the homepage    
        
	Scenario: Listing should show group A users their posts
        And I am logged in as "usera@posts.com"
		Then I should see "For group A"
		Then I should see "For groups AB"
		Then I should not see "For group B"
		Then I should not see "In draft mode"
        Then I should see "For everyone"

	Scenario: Listing should show group B users their posts
        And I am logged in as "userb@posts.com"
		Then I should not see "For group A"
		Then I should see "For group B"
		Then I should see "For groups AB"
		Then I should not see "In draft mode"
        Then I should see "For everyone"

	Scenario: Listing should show admin users group posts
        And I am logged in as "admin@posts.com"
		Then I should see "For group A"
		Then I should see "For group B"
		Then I should see "For groups AB"
		Then I should see "In draft mode"
        Then I should see "For everyone"

	Scenario: Listing shouldn't show public users posts for group 
		Then I should not see "For group A"
		Then I should not see "For group B"
		Then I should not see "For groups AB"
		Then I should not see "In draft mode"
        Then I should see "For everyone"


