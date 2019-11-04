/**
* Copyright © 2018武汉中地数码科技有限公司. All rights reserved.
*
* @Title: DependencyController.java
* @Package: com.xj.code.generate.web.api
* @Description: TODO
* @author: sky-1012262558@qq.com
* @date: 2019-10-30 09:28:52
* @Modify Description :
* @Modify Person :
* @version: V1.0
*/

package com.xj.code.generate.controller;

import com.xj.code.generate.entity.Dependency;
import com.xj.code.generate.service.DependencyService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(value="",tags={""})
@RestController
@RequestMapping("/dependency")
public class DependencyController{
	
	@Autowired
	DependencyService dependencyService; 

	@GetMapping("/getList")
	public List<Dependency> getList(){
		return dependencyService.selectList(null);
	}
}