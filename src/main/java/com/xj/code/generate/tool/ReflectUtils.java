package com.xj.code.generate.tool;

import javax.persistence.Column;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class ReflectUtils {
	//获取字段Column注解名称(即数据库字段)
	public static List<String> getColumns(Class<?> clazz){
		List<String> list=new ArrayList<String>();
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			Column column = field.getAnnotation(Column.class);
			if(column!=null) list.add(column.name());
		}
		Field[] superFields=clazz.getSuperclass().getDeclaredFields();
		for (Field field : superFields) {
			Column column = field.getAnnotation(Column.class);
			if(column!=null) list.add(column.name());
		}
 		return list;
	}
	
	
	/**
	 * 通过反射获取各个属性名称和属性值封装成类
	 * 
	 * @param StringDto
	 * @return
	 */
	public static List<String> getAllColumns(Object StringDto) {
		List<String> fieldlist = new ArrayList<String>();
		Class<?> clazz = StringDto.getClass();
		try {
			exceClass(StringDto, fieldlist, clazz);
		} catch (Exception e) {
 
		}
		return fieldlist;
	}
 
	private static void exceClass(Object StringDto, List<String> fieldlist, Class<?> clazz) throws Exception {
		if (clazz != Object.class) {
			System.out.println(clazz);
			returnclassF(StringDto, fieldlist, clazz);
			Class<?> clazzs = clazz.getSuperclass();
			exceClass(StringDto, fieldlist, clazzs);
		}
	}
 
	private static void returnclassF(Object StringDto, List<String> fieldlist, Class<?> clazz) throws Exception {
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			field.setAccessible(true);
			fieldlist.add(field.getName().toString());
		}
	}

	
}
