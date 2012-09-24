Feature: Signup
	In order to manage my album collection
	As a new user
	I want to create a user account

	Scenario: Creation of a new user account
		Given I don't have a user account
		When I create an account by providing my email and password
		Then I should have a new account
		And I should see my albums page

	Scenario: Invalid data for account creation
		Given I don't have a user account
		When I create an account by providing a wrong email address
		Then I shouldn't have a new account
		And I should see an error message