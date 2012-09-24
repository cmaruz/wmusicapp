Feature: Search albums
	In order to find an album
	As a logged user
	I want to find an album by providing its name

	Background: I have two albums
		Given I am logged in as "mario.caropreso@gmail.com"
		And I have two albums
			| title								| cover 														|
			| Mentre tutto scorre	|	negramaro_mentre_tutto_scorre.jpg |
			|	Casa 69							|	negramaro_casa_69.jpg									|

	Scenario: Find an album (happy path)
		When I search for the album "Mentre tutto scorre"
		Then I should see the album "Mentre tutto scorre" in the search results

	Scenario: Album does not exist
		When I search for the album "La finestra"
		Then I should see an empty results list