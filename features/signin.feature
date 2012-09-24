Feature: Signin
	In order to manage my album collection
	As a registered user
	I want to access the application

	Scenario: Valid login credentials
		Given I have a valid account
		When I insert my login credentials
		Then I should see my album collections

	Scenario: Invalid login credentials
		Given I have a valid account
		When I insert a wrong password
		Then I shouldn't be logged in
		And I should see an error message