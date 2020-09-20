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
import ${package_name}.service.${table_name}Service;
import net.tofms.commons.core.vo.TofmsResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import net.tofms.basic.util.WrapperUtils;

@RestController
@RequestMapping("/${filedPreix}")
@Api(value="${table_annotation}",tags={"${table_annotation}"})
public class ${table_name}Controller{
	
	@Autowired
	${table_name}Service ${table_name?uncap_first}Service;

	@GetMapping("/list")
	@ApiOperation("分页查询")
	public TofmsResult<Page<#noparse><</#noparse>${table_name}>> list(@RequestParam Integer index,@RequestParam Integer pageSize,@RequestParam(required = false) String keyWord){
		Page<${table_name}> result = ${table_name?uncap_first}Service.page(new Page<${table_name}>(index, pageSize), WrapperUtils.getWrapper(${table_name}.class,keyWord));
		return TofmsResult.ok(result);
	}

	@PostMapping("/add")
	@ApiOperation("增加")
	public TofmsResult<?> add(@RequestBody ${table_name} ${table_name?uncap_first}){
		boolean b = ${table_name?uncap_first}Service.save(${table_name?uncap_first});
		return TofmsResult.ok();
	}

	@DeleteMapping("/remove")
	@ApiOperation("批量删除")
	public TofmsResult<?> remove(@RequestParam(value = "ids") List<Integer> ids){
		boolean b = ${table_name?uncap_first}Service.removeByIds(ids);
		return TofmsResult.ok();
	}

	@PutMapping("/update")
	@ApiOperation("修改")
	public TofmsResult<?> update(@RequestBody ${table_name} ${table_name?uncap_first}){
		boolean b = ${table_name?uncap_first}Service.updateById(${table_name?uncap_first});
		return TofmsResult.ok();
	}

	@PostMapping("/saveOrUpdate")
	@ApiOperation("批量增加或修改")
	public TofmsResult<?> saveOrUpdate(@RequestBody List<${table_name}> users){
		boolean b = ${table_name?uncap_first}Service.saveOrUpdateBatch(users);
		return TofmsResult.ok();
	}
}