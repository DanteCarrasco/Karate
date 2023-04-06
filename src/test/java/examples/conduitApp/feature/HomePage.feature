Feature: Tests

Background: Define URL
    Given url apiUrl
    
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['welcome', 'ipsum']
        And match response.tags !contains 'trucks'
        # Validar que contenga cualquiera de los siguientes
        And match response.tags contains any ['introduction', 'hola', 'chau']
        # contains only valida que solo tenga esos valores
        # validar contrato (o sea de qué tipo debe ser cada elemento)
        And match response.tags == "#array"
        And match response.tags.[0] != "implementations123"
        # recorrer cada valor del response
        And match each response.tags == "#string"
        And match each response.tags != "#array"
    
    Scenario: Get 10 articles from the page

        * def timeValidator = read('classpath:helpers/timeValidator.js')

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
        And match response.articlesCount == 211
        And match response.articlesCount != 100
        And match response == {"articles": "#array", "articlesCount": 211}
        And match response.articles[0].createdAt contains '2023'
        # Validar que alguno de todos los elementos contenga tal cosa
        And match response.articles[*].favoritesCount contains 0
        # La misma validación pero de otra forma
        And match response..favoritesCount contains 0
        And match response..bio contains null
        # Validar que todos los elementos tengan el mismo valor
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        # Validar que acepte un tipo de valor pero si no existe que acepte "null" se usa doble #
        And match each response..bio == '##string'
        # Schema validation
        And match each response.articles ==
        """
            {
                "slug":"#string",
                "title":"#string",
                "description":"#string",
                "body":"#string",
                "tagList":"#array",
                "createdAt":"#? timeValidator(_)",
                "updatedAt":"#? timeValidator(_)",
                "favorited":"#boolean",
                "favoritesCount":"#number",
                "author":{
                    "username":"#string",
                    "bio":"##string",
                    "image":"#string",
                    "following":"#boolean"
                }
            }
        """