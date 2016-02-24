# -*- coding: utf-8 -*-
"""
检验工序所使用的所有的功能函数
"""
__author__ = "XuWeitao"
from rawSql import *
from CommonUtilities import *

def getTasksList(UserID):
	"""
	获取任务列表，包括任务流水号，创建时间，最近一次修改时间，货号，色号以及到料时间和创建人
	:param UserID:创建人ID，如果为ALL则返回所有的任务列表
	:return:返回包含以上所有信息的字典列表
	"""
	raw     = Raw_sql()
	raw.sql = "SELECT SerialNo, CONVERT(varchar(16), a.CreateTime, 20) CreateTime, CONVERT(varchar(16), a.LastModifiedTime, 20) LastModifiedTime," \
	          " ProductNo, ColorNo, CONVERT(varchar(10), a.ArriveTime, 20) ArriveTime, Name" \
	          " FROM RMI_TASK a WITH(NOLOCK) JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)" \
	          " ON ID = UserID"
	if UserID != 'ALL':
		raw.sql += " WHERE ID = '%s'"%UserID
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoJSON(columns, res)

def editTaskInfo(taskInfo, userID):
	"""
	根据isNew字段以及传入的信息来新插入或先删除再插入一个任务数据。
	:param taskInfo:任务相关信息
	:param userID:用户ID
	:return:返回编辑成功与否的标志
	"""
	isNew        = True if taskInfo['isNew'] == "True" else False
	raw          = Raw_sql()
	if isNew:
		raw.sql = "INSERT INTO RMI_TASK WITH(ROWLOCK) ( CreateTime, LastModifiedTime, ProductNo, ColorNo," \
		          " ArriveTime, UserID, FlowID)"\
		          " VALUES ( getdate(), getdate(),'%s','%s', '%s', '%s', '%s');" % (
			        taskInfo['ProductNo'], taskInfo['ColorNo'], taskInfo['ArriveTime'][:10], userID, taskInfo['FlowID'])
	else:
		raw.sql = "UPDATE RMI_TASK WITH(ROWLOCK) SET ProductNo = '%s', ColorNo = '%s', ArriveTime = '%s'" \
		          " WHERE SerialNo = '%s'"%( taskInfo['ProductNo'], taskInfo['ColorNo'],
		                                     taskInfo['ArriveTime'][:10], taskInfo['SerialNo'],)
	return raw.update()


def getFlowList():
	"""
	从数据库获取所有的工作流列表
	:return:返回{"name":FlowName,"value":FlowID}
	"""
	raw = Raw_sql()
	raw.sql = "SELECT FlowID as value, FlowName as name FROM RMI_WORK_FLOW WITH(NOLOCK)"
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoJSON(columns, res)

def getProcessBySerialNo(SerialNo):
	"""
	根据流水号获取所有的表单ID和名称
	:return:返回
	"""
	raw = Raw_sql()
	raw.sql = "SELECT name,  FROM RMI_TASK_PROCESS a WITH(NOLOCK) JOIN RMI_PROCESS_TYPE b WITH(NOLOCK)" \
	          " ON  a.ProcessID = b.Id WHERE a.SerialNo = '%s'"%SerialNo
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoJSON(columns, res)