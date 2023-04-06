Feature: Sign up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl

    Scenario: New user Sign up
        # * def userData = {"email":"Karatehola@email.com", "username":"karateUser123"}

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        # otra forma de llamar una función declarando su instancia, o sea que no sea static
        * def otroRandonUN =
            """
            function () {
            var otroDataGenerator = Java.type('helpers.DataGenerator')
            var generator = new otroDataGenerator()
            return generator.getRandomUsername2()
            }
            """
        * def randomUsername2 = call otroRandonUN

        Given path 'users'
        And request
            """
            {
            "user": {
            "email": #(randomEmail),
            "password": "123Karate",
            "username": #(randomUsername2)
            }
            }
            """
        When method post
        Then status 200
        And match response ==
            """
            {
                "user": {
                    "email": "#(randomEmail)",
                    "username": "#(randomUsername2)",
                    "bio": "##string",
                    "image": "#string",
                    "token": "#string"
                }
            }
            """

    @error
    Scenario Outline: New user Sign up
        # * def userData = {"email":"Karatehola@email.com", "username":"karateUser123"}

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        # otra forma de llamar una función declarando su instancia, o sea que no sea static
        * def otroRandonUN =
            """
            function () {
            var otroDataGenerator = Java.type('helpers.DataGenerator')
            var generator = new otroDataGenerator()
            return generator.getRandomUsername2()
            }
            """
        * def randomUsername2 = call otroRandonUN

        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
            """
        When method post
        Then status 422
        And match response == <errorMessage>

        Examples:
            | email            | password  | username           | errorMessage                                       |
            | #(randomEmail)   | 123Karate | Karateka123        | {"errors":{"username":["has already been taken"]}} |
            | xavierC@hola.com | 123Karate | #(randomUsername2) | {"errors":{"email":["has already been taken"]}}    |