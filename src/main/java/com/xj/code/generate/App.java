package com.xj.code.generate;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@MapperScan("com.xj.code.generate.mapper")
public class App {

    public static void main(String[] args) {
        SpringApplication.run(App.class,args);
    }


}
