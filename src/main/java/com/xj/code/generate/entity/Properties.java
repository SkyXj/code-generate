package com.xj.code.generate.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import javax.persistence.Column;

/**
 * Copyright © 广州禾信仪器股份有限公司. All rights reserved.
 *
 * @Author hxsdd-20
 * @Date 2020/9/20 15:57
 * @Version 1.0
 */
@Data
@TableName("properties")
public class Properties {
    /**
     * 编号
     */
    @TableId(value="id",type = IdType.AUTO)
    private Integer id;

    private String author;
    private String ip;
    private String port;
    private String database;
    private String user;
    private String password;
    private String driver;
    private String packagename;
    private String company;
    private String description;
    //	private String diskPath = "";
    private String tablesuffix;
    @TableField("group_id")
    private String groupId;
    @TableField("artifact_id")
    private String artifactId;
    private String tables;
    private String modular;
}
