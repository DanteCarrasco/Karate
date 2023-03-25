Feature: crear nuevo artículo

Background:
    Given url 'https://api.realworld.io/api/'

    # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
    # Para no generar muchos tokens, llamar una sola vez:
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email": "xavier@hola.com", "password": "Xavier3012"}
    * def token = tokenResponse.authToken

    * def titulo = "Eliminar articulo 6"

Scenario: Crear nuevo artículo
    Given header Authorization = 'Token ' + token
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
    And match response.article.title == 'Eliminar articulo 6'
    * def slug = response.article.slug

Scenario: Crear y eliminar articulo

    #Creando artículo
    Given header Authorization = 'Token ' + token
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
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title == "Eliminar articulo 6"

    # Eliminar artículo
    Given header Authorization = 'Token ' + token
    And path 'articles/' + slug
    When method delete
    Then status 204

    # Verificar que se eliminó el artículo
    Given param author = 'Karate0306'
    And param limit = 10
    And param offset = 0
    And path 'articles'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title != "Eliminar articulo 6"