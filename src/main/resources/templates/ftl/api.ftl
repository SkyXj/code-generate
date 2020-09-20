import request from "@/utils/request";

// 查找${table_annotation}
export function list(data) {
    return request({
        url: "/service-basic/${table_name_small}/list",
        method: "get",
        params: data
    });
}

// 修改${table_annotation}
export function update(data) {
    return request({
        url: "/service-basic/${table_name_small}/update",
        method: "put",
        data: data
    });
}

// 增加${table_annotation}
export function add(data) {
    return request({
        url: "/service-basic/${table_name_small}/add",
        method: "post",
        data: data
    });
}

// 删除${table_annotation}
export function remove(ids) {
    return request({
        url: "/service-basic/${table_name_small}/remove?ids=" + ids,
        method: "delete"
    });
}