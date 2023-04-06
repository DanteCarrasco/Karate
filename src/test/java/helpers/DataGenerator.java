package helpers;
import com.github.javafaker.Faker;

public class DataGenerator {
    
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@hola.com";
        return email;
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    // no static así que tenemos que declarar su instancia a la hora de llamar esta función
    public String getRandomUsername2() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
}
