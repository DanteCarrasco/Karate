Feature: Create Token

Scenario: Crear token    
    Given url apiUrl
    And path 'users/login'
    And request 
    """
        {
        "user": {
            "email": "#(userEmail)", 
            "password": "#(userPassword)"
            }
        }
    """
    When method post
    Then status 200
    * def authToken = response.user.token
