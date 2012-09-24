Feature: Signout
	In order to stop using the application
	As a logged user
	I want to log out from the application

	Scenario: Logout
		Given I am a logged user
		When I click on the logout button
		Then I shouldn't be logged in 