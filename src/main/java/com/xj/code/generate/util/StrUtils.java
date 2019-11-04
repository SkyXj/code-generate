package com.xj.code.generate.util;

public class StrUtils {
    /**
     * 方法说明 :将首字母和带 _ 后第一个字母 转换成大写
     *
     * @return :String
     * @author :HFanss
     * @date :2018年5月31日下午9:52:19
     */
    public static String upperTable(String str)
    {
        // 字符串缓冲区
        StringBuffer sbf = new StringBuffer();
        // 如果字符串包含 下划线
        if (str.contains("-"))
        {
            // 按下划线来切割字符串为数组
            String[] split = str.split("-");
            // 循环数组操作其中的字符串
            for (int i = 0, index = split.length; i < index; i++)
            {
                // 递归调用本方法
                String upperTable = upperTable(split[i]);
                // 添加到字符串缓冲区
                sbf.append(upperTable);
            }
        } else
        {// 字符串不包含下划线
            // 转换成字符数组
            char[] ch = str.toCharArray();
            // 判断首字母是否是字母
            if (ch[0] >= 'a' && ch[0] <= 'z')
            {
                // 利用ASCII码实现大写
                ch[0] = (char) (ch[0] - 32);
            }
            // 添加进字符串缓存区
            sbf.append(ch);
        }
        // 返回
        return sbf.toString();
    }

    public static void main(String[] args) {
        System.out.println(upperTable("spring-boot-starter-thymeleaf"));
    }
}
