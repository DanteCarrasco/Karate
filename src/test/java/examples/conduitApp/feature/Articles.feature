Feature: crear nuevo artículo

Background:
    Given url apiUrl

    # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
    # Para no generar muchos tokens, llamar una sola vez:
    # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
    # * def token = tokenResponse.authToken

    * def articleBodyRequest = call read('classpath:conduitApp/json/newArticle.json')

@debug
Scenario: Crear nuevo artículo
    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request articleBodyRequest
    When method post
    Then status 200
    And match response.article.title == 'Eliminar articulo 71'
    * def slug = response.article.slug

Scenario: Crear y eliminar articulo

    #Creando artículo
    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request
    """
        {
            "article": {
            "tagList": ["article"],
            "title": #(titulo),
            "description": "De cosas del orinoco",
            "body": "Que tú no sabeas ni yo tampoco xd"
            }
        }
    """
    When method post
    Then status 200
    * def slug = response.article.slug

    # Listando artículos para verificar que se creó
    Given param author = 'Karate0306'
    And param limit = 10
    And param offset = 0
    And path 'articles'
    # And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title == "Eliminar articulo 71"

    # Eliminar artículo
    # Given header Authorization = 'Token ' + token
    Given path 'articles/' + slug
    When method delete
    Then status 204

    # Verificar que se eliminó el artículo
    Given param author = 'Karate0306'
    And param limit = 10
    And param offset = 0
    And path 'articles'
    # And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title != "Eliminar articulo 71"