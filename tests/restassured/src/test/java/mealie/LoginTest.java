package mealie;

import io.restassured.RestAssured;

import org.junit.jupiter.api.Test;

import static org.hamcrest.Matchers.equalTo;

public class LoginTest {

    @Test 
    public void login() {
        RestAssured.given().
            accept("application/json").
            contentType("multipart/form-data").
            multiPart("file", "filename").
            multiPart("key", "value").
        when().
                post("/login").
        then().
                body(equalTo("hello world"));
    }
}
