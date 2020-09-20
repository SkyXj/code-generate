<template>
    <div class="app-container">
        <el-row :gutter="20">
            <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
                <#if model_column?exists>
                    <#list model_column as model>
                        <#if (model.columnComment = '自增主键')>

                        <#elseif (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                            <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                <el-input
                                        v-model="queryParams.${model.changeColumnName}"
                                        placeholder="请输入${model.columnComment}"
                                        clearable
                                        size="small"
                                />
                            </el-form-item>
                        <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                            <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                <el-input
                                        v-model="queryParams.${model.changeColumnName}"
                                        placeholder="请输入${model.columnComment}"
                                        clearable
                                        size="small"
                                />
                            </el-form-item>
                        <#elseif model.columnType = 'DATETIME'>
                            <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                <el-input
                                        v-model="queryParams.${model.changeColumnName}"
                                        placeholder="请输入${model.columnComment}"
                                        clearable
                                        size="small"
                                />
                            </el-form-item>
                        <#else>
                        </#if>
                    </#list>
                </#if>
                <el-form-item>
                    <el-button v-permission="['${table_name?upper_case}_SEARCH']" type="primary" size="mini" @click="search">搜索</el-button>
                    <el-button v-permission="['${table_name?upper_case}_ADD']" type="primary" size="mini" plain @click="handleAdd">新增${table_annotation}</el-button>
                </el-form-item>
            </el-form>
        </el-row>
        <el-table v-loading="loading" :data="list">
            <#if model_column?exists>
                <#list model_column as model>
                    <#if (model.columnComment = '自增主键')>

                        <#elseif (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                            <el-table-column label="${model.columnComment}" align="center" prop="${model.changeColumnName}" />
                        <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                            <el-table-column label="${model.columnComment}" align="center" prop="${model.changeColumnName}" />
                        <#elseif model.columnType = 'DATETIME'>
                            <el-table-column label="${model.columnComment}" align="center" prop="${model.changeColumnName}" />
                        <#else>
                        </#if>
                </#list>
            </#if>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" v-permission="['${table_name?upper_case}_EDIT']" icon="el-icon-edit" @click="handleUpdate(scope.row)">修改</el-button>
                    <el-button
                            size="mini"
                            type="text"
                            icon="el-icon-delete"
                            v-permission="['${table_name?upper_case}_DELETE']"
                            @click="handleDelete(scope.row)"
                    >删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
                v-show="total>0"
                :total="total"
                :page.sync="queryParams.index"
                :limit.sync="queryParams.pageSize"
                @pagination="getList"
        />
        <${table_name_small}-add :dialog-config="dialogConfig" :form="form" @closeAddDialog="closeAddDialog" />
</template>

<script>
    import Pagination from "@/components/Pagination";
    import ${table_name}Add from "./add";
    import { list, remove } from "@/api/${table_name_small}";

    export default {
        name: "${table_name?cap_first}",
        components: {
            ${table_name}Add,
            Pagination
        },
        data() {
            return {
                userId: null,
                loading: false,
                // 用于分页
                total: 0,
                dialogConfig: {
                    open: false,
                    title: "",
                },
                form: {
                    <#if model_column?exists>
                    <#list model_column as model>
                    <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                    ${model.columnName}: "",
                <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                    ${model.columnName}: null,
                <#elseif model.columnType = 'DATETIME'>
                    ${model.columnName}: null,
                <#else>
                </#if>
                </#list>
                </#if>
                },
                queryParams: {
                    keyword: "",
                    index: 0,
                    pageSize: 10
                },
                list: [
                ]
            };
        },
        mounted() {
        },
        created() {
            this.getList();
        },
        methods: {
            async getList() {
                this.loading = true;
                list(this.queryParams).then(response => {
                    this.loading = false;
                    this.list = response.data.records;
                    this.total = response.data.total;
                });
            },
            handleAdd() {
                this.dialogConfig.open = true;
                this.dialogConfig.title = "新增${table_annotation}";
                this.form = {
                <#if model_column?exists>
                <#list model_column as model>
                <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                ${model.columnName}: "",
                <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                ${model.columnName}: null,
                <#elseif model.columnType = 'DATETIME'>
                ${model.columnName}: null,
                <#else>
                </#if>
                </#list>
                </#if>
                };
            },
            handleUpdate(row) {
                this.dialogConfig.open = true;
                this.dialogConfig.title = "修改${table_annotation}";
                this.form = row;
            },
            handleDelete(row) {
                this.$confirm(`是否删除${table_annotation} @@@@{row.userName}`, "删除${table_annotation}", {
                    confirmButtonText: "删除",
                    confirmButtonClass: "el-button--danger",
                    cancelButtonText: "取消",
                    type: "warning"
                })
                    .then(() => {
                        remove(row.userId).then(response => {
                            if (response.status === 200) {
                                this.searchUser();
                                this.$message({
                                    type: "success",
                                    message: "删除成功"
                                });
                            } else {
                                this.$message({
                                    type: "success",
                                    message: "删除失败"
                                });
                            }
                        });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消删除"
                        });
                    });
            },
            closeAddDialog() {
                this.dialogConfig.open = false;
            }
        }
    };
</script>

<style lang="less">
</style>
