package com.xj.code.generate.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
    @GetMapping("/")
    public String index(){
        return "index";
    }
}
