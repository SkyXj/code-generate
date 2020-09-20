package com.xj.code.generate.web;

import com.xj.code.generate.entity.Properties;
import com.xj.code.generate.mapper.PropertiesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ViewController {
    @Autowired
    PropertiesMapper propertiesMapper;

    @GetMapping("/")
    public String index(Model model){
        Properties properties = propertiesMapper.selectById(1);
        model.addAttribute("properties",properties);
        return "index";
    }
}
