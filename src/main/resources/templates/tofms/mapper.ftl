/**   
 * Copyright © ${company}. All rights reserved.
 * 
 * @Title: ${table_name}Mapper.java 
 * @Package: ${package_name}.mapper
 * @Description: TODO
 * @author: ${author}-1012262558@qq.com
 * @date: ${date}
 * @Modify Description : 
 * @Modify Person : 
 * @version: V1.0   
 */

package ${package_name}.mapper;

import ${package_name}.entity.${table_name};
import org.apache.ibatis.annotations.Param;
import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

@Repository
public interface ${table_name}Mapper extends BaseMapper<${table_name}>{

}