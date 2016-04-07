# -*- coding: utf-8 -*-
"""
所有任务task相关功能函数
"""
__author__ = "XuWeitao"
import CommonUtilities
import rawSql

def getTasksList(UserID):
	"""
	获取任务列表，包括任务流水号，创建时间，最近一次修改时间，货号，色号以及到料时间和创建人
	:param UserID:创建人ID，如果为ALL则返回所有的任务列表
	:return:{
			"SerialNo":任务流水号, "CreateTime":任务创建时间, "LastModifiedTime":最近一次修改时间,
			"ProductNo":货号, "ColorNo":色号, "ArriveTime":到料时间, "Name":创建人名,
			"GongYingShang":{"id":供应商代码, "name":供应商名称},
			"WuLiao":{"id":材料名称ID, "name":材料名称, "cata":材料种类名称},
			"DaoLiaoZongShu":到料总数, "DanWei":{"id":到料总数单位ID, "name":到料总数单位}
		}
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT SerialNo, CONVERT(VARCHAR(16), a.CreateTime, 20) CreateTime, CONVERT(VARCHAR(16), a.LastModifiedTime, 20) LastModifiedTime,
	           ProductNo, ColorNo, CONVERT(VARCHAR(10), a.ArriveTime, 20) ArriveTime, Name, SupplierCode,
	           dbo.getSupplierNameByID(SupplierCode), MaterialID, dbo.getMaterialNameByID(MaterialID),
	           dbo.getMaterialTypeNameByID(dbo.getMaterialTypeIDByMaterialID(MaterialID)), DaoLiaoZongShu, UnitID,
	           dbo.getUnitNameByID(UnitID)
	           FROM RMI_TASK a WITH(NOLOCK) JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)
	           ON ID = UserID"""
	if UserID != 'ALL':
		raw.sql += " WHERE ID = '%s' AND State = 2" % UserID
	else:
		raw.sql += " WHERE State = 0"
	res = raw.query_all()
	jsonReturn = list()
	for row in res:
		jsonReturn.append({
			"SerialNo":row[0], "CreateTime":row[1], "LastModifiedTime":row[2],
			"ProductNo":row[3], "ColorNo":row[4], "ArriveTime":row[5], "Name":row[6],
			"GongYingShang":{"id":row[7], "name":row[8]},
			"WuLiao":{"id":row[9], "name":row[10], "cata":row[11]},
			"DaoLiaoZongShu":row[12], "DanWei":{"id":row[13], "name":row[14]}
		})
	return jsonReturn

def editTaskInfo(taskInfo, userID):
	"""
	根据isNew字段以及传入的信息来新插入或先删除再插入一个任务数据。
	:param taskInfo:任务相关信息
	:param userID:用户ID
	:return:返回编辑成功与否的标志
	"""
	isNew = True if taskInfo['isNew'] == "True" else False
	raw = rawSql.Raw_sql()
	if isNew:
		raw.sql = """INSERT INTO RMI_TASK WITH(ROWLOCK) (CreateTime, LastModifiedTime, ProductNo, ColorNo,
		          ArriveTime, UserID, FlowID, MaterialID, SupplierCode, UnitID, DaoLiaoZongShu)
		          VALUES ( getdate(), getdate(),'%s','%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s' );""" % (
			          taskInfo['ProductNo'], taskInfo['ColorNo'], taskInfo['ArriveTime'][:10], userID,
			          taskInfo['FlowID'], taskInfo['WuLiao']['id'], taskInfo['GongYingShang']['id'],
			          taskInfo['DanWei']['id'], taskInfo['DaoLiaoZongShu'])
	else:
		raw.sql = """UPDATE RMI_TASK WITH(ROWLOCK) SET MaterialID = '%s',SupplierCode = '%s', UnitID = '%s',
                     DaoLiaoZongShu = '%s', ProductNo = '%s', ColorNo = '%s', ArriveTime = '%s'
		             WHERE SerialNo = '%s'""" % (
					taskInfo['WuLiao']['id'], taskInfo['GongYingShang']['id'], taskInfo['DanWei']['id'],
					taskInfo['DaoLiaoZongShu'], taskInfo['ProductNo'], taskInfo['ColorNo'],
		            taskInfo['ArriveTime'][:10], taskInfo['SerialNo'],)
	return raw.update()

def getFlowList():
	"""
	从数据库获取所有的工作流列表
	:return:返回{"name":FlowName,"value":FlowID}
	"""
	raw = rawSql.Raw_sql()
	raw.sql = "SELECT FlowID AS value, FlowName AS name FROM RMI_WORK_FLOW WITH(NOLOCK)"
	res, columns = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(columns, res)

def commitTaskBySerialNo(SerialNo):
	"""
	根据流水号通过任务的函数
	:param SerialNo: 任务流水号
	:return:
	"""
	raw = rawSql.Raw_sql()
	raw.sql = "UPDATE RMI_TASK SET State = 0 WHERE SerialNo = '%s'"%SerialNo
	raw.update()
	return


def deleteTaskBySerialNo(SerialNo):
	"""
	删除任务，只删除RMI_TASK表中的数据，触发器跟踪删除其他表相关信息
	:param SerialNo:任务流水号
	:return:
	"""
	#TODO：触发器update_other_tables_when_delete_rmi_task更新删除F01之外其他表格的数据
	raw = rawSql.Raw_sql()
	raw.sql = "DELETE FROM RMI_TASK WHERE SerialNo='%s'"%SerialNo
	raw.update()
	#call trigger delete all task info in rmi_task_process...
	return

def getAllMaterialByName(fuzzyName):
	"""
	根据模糊输入获取所有材料的名称
	:param fuzzyName:模糊输入
	:return:{'id':材料名称ID,'name':材料名称,'cata':材料种类名称}
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT a.MaterialID AS id, a.MaterialName AS name, dbo.getMaterialTypeNameByID(b.MaterialTypeID) AS cata
 				FROM RMI_MATERIAL_NAME a WITH(NOLOCK) JOIN RMI_MATERIAL_TYPE_NAME b WITH(NOLOCK)
				ON a.MaterialID=b.MaterialID"""
	if fuzzyName:
		raw.sql += """ WHERE MaterialName LIKE '%%%%%s%%%%'"""%fuzzyName
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(cols, res)