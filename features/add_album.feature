Feature: View album collection
	In order to make easy for me to manage my music albums
	As a logged user
	I want to add an album to my album collection

	Background: Logged user
		Given I am logged in as "mario.caropreso@gmail.com"

	Scenario: Add a new album (happy path)
		Given I have no albums
		When I add the album "Mentre tutto scorre" with cover "negramaro_mentre_tutto_scorre.jpg"
		Then I can see the album "Mentre tutto scorre" in the albums list

	Scenario: Invalid cover file
		Given I have no albums
		When I add the album "Mentre tutto scorre" with cover not in an image format
		Then I should see an error message
		And the album shouldn't be added

	Scenario: Duplicate album
		Given I have the album "Mentre tutto scorre"
		When I add the album "Mentre tutto scorre" with cover "negramaro_mentre_tutto_scorre.jpg"
		Then I should see an error of duplicated album
		And the album shouldn't be added