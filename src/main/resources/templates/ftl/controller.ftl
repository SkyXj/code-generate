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
import org.springframework.web.bind.annotation.*;
import ${package_name}.entity.${table_name};
<#--import io.swagger.annotations.Api;-->
<#--import io.swagger.annotations.ApiOperation;-->
import ${package_name}.service.${table_name}Service;
import com.hexin.common.tool.utils.ReflectUtils;

<#--@Api(value="${table_annotation}",tags={"${table_annotation}"})-->
@RestController
@RequestMapping("/${table_name_small}")
public class ${table_name}Controller{
	
	@Autowired
	${table_name}Service ${table_name_small}Service;

	@PostMapping("/list")
<#--	@ApiOperation("分页查询")-->
	public AjaxResult list(@RequestBody ${table_name} ${table_name_small}){
		List<${table_name}> result = ${table_name_small}Service.listByMap(ReflectUtils.getString(${table_name_small}, ${table_name}.class));
		return AjaxResult.success(result);
	}

	@PostMapping("/add")
<#--	@ApiOperation("增加")-->
	public AjaxResult add(@RequestBody ${table_name} ${table_name_small}){
		boolean b = ${table_name_small}Service.save(${table_name_small});
		return AjaxResult.success(b);
	}

	@DeleteMapping("/remove")
<#--	@ApiOperation("删除")-->
	public AjaxResult remove(@RequestParam(value = "ids") List<Integer> ids){
		boolean b = ${table_name_small}Service.removeByIds(ids);
		return AjaxResult.success(b);
	}

	@DeleteMapping("/update")
<#--	@ApiOperation("删除")-->
	public AjaxResult update(@RequestBody ${table_name} ${table_name_small}){
		boolean b = ${table_name_small}Service.updateById(${table_name_small});
		return AjaxResult.success(b);
	}

	@ApiOperation("批量修改或者删除")
<#--	@PostMapping("/saveOrUpdate")-->
	public AjaxResult saveOrUpdate(@RequestBody List<${table_name}> users){
		boolean b = ${table_name_small}Service.saveOrUpdateBatch(users);
		return AjaxResult.success(b);
	}
}