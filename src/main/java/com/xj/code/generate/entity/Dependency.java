/**   
 * Copyright © 2018武汉中地数码科技有限公司. All rights reserved.
 * 
 * @Title: Dependency.java 
 * @Package: com.xj.code.generate.entity
 * @Description: TODO
 * @author: sky-1012262558@qq.com
 * @date: 2019-10-30 09:28:52
 * @Modify Description : 
 * @Modify Person : 
 * @version: V1.0   
 */

package com.xj.code.generate.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.persistence.*;
import java.math.BigDecimal;
import lombok.Data;

/**
* 描述：模型
* @author sky
* @date 2019-10-30 09:28:52
*/
@Data
@TableName("dependency")
public class Dependency{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    /**
    *
    */
    @TableField("id")
    @Column(name = "id",length = 10,nullable = false)
    private Integer id;

    
    /**
    *
    */
    @TableField("groupId")
    @Column(name = "groupId",length = 255,nullable = true)
    private String groupid;

    
    /**
    *
    */
    @TableField("artifactId")
    @Column(name = "artifactId",length = 255,nullable = true)
    private String artifactid;

    
    /**
    *version 为空代表不需要版本号
    */
    @TableField("version")
    @Column(name = "version",length = 50,nullable = true)
    private String version;

    
    /**
    *jar包的描述
    */
    @TableField("description")
    @Column(name = "description",length = 255,nullable = true)
    private String description;

    
    /**
    *模块名
    */
    @TableField("module")
    @Column(name = "module",length = 255,nullable = true)
    private String module;

    
    
}