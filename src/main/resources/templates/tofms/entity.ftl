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

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.IdType;

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
    <#if (model_index = 0)>
    @TableId(value = "${model.columnName}",type = IdType.AUTO)
    private String ${model.changeColumnName?uncap_first};

    <#elseif (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
    @TableField("${model.columnName}")
    private String ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'TIMESTAMP' >
    @TableField("${model.columnName}")
    private Timestamp ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'DATE' >
    @TableField("${model.columnName}")
    private Date ${model.changeColumnName?uncap_first};

    <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED')>
    @TableField("${model.columnName}")
    private Integer ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'DOUBLE' >
    @TableField("${model.columnName}")
    private double ${model.changeColumnName?uncap_first};

    <#elseif model.columnType?index_of("BIGINT")!=-1>
    @TableField("${model.columnName}")
    private Long ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'FLOAT' >
    @TableField("${model.columnName}")
    private float ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'DECIMAL' >
    @TableField("${model.columnName}")
    private BigDecimal ${model.changeColumnName?uncap_first};

    <#elseif model.columnType = 'DATETIME' >
    @TableField("${model.columnName}")
    private Date ${model.changeColumnName?uncap_first};

    <#else>
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