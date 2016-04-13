GET /api/inspect/SuppliersInfo/：列出所有供应商
POST /api/inspect/SuppliersInfo/：新建一个供应商
GET /api/inspect/SuppliersInfo/ID：获取某个指定供应商的信息
PUT /api/inspect/SuppliersInfo/ID：更新某个指定供应商的信息（提供该供应商的全部信息）
DELETE /api/inspect/SuppliersInfo/ID：删除某个供应商




PATCH /api/inspect/SuppliersInfo/ID：更新某个指定供应商的信息（提供该供应商的部分信息）
GET /zoos/ID/animals：列出某个指定供应商的所有动物
DELETE /zoos/ID/animals/ID：删除某个指定供应商的指定动物

# 表格创建方法

1. 利用`CreateProcess.sql`中的`dbo.createNewProcess`创建表格与流程的相关联系，如：
 
 ```SQL
 exec dbo.createNewProcess 'F09', '材料验收记录(面料、花边)', '主料', '主料检验'
 ```
 
2. 前台写完界面后，将所有数据全部填写完整，根据发到后台的JSON，调用`CommonUnilities.py`中的`JSONToCreateTable`函数，
把转成二维表的JSON数据（单键值对组成）传入作为参数（有可能有字段冗余）

3. 生成创建表格的`SQL`后，添加表名，然后执行该SQL

4. 根据实际需要对字段类型进行微调

5. `views.py`中的`getFormData`和`insertFormData`根据是否含有`listData`在对应的位置加入表ID

5. 到数据库更新触发器`update_other_tables_when_delete_rmi_task`