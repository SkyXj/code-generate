INSERT INTO `tb_basic_permission` VALUES (null,'${table_annotation}管理', '${modular}/${table_name?uncap_first}', '${table_name?upper_case}_LIST', 24, 'M','table');
-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

INSERT INTO `tb_basic_permission` VALUES (null,'${table_annotation}增加', '', '${table_name?upper_case}_ADD', @parentId, 'B', NULL);
INSERT INTO `tb_basic_permission` VALUES (null,'${table_annotation}编辑', '', '${table_name?upper_case}_EDIT', @parentId, 'B', NULL);
INSERT INTO `tb_basic_permission` VALUES (null,'${table_annotation}删除', '', '${table_name?upper_case}_DELETE', @parentId, 'B', NULL);
INSERT INTO `tb_basic_permission` VALUES (null,'${table_annotation}查询', '', '${table_name?upper_case}_SEARCH', @parentId, 'B', NULL);