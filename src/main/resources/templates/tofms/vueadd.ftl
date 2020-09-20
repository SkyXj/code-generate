<template>
    <el-dialog
            :title="dialogConfig.title"
            :visible.sync="dialogConfig.open"
            width="600px"
            append-to-body
    >
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <#if model_column?exists>
                <#list model_column as model>
                    <#if (model_index = 0)>

                    <#elseif (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                    <el-input v-model="form.${model.changeColumnName}" placeholder="请输入${model.columnComment}" />
                                </el-form-item>
                            </el-col>
                        </el-row>
                    <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                    <el-input v-model="form.${model.changeColumnName}" placeholder="请输入${model.columnComment}" />
                                </el-form-item>
                            </el-col>
                        </el-row>
                    <#elseif model.columnType = 'DATETIME'>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="${model.columnComment}" prop="${model.changeColumnName}">
                                    <el-input v-model="form.${model.changeColumnName}" placeholder="请输入${model.columnComment}" />
                                </el-form-item>
                            </el-col>
                        </el-row>
                    <#else>
                    </#if>
                </#list>
            </#if>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm('form')">确定</el-button>
            <el-button @click="cancel">取消</el-button>
        </div>
    </el-dialog>
</template>

<script>
    import {update, add } from "@/api/${table_name?uncap_first}";

    export default {
        name: "${table_name}Add",
        props: {
            dialogConfig: {
                type: Object,
                default: undefined
            },
            form: {
                type: Object,
                default: undefined
            },
        },
        data() {
            return {
                rules: {
                    <#if model_column?exists>
                    <#list model_column as model>
                    <#if (model_index = 0)>

                    <#elseif (model.columnType = 'VARCHAR' || model.columnType = 'TEXT' || model.columnType = 'CHAR')>
                        ${model.changeColumnName}: [
                            { required: true, message: "${model.columnComment}不能为空", trigger: "blur" },
                        ],
                <#elseif (model.columnType = 'TINYINT' || model.columnType = 'SMALLINT' || model.columnType = 'MEDIUMINT' || model.columnType = 'INT' || model.columnType = 'INT UNSIGNED' || model.columnType = 'DOUBLE' || model.columnType?index_of("BIGINT")!=-1 || model.columnType = 'FLOAT' || model.columnType = 'DECIMAL')>
                        ${model.changeColumnName}: [
                            { required: true, message: "${model.columnComment}不能为空", trigger: "blur" },
                        ],
                <#elseif model.columnType = 'DATETIME'>
                        ${model.changeColumnName}: [
                            { required: true, message: "${model.columnComment}不能为空", trigger: "blur" },
                        ],
                <#else>
            </#if>
            </#list>
            </#if>
                },
            };
        },
        watch: {
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.ifOpen();
                        const data = this.form;
                        // 修改
                        if (data.${filedPreix}Id) {
                            update(data).then((response) => {
                                console.log(response.data);
                                if (response.status === 200) {
                                    this.$parent.search();
                                    this.$message({
                                        type: "success",
                                        message: "修改成功",
                                    });
                                }
                            });
                        } else {
                            add(data).then((response) => {
                                console.log(response.data);
                                if (response.status === 200) {
                                    this.$parent.search();
                                    this.$message({
                                        type: "success",
                                        message: "添加成功",
                                    });
                                }
                            });
                        }
                    } else {
                        return false;
                    }
                });
            },
            cancel() {
                this.ifOpen();
            },
            ifOpen() {
                this.$emit("closeAddDialog");
            }
        },
    };
</script>
