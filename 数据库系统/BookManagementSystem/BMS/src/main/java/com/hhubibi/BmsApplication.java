package com.hhubibi;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.hhubibi.mapper")
public class BmsApplication {

	public static void main(String[] args) {

		SpringApplication.run(BmsApplication.class, args);
	}

}
