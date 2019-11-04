package com.xj.code.generate.web;

import com.xj.code.generate.entity.GenerateProperties;
import com.xj.code.generate.service.GenerateService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.ZipOutputStream;

@RestController
public class CodeGenerateController {

    @Autowired
    GenerateService generateService;

    @PostMapping("/generate")
    public String generate(HttpServletResponse response, @ModelAttribute GenerateProperties properties){
//        @RequestBody GenerateProperties properties
//        GenerateProperties properties=new GenerateProperties();
//        properties.setAuthor("sky");
//        properties.setDatabase("code_generate");
//        properties.setDriver("com.mysql.cj.jdbc.Driver");
//        properties.setIp("localhost");
//        properties.setPort("3306");
//        properties.setPackagename("com.xj.code.generate");
//        properties.setPassword("123456");
//        properties.setUser("root");
//          properties.setDiskPath("\\temp\\");
//        properties.setTablesuffix("");
//        properties.setGroupId("com.xj");
//        properties.setArtifactId("");

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(outputStream);
//        GenerateService2 generateService2=new GenerateService2(properties,zip);
        try {
//            generateService2.codeGenerate();
            generateService.codeGenerate(properties,zip);
            genCode(response,outputStream.toByteArray(),properties.getArtifactId());
            outputStream.close();
            zip.close();
        } catch (Exception e) {
            e.printStackTrace();
            return "false";
        }
        return "success";
    }
    /**
     * 生成zip文件
     *
     * @param response
     * @param data
     * @throws IOException
     */
    private void genCode(HttpServletResponse response, byte[] data,String name) throws IOException
    {
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=\""+name+".zip\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IOUtils.write(data, response.getOutputStream());
    }
}
