/**
* Copyright © ${company}. All rights reserved.
*
* @Title: ${table_name}Controller.java
* @Package: ${package_name}.web.api
* @Description: TODO
* @author: ${author}-1012262558@qq.com
* @date: ${date}
* @Modify Description :
* @Modify Person :
* @version: V1.0
*/

package ${package_name}.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ${package_name}.entity.${table_name};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import ${package_name}.service.${table_name}Service;

@Api(value="${table_annotation}",tags={"${table_annotation}"})
@RestController
@RequestMapping("/${table_name_small}")
public class ${table_name}Controller{
	
	@Autowired
	${table_name}Service ${table_name_small}Service; 
	
}