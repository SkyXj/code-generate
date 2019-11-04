/**   
 * Copyright © ${company}. All rights reserved.
 * 
 * @Title: ${table_name}.java 
 * @Package: ${package_name}.entity
 * @Description: TODO
 * @author: ${author}-1012262558@qq.com
 * @date: ${date}
 * @Modify Description : 
 * @Modify Person : 
 * @version: V1.0   
 */

package ${package_name}.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.persistence.*;
import java.math.BigDecimal;
import lombok.Data;

/**
* 描述：${table_annotation}模型
* @author ${author}
* @date ${date}
*/
@Data
@TableName("${table_name_small}")
public class ${table_name}{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    <#if model_column?exists>
        <#list model_column as model>
    /**
    *${model.columnComment!}
    */
    <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private String ${model.changeColumnName?uncap_first};

    </#if>
    <#if model.columnType = 'TIMESTAMP' >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Timestamp ${model.changeColumnName?uncap_first};

    </#if>
    <#if model.columnType = 'DATE' >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Date ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Integer ${model.changeColumnName?uncap_first};

    </#if>
    <#if model.columnType = 'DOUBLE' >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private double ${model.changeColumnName?uncap_first};

    </#if>
    <#if model.columnType?index_of("BIGINT")!=-1>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Long ${model.changeColumnName?uncap_first};

    </#if>
    <#if model.columnType = 'FLOAT' >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private float ${model.changeColumnName?uncap_first};

    </#if>
    
    <#if model.columnType = 'DECIMAL' >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private BigDecimal ${model.changeColumnName?uncap_first};

    </#if>
        </#list>
    </#if>
    
    <#if model_import_column?exists>
    	<#list model_import_column as model>
    @TableField(exist=false)
    private ${model.importTable} ${model.importTable_small?uncap_first};
    	</#list>
    </#if>
}