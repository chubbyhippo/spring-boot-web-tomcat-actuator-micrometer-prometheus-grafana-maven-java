package io.github.chubbyhippo.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
@RestController
@RequestMapping("/")
class DemoController {

	private final Logger log = LoggerFactory.getLogger(DemoController.class);
	@GetMapping
	public String getHello() {
		log.info("getHello was called");
		return "Hello";
	}

}