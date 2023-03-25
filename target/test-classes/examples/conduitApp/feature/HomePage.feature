Feature: Tests

Background: Define URL
    Given url 'https://api.realworld.io/api/'

@debug
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['welcome', 'ipsum']
        And match response.tags !contains 'trucks'
        # validar contrato (o sea de qué tipo debe ser cada elemento)
        And match response.tags == "#array"
        And match response.tags.[0] != "implementations123"
        # recorrer cada valor del response
        And match each response.tags == "#string"
        And match each response.tags != "#array"
    
    Scenario: Get 10 articles from the page
        Given param limit = 10
        And param offset = 0
        # otra forma de mandar params como obect
        # Given param: {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        # Validar tamaño del array
        And match response.articles == "#[10]"
        # Validar un número
        And match response.articlesCount == 197