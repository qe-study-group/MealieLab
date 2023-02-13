package mealie;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.HeaderConfig;
import io.restassured.config.RestAssuredConfig;
import io.restassured.filter.Filter;
import io.restassured.filter.FilterContext;
import io.restassured.http.ContentType;

import org.junit.Test;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
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
