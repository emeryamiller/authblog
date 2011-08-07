Feature: Certain links should be visible
    As a user of the system
    I should see the links I'm supposed to see

    Scenario: A link to posts should be visible to everyone
        Given I am on the homepage
        Then I should see "Posts"

    Scenario: A link to posts should be visible to admins from the admins section
        Given I am logged in as an admin
        Given I am on the homepage
        Then I should see "Posts"
        When I follow "Admin"
        Then I should see "Posts"
        When I follow "Users"
        Then I should see "Posts"
        When I follow "Admin"
        When I follow "Groups"
        Then I should see "Posts"
    
