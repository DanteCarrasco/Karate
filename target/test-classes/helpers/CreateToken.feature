Feature: Create Token

Scenario: Crear token    
    Given url 'https://api.realworld.io/api/'
    And path 'users/login'
    And request 
    """
        {
        "user": {
            "email": "#(email)", 
            "password": "#(password)"
            }
        }
    """
    When method post
    Then status 200
    * def authToken = response.user.token
