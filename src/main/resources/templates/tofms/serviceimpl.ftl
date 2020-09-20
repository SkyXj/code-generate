/**   
 * Copyright © ${company}. All rights reserved.
 * 
 * @Title: ${table_name}ServiceImpl.java 
 * @Package: ${package_name}.service.impl
 * @Description: TODO
 * @author: ${author}-1012262558@qq.com
 * @date: ${date}
 * @Modify Description : 
 * @Modify Person : 
 * @version: V1.0   
 */


package ${package_name}.service.impl;


import org.springframework.stereotype.Service;
import ${package_name}.entity.${table_name};
import ${package_name}.mapper.${table_name}Mapper;
import ${package_name}.service.${table_name}Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
* 描述：${table_annotation} 服务实现层
* @author ${author}
* @date ${date}
*/
@Service
public class ${table_name}ServiceImpl extends ServiceImpl<${table_name}Mapper,${table_name}> implements ${table_name}Service{

}