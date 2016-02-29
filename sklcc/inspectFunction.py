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
	raw = Raw_sql()
	raw.sql = "SELECT SerialNo, CONVERT(VARCHAR(16), a.CreateTime, 20) CreateTime, CONVERT(VARCHAR(16), a.LastModifiedTime, 20) LastModifiedTime,"\
	          " ProductNo, ColorNo, CONVERT(VARCHAR(10), a.ArriveTime, 20) ArriveTime, Name"\
	          " FROM RMI_TASK a WITH(NOLOCK) JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)"\
	          " ON ID = UserID"
	if UserID != 'ALL':
		raw.sql += " WHERE ID = '%s'" % UserID
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)


def editTaskInfo(taskInfo, userID):
	"""
	根据isNew字段以及传入的信息来新插入或先删除再插入一个任务数据。
	:param taskInfo:任务相关信息
	:param userID:用户ID
	:return:返回编辑成功与否的标志
	"""
	isNew = True if taskInfo['isNew'] == "True" else False
	raw = Raw_sql()
	if isNew:
		raw.sql = "INSERT INTO RMI_TASK WITH(ROWLOCK) ( CreateTime, LastModifiedTime, ProductNo, ColorNo,"\
		          " ArriveTime, UserID, FlowID)"\
		          " VALUES ( getdate(), getdate(),'%s','%s', '%s', '%s', '%s');" % (
			          taskInfo['ProductNo'], taskInfo['ColorNo'], taskInfo['ArriveTime'][:10], userID,
			          taskInfo['FlowID'])
	else:
		raw.sql = "UPDATE RMI_TASK WITH(ROWLOCK) SET ProductNo = '%s', ColorNo = '%s', ArriveTime = '%s'"\
		          " WHERE SerialNo = '%s'" % (taskInfo['ProductNo'], taskInfo['ColorNo'],
		                                      taskInfo['ArriveTime'][:10], taskInfo['SerialNo'],)
	print raw.sql
	return raw.update()


def getFlowList():
	"""
	从数据库获取所有的工作流列表
	:return:返回{"name":FlowName,"value":FlowID}
	"""
	raw = Raw_sql()
	raw.sql = "SELECT FlowID AS value, FlowName AS name FROM RMI_WORK_FLOW WITH(NOLOCK)"
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)


def getProcessBySerialNo(serialNo):
	"""
	根据流水号获取所有的表单ID和名称
	:return:返回
	"""
	raw = Raw_sql()
	raw.sql = "SELECT name,  FROM RMI_TASK_PROCESS a WITH(NOLOCK) JOIN RMI_PROCESS_TYPE b WITH(NOLOCK)"\
	          " ON  a.ProcessID = b.Id WHERE a.SerialNo = '%s'" % serialNo
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)


def getF01DataBySerialNoAndUserID(serialNo, processID, UserID):
	"""
	根据流水号和表单ID获取表单数据
	:param serialNo:任务流水号
	:param processID:表单ID
	:param UserID:用户名，如果是ALL则表示汇总数据
	:return:返回对应的表单数据
	"""
	raw = Raw_sql()
	returnInfo = dict()
	raw.sql = """SELECT CONVERT(varchar(10), ArriveTime, 20) AS ArriveTime,
	            ProductNo, ColorNo, UserID,
	             CONVERT(varchar(10), CreateTime, 20) AS CreateTime,
	             Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
	             RMI_TASK WITH(NOLOCK) WHERE SerialNo = '%s'
	             """%serialNo
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	raw.sql = """SELECT
	             GongYingShang, DaoLiaoZongShu, DingDanHao, GuiGe, BiaoZhiShu, ShiCeShu,
	             HeGeShu, WaiGuan, JianYanHao, QiTa, TouChanShu, DingDanShu
	            FROM RMI_F01_DATA WITH(NOLOCK)
	             WHERE SerialNo = '%s'""" % serialNo
	if UserID != "ALL":
		raw.sql += " AND InspectorNo = '%s'"%UserID
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'listData': translateQueryResIntoDict(columns, [row for row in res])})
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo


def getStepsBySerialNo(SerialNo, ProcessID):
	"""
	根据流水号和表单ID获取该表单的所有的步骤
	:param SerialNo:流水号
	:param ProcessID:表单ID
	:return:返回{"name":步骤名称,"value":步骤ID,"state":步骤状态}
	"""
	raw = Raw_sql()
	raw.sql = "SELECT a.StepID as value, b.StepName as name, Finished as state FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_STEP b WITH(NOLOCK) "\
	          " ON a.StepID = b.StepID WHERE SerialNo = '%s' "\
	          " AND ProcessID = '%s'" % (SerialNo, ProcessID)
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)


def judgeWhetherNULL(param, lastOne=False):
	"""
	判断前台传过来的数据，如果是null则将SQL字串改为NULL，否则插入对应类型的数据
	:param param: SQL参数
	:param lastOne: 是否是最后一个参数
	:return:
	"""
	if not lastOne:
		if param is None:
			return 'NULL, '
		else:
			if isinstance(param, int):
				return '%d, ' % param
			else:
				return "'%s', " % param
	else:
		if param is None:
			return 'NULL '
		else:
			if isinstance(param, int):
				return '%d ' % param
			else:
				return "'%s' " % param


def insertF01DataBySerialNo(SerialNo, rawData, UserID):
	"""
	根据任务流水号和原始数据插入数据库
	:param SerialNo:任务流水号
	:param rawData:插入之前的原始数据字典列表
	:param UserID:插入数据的检验员工号
	:return:
	"""
	ListData = rawData['listData']
	DingDanHao = rawData['DingDanHao']
	GongYingShang = rawData['GongYingShang']
	DaoLiaoZongShu = rawData['DaoLiaoZongShu']
	#TODO:selectedStep
	# selectedStep   = rawData['selectedStep']
	raw = Raw_sql()
	raw.sql = "INSERT INTO RMI_F01_DATA(InspectorNo, SerialNo, GongYingShang, DaoLiaoZongShu, DingDanHao, GuiGe, HeGeShu,"\
	          "TouChanShu, DingDanShu, BiaoZhiShu, ShiCeShu, WaiGuan, JianYanHao, QiTa) "
	for row in ListData:
		raw.sql += "SELECT '%s', '%s', '%s', %d, '%s', '%s', %d, " % ( UserID,
			SerialNo, GongYingShang, DaoLiaoZongShu, DingDanHao, row["GuiGe"], row['HeGeShu'])

		raw.sql += judgeWhetherNULL(row['TouChanShu'])
		raw.sql += judgeWhetherNULL(row['DingDanShu'])
		raw.sql += judgeWhetherNULL(row['BiaoZhiShu'])
		raw.sql += judgeWhetherNULL(row['ShiCeShu'])
		raw.sql += judgeWhetherNULL(row['WaiGuan'])
		raw.sql += judgeWhetherNULL(row['JianYanHao'])
		raw.sql += judgeWhetherNULL(row['QiTa'], lastOne=True)
		raw.sql += "UNION ALL\n"

	raw.sql = raw.sql[:-10]
	raw.update()
	return


def getAllProcessBySerialNo(serialNo):
	"""
	通过任务流水号获取所有的表单和步骤状态
	:param serialNo:任务流水号
	:return:返回[{"name":表单名,"ProcessID":表单ID,"states":当前任务完成百分比情况，除去%,"currentState":当前已经进行结束的最后一个的步骤，如果都没有进行，则返回第一个}]
	"""
	raw = Raw_sql()
	raw.sql = """SELECT a.Name AS name, b.ProcessID AS ProcessID,
 				CAST(SUM( b.Finished )AS DECIMAL(3,2)) / CAST( ( SELECT COUNT(*) FROM RMI_PROCESS_STEP WHERE ProcessID = b.ProcessID ) AS DECIMAL(3,2))  AS states,
 				dbo.getCurrentFinishedStep( '%s', b.ProcessID ) AS currentState
                FROM RMI_PROCESS_TYPE a WITH(NOLOCK)
                JOIN RMI_TASK_PROCESS_STEP b WITH(NOLOCK)
                ON a.Id = b.ProcessID
                 WHERE b.SerialNo = '%s'
                GROUP BY b.ProcessID, a.Name"""%(serialNo,serialNo)
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)
