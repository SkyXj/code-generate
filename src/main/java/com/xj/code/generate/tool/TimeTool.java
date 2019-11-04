package com.xj.code.generate.tool;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeTool {
	public static String Now(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        return df.format(new Date());
	}
}
