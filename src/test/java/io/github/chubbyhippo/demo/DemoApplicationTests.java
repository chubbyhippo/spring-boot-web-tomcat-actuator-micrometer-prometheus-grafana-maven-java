package io.github.chubbyhippo.demo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class DemoApplicationTests {

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Test
    void shouldGetHello() {
        var body = testRestTemplate.getForEntity("/", String.class)
                .getBody();
        assertThat(body).isEqualTo("Hello");
    }

}
