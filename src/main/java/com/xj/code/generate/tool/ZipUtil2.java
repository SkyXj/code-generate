package com.xj.code.generate.tool;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtil2 {
    private static void zip(ZipOutputStream out, File f, String base) throws Exception
    {
        if (f.isDirectory()) {
            File[] files = f.listFiles();
            base = (base.length() == 0 ? "" : base + "/");
            for (int i = 0; i < files.length; i++) {
                zip(out, files[i], base + files[i].getName());
            }
        } else {
            out.putNextEntry(new ZipEntry(base));
            BufferedInputStream in = new BufferedInputStream(new FileInputStream(f));
            int c;

            while ((c = in.read()) != -1) {
                out.write(c);
            }
            in.close();
        }
    }

    private static void zip(File inputFileName, ZipOutputStream zipOutputStream) throws Exception
    {
        zip(zipOutputStream, inputFileName, "");
        zipOutputStream.close();
    }

    //压缩文件，inputFileName表示要压缩的文件（可以为目录）,zipFileName表示压缩后的zip文件
    public static void zip(String inputFileName, ZipOutputStream zipOutputStream) throws Exception
    {
        zip(new File(inputFileName), zipOutputStream);
    }
}
