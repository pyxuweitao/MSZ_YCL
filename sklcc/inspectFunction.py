# -*- coding: utf-8 -*-
"""
检验工序所使用的所有的功能函数
"""
__author__ = "XuWeitao"
from rawSql import *
from CommonUtilities import *
import copy

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
	:param serialNo:任务流水号
	:return:返回
	"""
	raw = Raw_sql()
	raw.sql = "SELECT name,  FROM RMI_TASK_PROCESS a WITH(NOLOCK) JOIN RMI_PROCESS_TYPE b WITH(NOLOCK)"\
	          " ON  a.ProcessID = b.Id WHERE a.SerialNo = '%s'" % serialNo
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)

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

######################### Common Utilities ############################################

def updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID):
	"""
	返回一个更新步骤状态、更新任务最近一次修改时间、更新表格最后一次修改时间的SQL
	:param isFinished: 步骤是否完成
	:param processID: 表格ID
	:param SerialNo: 任务流水号
	:param selectedStep: 选择步骤ID
	:param UserID: 用户名
	:return:返回更新所需SQL
	"""
	if isFinished:
		SQL = """;UPDATE RMI_TASK_PROCESS_STEP
 						SET Finished = 1, FinishTime = getdate(), LastModifiedTime = getdate() WHERE SerialNo='%s' AND ProcessID = '%s' AND StepID = '%s';"""%(SerialNo, processID, selectedStep)
	else:
		SQL = """;UPDATE RMI_TASK_PROCESS_STEP
 						SET LastModifiedTime = getdate() WHERE SerialNo='%s' AND ProcessID = '%s' AND StepID = '%s';"""%(SerialNo, processID, selectedStep)
	SQL += """UPDATE RMI_TASK_PROCESS
				SET LastModifiedTime = GETDATE(), LastModifiedUser = '%s'
				WHERE ProcessID = '%s' AND SerialNo = '%s';"""%(UserID, processID, SerialNo)
	SQL += """UPDATE RMI_TASK_PROCESS
			SET LastModifiedTime = GETDATE() WHERE SerialNo = '%s';"""%SerialNo
	return SQL

########################## F01 商标，纸卡不干贴########################################################

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
	              dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
	             RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
	              ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
 					ON a.StepID = b.StepID
 				    WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]

	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回False



	if UserID != "ALL":
		raw.sql = """SELECT
	             MaterialType AS SelectedType,GongYingShang, DaoLiaoZongShu, DingDanHao, GuiGe, BiaoZhiShu, ShiCeShu,
	             HeGeShu, WaiGuan, JianYanHao, QiTa, TouChanShu, DingDanShu
	            FROM RMI_F01_DATA WITH(NOLOCK)
	             WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( serialNo, UserID )
	else:
		raw.sql = """SELECT
	             MaterialType AS SelectedType,GongYingShang, DaoLiaoZongShu, DingDanHao, GuiGe, BiaoZhiShu, ShiCeShu,
	             HeGeShu, WaiGuan, JianYanHao, QiTa, TouChanShu, DingDanShu, dbo.getUserNameByUserID(InspectorNo) as Inspector
	            FROM RMI_F01_DATA WITH(NOLOCK)
	             WHERE SerialNo = '%s'""" %serialNo
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'listData': translateQueryResIntoDict(columns, [row for row in res])})
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo

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
	processID      = 'F01'
	ListData       = rawData['listData']
	DingDanHao     = rawData['DingDanHao']
	GongYingShang  = rawData['GongYingShang']
	DaoLiaoZongShu = rawData['DaoLiaoZongShu']
	selectedStep   = rawData['selectedStep']
	selectedType   = rawData['SelectedType']
	isFinished     = rawData['isSubmit']
	raw = Raw_sql()
	raw.sql = "DELETE FROM RMI_%s_DATA	 WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	raw.sql += "INSERT INTO RMI_%s_DATA(MaterialType, InspectorNo, SerialNo, GongYingShang, DaoLiaoZongShu, DingDanHao, GuiGe, HeGeShu,"\
	          "TouChanShu, DingDanShu, BiaoZhiShu, ShiCeShu, WaiGuan, JianYanHao, QiTa) "%processID
	for row in ListData:
		raw.sql += "SELECT '%s', '%s', '%s', '%s', %d, '%s', '%s', %d, " % ( selectedType, UserID,
			SerialNo, GongYingShang, DaoLiaoZongShu, DingDanHao, row["GuiGe"], row['HeGeShu'])

		raw.sql += judgeWhetherNULL(row['TouChanShu'] if row['hasTouChanShu'] else None)
		raw.sql += judgeWhetherNULL(row['DingDanShu'] if row['hasDingDanShu'] else None)
		raw.sql += judgeWhetherNULL(row['BiaoZhiShu'])
		raw.sql += judgeWhetherNULL(row['ShiCeShu'])
		raw.sql += judgeWhetherNULL(row['WaiGuan'])
		raw.sql += judgeWhetherNULL(row['JianYanHao'])
		raw.sql += judgeWhetherNULL(row['QiTa'], lastOne=True)
		raw.sql += "UNION ALL\n"
	raw.sql  = raw.sql[:-10]
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return


########################### F02 辅料#########################################################

def getF02DataBySerialNoAndUserID(serialNo, processID, UserID):
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
	              dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
	             RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
	              ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
 					ON a.StepID = b.StepID
 				    WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]

	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回False


	if UserID != "ALL":
		raw.sql = """SELECT
	            *
	            FROM RMI_F02_DATA WITH(NOLOCK)
	             WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( serialNo, UserID  )
	else:
		raw.sql = """SELECT
				 *,  dbo.getUserNameByUserID(InspectorNo) AS Inspector
	             FROM RMI_F02_DATA WITH(NOLOCK)
	             WHERE SerialNo = '%s'""" %serialNo
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'listData': translateQueryResIntoDict(columns, [row for row in res])})
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo

def transformRawDataIntoInsertFormatDict( rawDict ):
	"""
	根据前台传过来的JSON，将其转换成以行记录为单元的列表，一行记录一个字典，字典中有可能缺少键
	:param rawDict: 传过来的原始数据
	:return:返回结构化的列表
	"""
	listData = rawDict.pop('listData')
	formatData = list()
	for row in listData:
		itemRow = copy.deepcopy(rawDict)
		itemRow.update(row)
		formatData.append(itemRow)
	return formatData

#F03复用
def formatSQLValuesString(insertItem):
	"""
	将数据按类型格式化为SQL中插入的字符串，如果是字符串，左右加上单引号，如果是Bool，改为'1'或者'0'，如果是字典，转化为JSON字符串存储
	:param insertItem:欲转换格式的数据
	:return:返回转换格式之后的数据
	"""
	if insertItem is None:
		return 'NULL'
	elif isinstance(insertItem, (unicode, str)):
		return "'" + insertItem + "'"
	#bool是int的子类
	elif isinstance(insertItem, (int, float)):
		if isinstance(insertItem, bool):
			return '1' if insertItem else '0'
		else: #int or float
			return unicode(insertItem)
	elif isinstance(insertItem, (dict, list)):
		return "'"+json.dumps(insertItem, ensure_ascii=False)+"'"

def insertF02DataBySerialNo(SerialNo, rawData, UserID):
	"""
	根据任务流水号和原始数据插入数据库
	:param SerialNo:任务流水号
	:param rawData:插入之前的原始数据字典列表
	:param UserID:插入数据的检验员工号
	:return:
	"""
	processID    = 'F02'
	selectedStep = rawData.pop('selectedStep')
	isFinished   = rawData.pop('isSubmit')
	rawData['SerialNo'] = SerialNo
	formatData   = transformRawDataIntoInsertFormatDict(rawData)
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	for row in formatData:
		columnsString = ",".join(row.keys()) + ",InspectorNo"
		valuesString  = ",".join([formatSQLValuesString(row[key]) for key in row.keys() ]) + ",'" + UserID + "'"
		raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return

########################### F03 实验室检测报告 #########################################################

def getF03DataBySerialNoAndUserID(serialNo, processID, UserID):
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
		              dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
		             RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
		              ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
						 ON a.StepID = b.StepID
					     WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]
	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回Fals
	if UserID != "ALL":
		raw.sql = """SELECT
		            *
		            FROM RMI_F03_DATA WITH(NOLOCK)
		             WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( serialNo, UserID  )
	else:
		raw.sql = """SELECT
					 *,  dbo.getUserNameByUserID(InspectorNo) AS Inspector
		             FROM RMI_F03_DATA WITH(NOLOCK)
		             WHERE SerialNo = '%s'""" %serialNo
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	#区分F02
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo


def insertF03DataBySerialNo(SerialNo, rawData, UserID):
	"""
		根据任务流水号和原始数据插入数据库
		:param SerialNo:任务流水号
		:param rawData:插入之前的原始数据字典列表
		:param UserID:插入数据的检验员工号
		:return:
	"""
	processID    = 'F03'
	selectedStep = rawData.pop('selectedStep')
	isFinished   = rawData.pop('isSubmit')
	rawData['SerialNo'] = SerialNo
	#区分F02
	formatData   = rawData
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	#区分F02
	columnsString = ",".join(formatData.keys()) + ",InspectorNo"
	valuesString  = ",".join([formatSQLValuesString(formatData[key]) for key in formatData.keys() ]) + ",'" + UserID + "'"
	raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return

########################### F04 疲劳拉伸测试报告#########################################################

def getF04DataBySerialNoAndUserID(serialNo, processID, UserID):
	"""
		根据流水号和表单ID获取表单数据
		:param serialNo:任务流水号
		:param processID:表单ID
		:param UserID:用户名，如果是ALL则表示汇总数据
		:return:返回对应的表单数据
	"""
	raw        = Raw_sql()
	returnInfo = dict()
	raw.sql = """SELECT CONVERT(varchar(10), ArriveTime, 20) AS ArriveTime,
  	            ProductNo, ColorNo, UserID,
  	             CONVERT(varchar(10), CreateTime, 20) AS CreateTime,
  	              dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
  	             RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
  	              ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
  					 ON a.StepID = b.StepID
  				     WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]
	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回False
	if UserID != "ALL":
		raw.sql = """SELECT
  	            *
  	            FROM RMI_%s_DATA WITH(NOLOCK)
  	             WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( processID, serialNo, UserID  )
	else:
		raw.sql = """SELECT
  				 *,  dbo.getUserNameByUserID(InspectorNo) AS Inspector
  	             FROM RMI_%s_DATA WITH(NOLOCK)
  	             WHERE SerialNo = '%s'""" %(processID, serialNo)
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	#区分F02
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo


def insertF04DataBySerialNo(SerialNo, rawData, UserID):
	"""
		根据任务流水号和原始数据插入数据库
		:param SerialNo:任务流水号
		:param rawData:插入之前的原始数据字典列表
		:param UserID:插入数据的检验员工号
		:return:
		"""
	processID    = 'F04'
	selectedStep = rawData.pop('selectedStep')
	isFinished   = rawData.pop('isSubmit')
	rawData['SerialNo'] = SerialNo
	#区分F02
	formatData   = rawData
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	#区分F02
	columnsString = ",".join(formatData.keys()) + ",InspectorNo"
	valuesString  = ",".join([formatSQLValuesString(formatData[key]) for key in formatData.keys() ]) + ",'" + UserID + "'"
	raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)

	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return

####################################F05 模杯水洗报告########################################

def getF05DataBySerialNoAndUserID(serialNo, processID, UserID):
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
	                dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
	               RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
	                ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
	  				 ON a.StepID = b.StepID
	  			     WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]
	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回False
	if UserID != "ALL":
		raw.sql = """SELECT
	              *
	              FROM RMI_%s_DATA WITH(NOLOCK)
	               WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %(processID, serialNo, UserID)
	else:
		raw.sql = """SELECT
	  			 *,  dbo.getUserNameByUserID(InspectorNo) AS Inspector
	               FROM RMI_%s_DATA WITH(NOLOCK)
	               WHERE SerialNo = '%s'""" %(processID, serialNo)
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'listData': translateQueryResIntoDict(columns, [row for row in res])})
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo

def insertF05DataBySerialNo(SerialNo, rawData, UserID):
	"""
	根据任务流水号和原始数据插入数据库
	:param SerialNo:任务流水号
	:param rawData:插入之前的原始数据字典列表
	:param UserID:插入数据的检验员工号
	:return:
	"""
	processID    = 'F05'
	selectedStep = rawData.pop('selectedStep')
	isFinished   = rawData.pop('isSubmit')
	rawData['SerialNo'] = SerialNo
	formatData   = transformRawDataIntoInsertFormatDict(rawData)
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	for row in formatData:
		columnsString = ",".join(row.keys()) + ",InspectorNo"
		valuesString  = ",".join([formatSQLValuesString(row[key]) for key in row.keys() ]) + ",'" + UserID + "'"
		raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return


########################### F06 成品洗涤测试报告#########################################################

def getF06DataBySerialNoAndUserID(serialNo, processID, UserID):
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
  	              dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime FROM
  	             RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
  	              ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	returnInfo['info'] = translateQueryResIntoDict(columns, (res,))[0]
	#判断是否审批中
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
  					 ON a.StepID = b.StepID
  				     WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]
	if target is None:
		# 所有步骤完成
		returnInfo['info']['check'] = True
	else:
		# 检验步骤未完成
		returnInfo['info']['check'] = False #如果最大值不是0就表示还有步骤没有完成，则返回False
	if UserID != "ALL":
		raw.sql = """SELECT
  	            *
  	            FROM RMI_%s_DATA WITH(NOLOCK)
  	             WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( processID, serialNo, UserID  )
	else:
		raw.sql = """SELECT
  				 *,  dbo.getUserNameByUserID(InspectorNo) AS Inspector
  	             FROM RMI_%s_DATA WITH(NOLOCK)
  	             WHERE SerialNo = '%s'""" %(processID, serialNo)
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	#区分F02
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'step': getStepsBySerialNo(serialNo, processID)})
	return returnInfo


def insertF06DataBySerialNo(SerialNo, rawData, UserID):
	"""
		根据任务流水号和原始数据插入数据库
		:param SerialNo:任务流水号
		:param rawData:插入之前的原始数据字典列表
		:param UserID:插入数据的检验员工号
		:return:
		"""
	processID    = 'F06'
	selectedStep = rawData.pop('selectedStep')
	isFinished   = rawData.pop('isSubmit')
	rawData['SerialNo'] = SerialNo
	#区分F02
	formatData   = rawData
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	#区分F02
	columnsString = ",".join(formatData.keys()) + ",InspectorNo"
	valuesString  = ",".join([formatSQLValuesString(formatData[key]) for key in formatData.keys() ]) + ",'" + UserID + "'"
	raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)

	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID)
	raw.update()
	return

#########################################################################################

def getAllProcessStepBySerialNo(serialNo):
	"""
	通过任务流水号获取所有的表单和步骤状态
	:param serialNo:任务流水号
	:return:返回[{"name":表单名,"ProcessID":表单ID,"states":当前任务完成百分比情况，除去%,"currentState":当前已经进行结束的最后一个的步骤，如果都没有进行，则返回第一个}]
	"""
	raw = Raw_sql()
	raw.sql = """SELECT a.Name AS name, b.ProcessID AS ProcessID,
	  			 CAST(SUM( b.Finished )AS DECIMAL(3,2)) / CAST( ( SELECT COUNT(*) FROM RMI_PROCESS_STEP WHERE ProcessID = b.ProcessID ) AS DECIMAL(3,2))  AS states,
	  			 dbo.getCurrentFinishedStep( '%s', b.ProcessID ) AS currentState,
	  			 CONVERT(varchar(16),dbo.getLastModifiedTimeByProcessID('%s', b.ProcessID), 20) AS modifyTime,
	  			 dbo.getLastModifiedUserNameByProcessID('%s', b.ProcessID) AS modifyPeople
	              FROM RMI_PROCESS_TYPE a WITH(NOLOCK)
	              JOIN RMI_TASK_PROCESS_STEP b WITH(NOLOCK)
	              ON a.Id = b.ProcessID
	               WHERE b.SerialNo = '%s'
	              GROUP BY b.ProcessID, a.Name"""%(serialNo,serialNo,serialNo,serialNo)
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)

def deleteTaskBySerialNo(SerialNo):
	"""
	删除任务，只删除RMI_TASK表中的数据，触发器跟踪删除其他表相关信息
	:param SerialNo:任务流水号
	:return:
	"""
	#TODO：触发器update_other_tables_when_delete_rmi_task更新删除F01之外其他表格的数据
	raw = Raw_sql()
	raw.sql = "DELETE FROM RMI_TASK WHERE SerialNo='%s'"%SerialNo
	raw.update()
	#call trigger delete all task info in rmi_task_process...
	return

def passProcessBySerialNo(serialNo, ProcessID, Assessor):
	"""
	审批过程通过表单，将当前的表格的审批步骤完成，并且记录审批员和审批时间的信息
	:param serialNo:任务流水号
	:param ProcessID:表单ID
	:param Assessor:审批员工号
	:return:
	"""
	raw      = Raw_sql()
	raw.sql  = """UPDATE RMI_TASK_PROCESS_STEP SET Finished = 1, FinishTime = getdate(), LastModifiedTime = getdate()
				WHERE SerialNo = '%s' AND ProcessID = '%s' AND Finished = 0"""%(serialNo, ProcessID)
	raw.sql += """UPDATE RMI_TASK_PROCESS SET Assessor = '%s', AssessTime = getdate()
				WHERE SerialNo = '%s' AND ProcessID = '%s'"""%(Assessor, serialNo, ProcessID)
	raw.update()
	return



