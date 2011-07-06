Feature: Creating groups
	In order to create administrative groups
	As an admin
	I want to be able to administer them

	Background:
		Given there are the following users:
			|email | password | admin |
			|admin@posts.com | password | true |
		And I am signed in as them
		And I am on the homepage
		When I follow "Administer Groups"

	Scenario: Creating a group

		
	
	
