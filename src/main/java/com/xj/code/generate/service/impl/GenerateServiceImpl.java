package com.xj.code.generate.service.impl;

import com.xj.code.generate.entity.ColumnClass;
import com.xj.code.generate.entity.Dependency;
import com.xj.code.generate.entity.GenerateProperties;
import com.xj.code.generate.entity.ImportColumn;
import com.xj.code.generate.service.DependencyService;
import com.xj.code.generate.service.GenerateService;
import com.xj.code.generate.tool.TimeTool;
import com.xj.code.generate.util.FreeMarkerTemplateUtils;
import freemarker.template.Template;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class GenerateServiceImpl implements GenerateService {

    @Autowired
    DependencyService dependencyService;

    private String AUTHOR;
    private String CURRENT_DATE = TimeTool.Now();
    private String URL;
    private String database;
    private String USER;
    private String PASSWORD;
    private String DRIVER;
    private String packageName;
    private String diskPath="temp"+File.separator;
    private String tablesuffix;//表前缀
    private static String tableAnnotation = "";
    private static String tableName = "";
    private static String changeTableName = "";
    private String[] replacestrs = new String[]{"name", "index"};
    private ZipOutputStream zipout;
    private String groupId;
    private String artifactId;
    private String company;
    private Connection connection=null;

    @Override
    public void codeGenerate(GenerateProperties properties, ZipOutputStream zipout) {
        this.AUTHOR = properties.getAuthor();
        this.CURRENT_DATE = TimeTool.Now();
        this.URL = properties.getUrl();
        this.database = properties.getDatabase();
        this.USER = properties.getUser();
        this.PASSWORD = properties.getPassword();
        this.DRIVER = properties.getDriver();
        this.packageName = properties.getPackagename();
//        this.diskPath = properties.getDiskPath();
        this.tablesuffix = properties.getTablesuffix() == null ? "" : properties.getTablesuffix();
        this.zipout = zipout;
        this.groupId=properties.getGroupId();
        this.artifactId=properties.getArtifactId();
        this.company=properties.getCompany();
        ResultSet tables = null;
        try {
            tables = getTables();
            while (tables.next()) {
                tableName = tables.getString("TABLE_NAME");
                changeTableName = replaceUnderLineAndUpperCase(tableName);
                tableAnnotation = tables.getString("REMARKS") == null ? "" : tables.getString("REMARKS");
                generate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws Exception {
        if(connection==null){
            Class.forName(DRIVER);
            Properties props = new Properties();
            props.setProperty("user", USER);
            props.setProperty("password", PASSWORD);
            props.setProperty("remarks", "true"); // 设置可以获取remarks信息
            props.setProperty("useInformationSchema", "true");// 设置可以获取tables
            connection = DriverManager.getConnection(URL, props);
        }
        return connection;
    }

    private void generate() throws Exception {
        try {
            ////// // 生成Controller层文件
            generateControllerFile(getResultSet());
            // 生成Model文件
            generateModelFile(getResultSet());
            // 生成Mapper文件
            generateMapperXMLFile(getResultSet());
            // 生成Dao文件
            generateMapperFile(getResultSet());
            ////// // 生成服务层接口文件
            generateServiceInterfaceFile(getResultSet());
            ////// // 生成服务实现层文件
            generateServiceImplFile(getResultSet());
            //配置文件
            generatePropertiesFile();
            //配置文件
            generatePomFile();
            //主函数
            generateMain();
            //主函数
            generateConfig();
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {

        }
    }

    private void generateConfig() throws Exception{
        final String suffix = "Swagger2Configuration.java";
        //String path = diskPath + "java" + getPathByPackName() + "//web//api";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "config";
        //createFile(path);
        path = path + File.separator + suffix;
        final String templateName = "config.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generateMain() {
        StringWriter sw=new StringWriter();
        sw.write("package "+this.packageName+";");
        sw.write("\n");
        sw.write("import org.mybatis.spring.annotation.MapperScan;\n" +
                "import org.springframework.boot.SpringApplication;\n" +
                "import org.springframework.boot.autoconfigure.SpringBootApplication;\n" +
                "\n" +
                "@SpringBootApplication\n" +
                "@MapperScan(\""+this.packageName+".mapper\")\n" +
                "public class App {\n" +
                "    public static void main(String[] args) {\n" +
                "        SpringApplication.run(App.class,args);\n" +
                "    }\n" +
                "}");
        String path = diskPath + "java" + getPathByPackName();
        path = path + File.separator + "App.java";
        createFileToZip(sw,getRelativePath(path));
    }

    private void generateControllerFile(ResultSet resultSet) throws Exception {
        final String suffix = "Controller.java";
        //String path = diskPath + "java" + getPathByPackName() + "//web//api";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "controller";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "controller.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generateModelFile(ResultSet resultSet) throws Exception {
        final String suffix = ".java";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "entity";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "entity.ftl";
        File mapperFile = new File(path);
        List<ColumnClass> columnClassList = getColumnList(resultSet);
        List<ImportColumn> importColumns = getImportedKeys();
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("model_column", columnClassList);
        dataMap.put("model_import_column", importColumns);
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generateServiceImplFile(ResultSet resultSet) throws Exception {
        final String suffix = "ServiceImpl.java";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "service" + File.separator + "impl";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "serviceimpl.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generatePropertiesFile() throws IOException {
        StringWriter sw=new StringWriter();
        sw.write("spring.datasource.url="+this.URL);
        sw.write("\n");
        sw.write("spring.datasource.username="+this.USER);
        sw.write("\n");
        sw.write("spring.datasource.password="+this.PASSWORD);
        sw.write("\n");
        sw.write("spring.datasource.driver-class-name="+this.DRIVER);
        sw.write("\n");
        sw.write("spring.application.name=com.xj");
        sw.write("\n");

        String path_dev = diskPath + "resources"  + File.separator + "application-dev.properties";
        createFileToZip(sw,getRelativePath(path_dev));

        String path_test = diskPath + "resources" + File.separator + "application-test.properties";
        createFileToZip(sw,getRelativePath(path_test));

        String path_prod = diskPath + "resources" + File.separator + "application-prod.properties";
        createFileToZip(sw,getRelativePath(path_prod));

        //主配置文件
        String path = diskPath + "resources" + File.separator + "application.properties";
        StringWriter sw_main=new StringWriter();
        sw_main.write("spring.profiles.active=dev");
        createFileToZip(sw_main,getRelativePath(path_prod));
    }


    private void createFileToZip(StringWriter sw,String filename){
        String path = diskPath + "java" + getPathByPackName() + File.separator + filename;
        try {
            zipout.putNextEntry(new ZipEntry(filename));
            IOUtils.write(sw.toString(), zipout, "UTF-8");
            IOUtils.closeQuietly(sw);
            zipout.closeEntry();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void generatePomFile() {
        List<Dependency> dependencies = dependencyService.selectList(null);
        StringWriter sw=new StringWriter();
        sw.write("<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">\n" +
                "  <modelVersion>4.0.0</modelVersion>\n" +
                "  <groupId>"+this.groupId+"</groupId>\n" +
                "  <artifactId>"+this.artifactId+"</artifactId>\n" +
                "  <version>0.0.1-SNAPSHOT</version>");
        sw.write("  <parent>\n" +
                "\t\t<groupId>org.springframework.boot</groupId>\n" +
                "\t\t<artifactId>spring-boot-starter-parent</artifactId>\n" +
                "\t\t<version>2.1.4.RELEASE</version>\n" +
                "\t\t<relativePath /> <!-- lookup parent from repository -->\n" +
                "  </parent>");
        sw.write("<properties>\n" +
                "\t\t<java.version>1.8</java.version>\n" +
                "\t</properties>");
        sw.write("<dependencies>");
        if(dependencies!=null&&dependencies.size()>0){
            for (Dependency dependency: dependencies) {
                sw.write("<dependency>");
                sw.write("<groupId>"+dependency.getGroupid()+"</groupId>\n" +
                        "\t\t\t<artifactId>"+dependency.getArtifactid()+"</artifactId>\n");
                if(!StringUtils.isBlank(dependency.getVersion())){
                    sw.write("<version>"+dependency.getVersion()+"</version>");
                }
                sw.write("</dependency>");
            }
        }
        sw.write("</dependencies>");
        sw.write("<build>\n" +
                "\t\t<plugins>\n" +
                "\t\t\t<plugin>\n" +
                "\t\t\t\t<groupId>org.springframework.boot</groupId>\n" +
                "\t\t\t\t<artifactId>spring-boot-maven-plugin</artifactId>\n" +
                "\t\t\t</plugin>\n" +
                "\t\t</plugins>\n" +
                "\t</build>\n" +
                "</project>");

        createFileToZip(sw,"pom.xml");
    }

    private void generateServiceInterfaceFile(ResultSet resultSet) throws Exception {
        // final String prefix = "I";
        final String suffix = "Service.java";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "service";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "service.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generateRepositoryFile(ResultSet resultSet) throws Exception {
        final String suffix = "Repository.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Repository.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);
    }

    private void generateMapperFile(ResultSet resultSet) throws Exception {
        final String suffix = "Mapper.java";
        String path = diskPath + "java" + getPathByPackName() + File.separator + "mapper";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "mapper.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName, mapperFile, dataMap);

    }

    private void generateMapperXMLFile(ResultSet resultSet) throws Exception {
        final String suffix = "Mapper.xml";
        String path = diskPath + "resources" + File.separator + "mapper";
        //createFile(path);
        path = path + File.separator + changeTableName + suffix;
        final String templateName = "mapperxml.ftl";
        File mapperFile = new File(path);
        Map<String, Object> dataMap = new HashMap<>();
        List<ColumnClass> columnClassList = getColumnList(resultSet);
        List<ImportColumn> importColumns = getImportedKeys();
        dataMap.put("model_column", columnClassList);
        dataMap.put("model_import_column", importColumns);
        generateFileByTemplate(templateName, mapperFile, dataMap);

    }

    private void generateFileByTemplate(final String templateName, File file, Map<String, Object> dataMap)
            throws Exception {
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        dataMap.put("table_name_small", tableName);
        dataMap.put("table_name", changeTableName);
        dataMap.put("author", AUTHOR);
        dataMap.put("date", CURRENT_DATE);
        dataMap.put("package_name", packageName);
        dataMap.put("table_annotation", tableAnnotation);
        dataMap.put("company", company);
        StringWriter sw = new StringWriter();
        template.process(dataMap, sw);
        //加入压缩文件中
        zipout.putNextEntry(new ZipEntry(getRelativePath(file)));
        IOUtils.write(sw.toString(), zipout, "UTF-8");
        IOUtils.closeQuietly(sw);
        zipout.closeEntry();
    }


    private List<ColumnClass> getColumnList(ResultSet resultSet) throws Exception {
        List<ColumnClass> columnClassList = new ArrayList<>();
        ColumnClass columnClass = null;
        // 当前表中所有外键
        List<String> list = new ArrayList<>();
        while (resultSet.next()) {
            // 基类字段略过
            String columnname = resultSet.getString("COLUMN_NAME");
            columnClass = new ColumnClass();
            // 获取字段名称
            columnClass.setColumnName(resultSet.getString("COLUMN_NAME"));
            // 获取字段类型
            columnClass.setColumnType(resultSet.getString("TYPE_NAME").toUpperCase());
            // 转换字段名称，如 sys_name 变成 SysName
            columnClass.setChangeColumnName(replaceUnderLineAndUpperCase(resultSet.getString("COLUMN_NAME")));
            // 字段在数据库的注释
            columnClass.setColumnComment(resultSet.getString("REMARKS"));
            // 字段在数据库的长度
            columnClass.setColumnLength(resultSet.getString("COLUMN_SIZE"));
            // 字段在数据库可否为空
            columnClass.setColumnNullable(resultSet.getString("IS_NULLABLE"));
            columnClassList.add(columnClass);
        }
        return columnClassList;
    }


    private List<ImportColumn> getImportedKeys() throws Exception {
        Connection connection = getConnection();
        DatabaseMetaData databaseMetaData = connection.getMetaData();
        ResultSet resultSet = databaseMetaData.getImportedKeys(database, null, tableName);
        List<ImportColumn> list = new ArrayList<ImportColumn>();
        while (resultSet.next()) {
            ImportColumn im = new ImportColumn();
            im.setImportTable(replaceUnderLineAndUpperCase(resultSet.getString(3)));
            im.setImportTable_small(resultSet.getString(3));
            im.setImportColumn(resultSet.getString(4));
            im.setLocalColumn(resultSet.getString(8));
            im.setColumnlist(getColumnList(getResultSet(resultSet.getString(3))));
            list.add(im);
        }
        return list;
    }


    private ResultSet getResultSet(String tablename) throws Exception {
        Connection connection = getConnection();
        DatabaseMetaData databaseMetaData = connection.getMetaData();
        ResultSet resultSet = databaseMetaData.getColumns(null, "%", tablename, "%");
        return resultSet;
    }

    // 获取当前表中所有信息
    private ResultSet getResultSet() throws Exception {
        Connection connection = getConnection();
        DatabaseMetaData databaseMetaData = connection.getMetaData();
        ResultSet resultSet = databaseMetaData.getColumns(database, "%", tableName, "%");
        return resultSet;
    }

    // 包名转路径名
    private String getPathByPackName() {
        String result = "";
        String[] split = packageName.split("\\.");
        for (String string : split) {
            result = result + File.separator + string;
        }
        return result;
    }

    public String getRelativePath(File file) {
        String path=file.toString().replace(this.diskPath, "src"+File.separator+"main"+File.separator);
        return path;
    }

    public String getRelativePath(String path) {
        String result=path.replace(this.diskPath, "src"+File.separator+"main"+File.separator);
        return result;
    }




    // 获取当前数据库所有表信息
    private ResultSet getTables() throws Exception {
        Connection connection = getConnection();
        DatabaseMetaData databaseMetaData = connection.getMetaData();
        ResultSet resultSet = databaseMetaData.getTables(database, null, null, new String[]{"TABLE"});
        return resultSet;
    }

    // 首字母大写
    public String replaceUnderLineAndUpperCase(String str) {
        str = str.toLowerCase();
        if (str.contains(this.tablesuffix)) {
            str = str.replaceAll(this.tablesuffix, "").toLowerCase();
        }
        StringBuffer sb = new StringBuffer();
        sb.append(str);
        int count = sb.indexOf("_");
        while (count != 0) {
            int num = sb.indexOf("_", count);
            if (sb.length() - 1 == num) {
                break;
            }
            count = num + 1;
            if (num != -1) {
                char ss = sb.charAt(count);
                char ia = (char) (ss - 32);
                sb.replace(count, count + 1, ia + "");
            }
        }
        String result = sb.toString().replaceAll("_", "");
        for (String string : replacestrs) {
            if (string.equals(result)) {
                result = "old_" + result;
            }
        }
        return StringUtils.capitalize(result);
    }
}
