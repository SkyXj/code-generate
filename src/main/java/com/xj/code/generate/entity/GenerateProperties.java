package com.xj.code.generate.entity;

import lombok.Data;


@Data
public class GenerateProperties {
	private String author;
	private String ip;
	private String port;
	private String database;
	private String user;
	private String password ;
	private String driver;
	private String packagename;
	private String company;
//	private String diskPath = "";
	private String tablesuffix;
	private String groupId;
	private String artifactId;

	public String getUrl(){
		return "jdbc:mysql://"+this.ip+":"+port+"/"+database+"?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT";
	}
}
