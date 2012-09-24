Feature: View album collection
	In order to make easy for me to manage my music albums
	As a logged user
	I want to see my album collection

	Background: Logged user
		Given I am logged in as "mario.caropreso@gmail.com"

	Scenario: I can see a list of all my album collections
		Given I have two albums
			| title								| cover 														|
			| Mentre tutto scorre	|	negramaro_mentre_tutto_scorre.jpg |
			|	Casa 69							|	negramaro_casa_69.jpg							|
		When I go to the albums list
		Then I can see the albums "Mentre tutto scorre" and "Casa 69"
		And I should see minified cover images

	Scenario: Empty album list
		Given I have no albums
		When I go to the albums list
		Then I see an empty album list