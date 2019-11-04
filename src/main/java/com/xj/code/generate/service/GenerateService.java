package com.xj.code.generate.service;

import com.xj.code.generate.entity.GenerateProperties;

import java.util.zip.ZipOutputStream;

public interface GenerateService {
    void codeGenerate(GenerateProperties properties, ZipOutputStream zipout);
}
