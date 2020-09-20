/**   
 * Copyright © ${company}. All rights reserved.
 * 
 * @Title: ${table_name}DTO.java 
 * @Package: ${package_name}.dto
 * @Description: TODO
 * @author: ${author}-1012262558@qq.com
 * @date: ${date}
 * @Modify Description : 
 * @Modify Person : 
 * @version: V1.0   
 */

package ${package_name}.dto;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.persistence.*;
import java.math.BigDecimal;
import com.common.entity.BaseEntityDTO;
import ${package_name}.entity.${table_name};
<#if model_import_column?exists>
<#list model_import_column as model>
import ${package_name}.entity.${model.importTable};
import ${package_name}.dto.${model.importTable}DTO;
 </#list>
</#if>


/**
* 描述：${table_annotation}模型
* @author ${author}
* @date ${date}
*/
@TableName("${table_name_small}")
public class ${table_name}DTO extends BaseEntityDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ${table_name}DTO(${table_name} ${table_name_small}) {
		if (${table_name_small} != null) {
			this.setId(${table_name_small}.getId().toString());
			this.setRemark(${table_name_small}.getRemark());
			this.setCreatedBy(${table_name_small}.getCreatedBy());
			this.setCreatedDate(${table_name_small}.getCreatedDate());
			this.setLastModifiedBy(${table_name_small}.getLastModifiedBy());
			this.setLastModifiedDate(${table_name_small}.getLastModifiedDate());
			this.setDeletedBy(${table_name_small}.getDeletedBy());
			this.setDeletedDate(${table_name_small}.getDeletedDate());
			this.setDeletedFlag(${table_name_small}.getDeletedFlag());
			<#if model_column?exists>
        		<#list model_column as model>
        		<#if model.isFK='NO'>
        	this.set${model.changeColumnName}(${table_name_small}.get${model.changeColumnName}());
        		</#if>
        		</#list>
        	</#if>
			<#if model_import_column?exists>
    		<#list model_import_column as model>
    		this.set${model.importTable}(${table_name_small}.get${model.importTable}()!=null?new ${model.importTable}DTO(${table_name_small}.get${model.importTable}()):null);
    		this.set${model.localColumn?cap_first}(${table_name_small}.get${model.importTable}()!=null?${table_name_small}.get${model.localColumn?cap_first}().toString():null);
    		</#list>
    		</#if>
		}
	}

	public ${table_name} to${table_name}() {
		${table_name} ${table_name_small} = new ${table_name}();
		${table_name_small}.setId(this.getId() != null ? Long.parseLong(this.getId()) : null);
		${table_name_small}.setRemark(this.getRemark());
		${table_name_small}.setCreatedBy(this.getCreatedBy());
		${table_name_small}.setCreatedDate(this.getCreatedDate());
		${table_name_small}.setLastModifiedBy(this.getLastModifiedBy());
		${table_name_small}.setLastModifiedDate(this.getLastModifiedDate());
		${table_name_small}.setDeletedBy(this.getDeletedBy());
		${table_name_small}.setDeletedDate(this.getDeletedDate());
		${table_name_small}.setDeletedFlag(this.getDeletedFlag());
		<#if model_column?exists>
        		<#list model_column as model>
        		<#if model.isFK='NO'>
        ${table_name_small}.set${model.changeColumnName}(this.get${model.changeColumnName}());
        		</#if>
        		</#list>
        </#if>
        
        <#if model_import_column?exists>
    		<#list model_import_column as model>
    	${table_name_small}.set${model.importTable}(this.get${model.importTable}()!=null?this.get${model.importTable}().to${model.importTable}():null);
    	${table_name_small}.set${model.localColumn?cap_first}(this.get${model.importTable}()!=null?Long.parseLong(this.get${model.localColumn?cap_first}()):null);
    	</#list>
        </#if>
		return ${table_name_small};
	}
	
    <#if model_column?exists>
        <#list model_column as model>
        
    /**
    *${model.columnComment!}
    */
    <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR' || model.isFK = 'YES') >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private String ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'TIMESTAMP' && model.isFK = 'NO') >
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Timestamp ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'DATE' && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Date ${model.changeColumnName?uncap_first};

    </#if>
    <#if ((model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED') && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Integer ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'DOUBLE' && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private double ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType?index_of("BIGINT")!=-1 && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private Long ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'FLOAT' && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private float ${model.changeColumnName?uncap_first};

    </#if>
    
    <#if (model.columnType = 'DECIMAL' && model.isFK = 'NO')>
    @TableField("${model.columnName}")
    @Column(name = "${model.columnName}",length = ${model.columnLength},nullable = <#if (model.columnNullable = 'NO')>false<#else>true</#if>)
    private BigDecimal ${model.changeColumnName?uncap_first};

    </#if>
        </#list>
    </#if>
    
    <#if model_import_column?exists>
    	<#list model_import_column as model>
    @TableField(exist=false)
    private ${model.importTable}DTO ${model.importTable_small?uncap_first};
    	</#list>
    </#if>

<#if model_column?exists>
<#list model_column as model>
<#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR' || model.isFK = 'YES')>
    public String get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(String ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType = 'TIMESTAMP' && model.isFK = 'NO')>
    public Timestamp get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Timestamp ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType = 'DATE' && model.isFK = 'NO')>
    public Date get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Date ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if ((model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT') && model.isFK = 'NO')>
    public Integer get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Integer ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType = 'DOUBLE' && model.isFK = 'NO')>
    public double get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(double ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if ((model.columnType = 'BIGINT UNSIGNED' || model.columnType = 'BIGINT') && model.isFK = 'NO')>
    public Long get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Long ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType = 'FLOAT' && model.isFK = 'NO')>
    public float get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(float ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>

<#if (model.columnType = 'DECIMAL' && model.isFK = 'NO')>
    public BigDecimal get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(BigDecimal ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
</#list>
</#if>
<#if model_import_column?exists>
    <#list model_import_column as model>
    public ${model.importTable}DTO get${model.importTable}() {
        return this.${model.importTable_small?uncap_first};
    }

    public void set${model.importTable}(${model.importTable}DTO ${model.importTable_small?uncap_first}) {
        this.${model.importTable_small?uncap_first} = ${model.importTable_small?uncap_first};
    }
    </#list>
</#if>

}