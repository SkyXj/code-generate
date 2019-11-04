package com.xj.code.generate.entity;

import lombok.Data;

import java.util.List;

@Data
public class ImportColumn {
	/**
	 * 外键表名
	 */
	private String importTable_small;
	/**
	 * 外键字段名称
	 */
	private String importColumn;
	
	/**
	 * 本表字段名称
	 */
	private String localColumn;
	
	private String importTable;
	
	private List<ColumnClass> columnlist;
}
