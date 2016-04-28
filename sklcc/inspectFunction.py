# -*- coding: utf-8 -*-
"""
所有process表单录入界面使用功能函数
"""
__author__ = "XuWeitao"
from rawSql import *
from CommonUtilities import *
import copy

######################### Common Utilities ############################################

def updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID, InspectorTotalNumber):
	"""
	返回一个更新步骤状态、更新任务最近一次修改时间、更新表格最后一次修改时间的SQL
	:param isFinished: 步骤是否完成
	:param processID: 表格ID
	:param SerialNo: 任务流水号
	:param selectedStep: 选择步骤ID,如果为空则为保存，同时没有选择步骤
	:param UserID: 用户名
	:param InspectorTotalNumber: 检验总数
	:return:返回更新所需SQL
	"""
	if isFinished:
		SQL = """UPDATE RMI_TASK
			SET LastModifiedTime = GETDATE() """
		if InspectorTotalNumber != 0:
			SQL += ", InspectTotalNumber = %s"%InspectorTotalNumber
		SQL += " WHERE SerialNo = '%s';"%SerialNo
		if selectedStep:
			SQL += """;UPDATE RMI_TASK_PROCESS_STEP
 						SET Finished = 1, FinishTime = getdate(), LastModifiedTime = getdate() WHERE SerialNo='%s' AND ProcessID = '%s' AND StepID = '%s';"""%(SerialNo, processID, selectedStep)
	else:
		SQL = """UPDATE RMI_TASK
			SET LastModifiedTime = GETDATE() WHERE SerialNo = '%s';"""%SerialNo
		if selectedStep:
			SQL += """UPDATE RMI_TASK_PROCESS_STEP
 						SET LastModifiedTime = getdate() WHERE SerialNo='%s' AND ProcessID = '%s' AND StepID = '%s';"""%(SerialNo, processID, selectedStep)

	SQL += """UPDATE RMI_TASK_PROCESS
				SET LastModifiedTime = GETDATE(), LastModifiedUser = '%s'
				WHERE ProcessID = '%s' AND SerialNo = '%s';"""%(UserID, processID, SerialNo)
	return SQL

def getStepsBySerialNoAndProcessID(SerialNo, ProcessID):
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

def getTaskInfo(processID, serialNo):
	"""
	获取每张表个公用任务信息
	:param processID:表格ID
	:param serialNo:任务流水号
	:return:返回给前台中info字段的相关信息
	"""
	raw        = Raw_sql()
	raw.sql = """SELECT CONVERT(varchar(10), ArriveTime, 20) AS ArriveTime,
  	            ProductNo, ColorNo, UserID,
  	            CONVERT(varchar(10), CreateTime, 20) AS CreateTime,
  	            dbo.getUserNameByUserID(Assessor) AS Assessor, CONVERT(varchar(10), AssessTime, 20) AS AssessTime,
  	            dbo.getDaoLiaoZongShuAndUnit(a.SerialNo) AS DaoLiaoZongShu,
  	            dbo.getSupplierNameByID(SupplierID) AS GongYingShang,
	            dbo.getMaterialNameByID(MaterialID) AS CaiLiaoMingCheng,
	            dbo.getMaterialTypeNameByID(dbo.getMaterialTypeIDByMaterialID(MaterialID)) AS CaiLiaoDaLei,
	            dbo.getConfigByProcessIDAndMaterialID(MaterialID, '%s') config
  	            FROM RMI_TASK a WITH(NOLOCK) JOIN RMI_TASK_PROCESS b WITH(NOLOCK)
  	            ON a.SerialNo = b.SerialNo And b.ProcessID = '%s' WHERE a.SerialNo = '%s'"""%(processID, processID, serialNo)
	res, columns = raw.query_one(needColumnName=True)
	return translateQueryResIntoDict(columns, (res,))[0]

def judgeWhetherStepFinished(serialNo, processID):
	"""
	判断指定的任务的表格是否填完
	:param serialNo: 流水号
	:param processID: 表格ID
	:return: 返回标识是否完成填写的布尔值
	"""
	#判断是否审批中
	raw     = Raw_sql()
	raw.sql = """SELECT MAX(b.StepSeq) FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
 					ON a.StepID = b.StepID
 				    WHERE a.SerialNo = '%s' AND a.ProcessID = '%s' AND Finished = 0"""%(serialNo, processID)
	target = raw.query_one()[0]

	if target is None:
		# 所有步骤完成
		return True
	else:
		# 检验步骤未完成
		return False #如果最大值不是0就表示还有步骤没有完成，则返回False

########################## F01 商标，纸卡不干贴########################################################

def getF01DataBySerialNoAndUserID(serialNo, processID, UserID):
	"""
	根据流水号和表单ID获取表单数据
	:param serialNo:任务流水号
	:param processID:表单ID
	:param UserID:用户名，如果是ALL则表示汇总数据
	:return:返回对应的表单数据
	"""
	raw                = Raw_sql()
	returnInfo         = dict()
	returnInfo['info'] = getTaskInfo(processID, serialNo)
	returnInfo['info']['check'] = judgeWhetherStepFinished(serialNo, processID)

	if UserID != "ALL":
		raw.sql = """SELECT
	            DingDanHao, GuiGe, BiaoZhiShu, ShiCeShu, SaoMiaoJieGuo, JianYanShu,
	            HeGeShu, WaiGuan, JianYanHao, QiTa, TouChanShu, DingDanShu, isZhuDiaoPai, ShengChanRiQi
	            FROM RMI_F01_DATA WITH(NOLOCK)
	            WHERE SerialNo = '%s' AND InspectorNo = '%s'""" %( serialNo, UserID )
	else:
		raw.sql = """SELECT
	            DingDanHao, GuiGe, BiaoZhiShu, ShiCeShu, SaoMiaoJieGuo, JianYanShu,
	            HeGeShu, WaiGuan, JianYanHao, QiTa, TouChanShu, DingDanShu,
	            dbo.getUserNameByUserID(InspectorNo) as Inspector, isZhuDiaoPai, ShengChanRiQi
	            FROM RMI_F01_DATA WITH(NOLOCK)
	            WHERE SerialNo = '%s'""" %serialNo
	res, columns = raw.query_all(needColumnName=True)
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])

	listData = {'listData': translateQueryResIntoDict(columns, [row for row in res])}
	for i,row in enumerate(listData['listData']):
		if row['isZhuDiaoPai']:
			returnInfo['data']['ZhuDiaoPai'] = listData['listData'].pop(i)
	returnInfo['data'].update(listData)
	returnInfo['data'].update({'step': getStepsBySerialNoAndProcessID(serialNo, processID)})
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
	DaoLiaoZongShu = rawData['DaoLiaoZongShu']
	selectedStep   = rawData['selectedStep'] if 'selectedStep' in rawData else "" #如果没有这个键说明是保存状态,同时没有选择步骤
	isFinished     = rawData['isSubmit']
	totalCount     = rawData['totalCount']
	ShengChanRiQi  = rawData['ShengChanRiQi']

	raw      = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA	 WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	raw.sql += "UPDATE RMI_TASK SET DaoLiaoZongShu = '%s' WHERE SerialNo = '%s';"%(DaoLiaoZongShu, SerialNo)
	if len(ListData) > 0:
		raw.sql += """INSERT INTO RMI_%s_DATA(InspectorNo, SerialNo, DingDanHao, GuiGe, HeGeShu,
		           TouChanShu, DingDanShu, BiaoZhiShu, JianYanShu, ShiCeShu, WaiGuan, SaoMiaoJieGuo,
		           JianYanHao, QiTa, isZhuDiaoPai, ShengChanRiQi ) """%processID

		rawData['ZhuDiaoPai']['ZhuDiaoPaiFlag'] = True #如果是主吊牌，加入主吊牌标记键值对0
		ListData.append(rawData['ZhuDiaoPai'])
		for row in ListData:
			raw.sql += "SELECT '%s', '%s', '%s'," % ( UserID, SerialNo, DingDanHao )
			raw.sql += "'%s',"%row['GuiGe'] if row['GuiGe'] else 'NULL,' #规格在主吊牌中有可能不填
			raw.sql += "%s,"%row['HeGeShu'] if row['HeGeShu'] else 'NULL,' #合格数在主吊牌中有可能不填
			raw.sql += judgeWhetherNULL(row['TouChanShu'] if row['hasTouChanShu'] else None)
			raw.sql += judgeWhetherNULL(row['DingDanShu'] if row['hasDingDanShu'] else None)
			raw.sql += judgeWhetherNULL(row['BiaoZhiShu'])
			raw.sql += judgeWhetherNULL(float(row['JianYanShu']))
			raw.sql += judgeWhetherNULL(row['ShiCeShu'])
			raw.sql += judgeWhetherNULL(row['WaiGuan'])
			raw.sql += judgeWhetherNULL(row['SaoMiaoJieGuo'])
			raw.sql += judgeWhetherNULL(row['JianYanHao'])
			raw.sql += judgeWhetherNULL(row['QiTa'])
			raw.sql += judgeWhetherNULL(1 if 'ZhuDiaoPaiFlag' in row else 0)#表示非主吊牌行
			raw.sql += judgeWhetherNULL(ShengChanRiQi, lastOne=True)
			raw.sql += "UNION ALL\n"
		raw.sql  = raw.sql[:-10]
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID, totalCount)
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
	raw                = Raw_sql()
	returnInfo         = dict()
	returnInfo['info'] = getTaskInfo(processID, serialNo)
	returnInfo['info']['check'] = judgeWhetherStepFinished(serialNo, processID)

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
	#为勾袢自动添加大小的设定添加键
	returnInfo['info']['isEmpty'] = True if len(res) == 0 else False
	returnInfo['data'] = dict()
	returnInfo['data'].update(translateQueryResIntoDict(columns, [row for row in res])[0])
	returnInfo['data'].update({'listData': translateQueryResIntoDict(columns, [row for row in res])})
	returnInfo['data'].update({'step': getStepsBySerialNoAndProcessID(serialNo, processID)})
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

def insertF02DataBySerialNo(SerialNo, rawData, UserID):
	"""
	根据任务流水号和原始数据插入数据库
	:param SerialNo:任务流水号
	:param rawData:插入之前的原始数据字典列表
	:param UserID:插入数据的检验员工号
	:return:
	"""
	processID    = 'F02'
	selectedStep = rawData.pop('selectedStep') if 'selectedStep' in rawData else "" #如果没有这个键说明是保存状态,同时没有选择步骤
	isFinished   = rawData.pop('isSubmit')
	totalCount   = rawData.pop('totalCount')
	rawData['SerialNo'] = SerialNo
	formatData   = transformRawDataIntoInsertFormatDict(rawData)
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	for row in formatData:
		columnsString = ",".join(row.keys()) + ",InspectorNo"
		valuesString  = ",".join([formatSQLValuesString(row[key]) for key in row.keys() ]) + ",'" + UserID + "'"
		raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID, totalCount)
	raw.update()
	return


# 没有listData的表格
def withOutListDataGetFormDataBySerialNoAndUserID(serialNo, processID, UserID):
	"""
		根据流水号和表单ID获取表单数据
		:param serialNo:任务流水号
		:param processID:表单ID
		:param UserID:用户名，如果是ALL则表示汇总数据
		:return:返回对应的表单数据
	"""
	raw        = Raw_sql()
	returnInfo = dict()
	returnInfo['info'] = getTaskInfo(processID, serialNo)
	returnInfo['info']['check'] = judgeWhetherStepFinished(serialNo, processID)

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
	returnInfo['data'].update({'step': getStepsBySerialNoAndProcessID(serialNo, processID)})
	return returnInfo

def WithOutListDataInsertFormDataBySerialNo(SerialNo, rawData, UserID, processID):
	"""
		根据任务流水号和原始数据插入数据库
		:param SerialNo:任务流水号
		:param rawData:插入之前的原始数据字典列表
		:param UserID:插入数据的检验员工号
		:param processID:表格ID
		:return:
		"""
	selectedStep        = rawData.pop('selectedStep') if 'selectedStep' in rawData else "" #如果没有这个键说明是保存状态,同时没有选择步骤
	isFinished          = rawData.pop('isSubmit')
	InspectTotalNumber = rawData.pop('totalCount') if 'totalCount' in rawData else 0
	rawData['SerialNo'] = SerialNo
	#区分F02
	formatData   = rawData
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	#区分F02
	columnsString = ",".join(formatData.keys()) + ",InspectorNo"
	valuesString  = ",".join([formatSQLValuesString(formatData[key]) for key in formatData.keys() ]) + ",'" + UserID + "'"
	raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)

	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID, InspectTotalNumber)
	raw.update()
	return

# 有listData的表格
def WithListDataGetFormDataBySerialNoAndUserID(serialNo, processID, UserID):
	"""
		根据流水号和表单ID获取表单数据
		:param serialNo:任务流水号
		:param processID:表单ID
		:param UserID:用户名，如果是ALL则表示汇总数据
		:return:返回对应的表单数据
	"""
	raw                = Raw_sql()
	returnInfo         = dict()
	returnInfo['info'] = getTaskInfo(processID, serialNo)
	returnInfo['info']['check'] = judgeWhetherStepFinished(serialNo, processID)

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
	returnInfo['data'].update({'step': getStepsBySerialNoAndProcessID(serialNo, processID)})
	return returnInfo

def WithListDataInsertFormDataBySerialNo(SerialNo, rawData, UserID, processID):
	"""
	根据任务流水号和原始数据插入数据库
	:param SerialNo:任务流水号
	:param rawData:插入之前的原始数据字典列表
	:param UserID:插入数据的检验员工号
	:param processID:表格ID
	:return:
	"""
	selectedStep = rawData.pop('selectedStep') if 'selectedStep' in rawData else "" #如果没有这个键说明是保存状态,同时没有选择步骤
	isFinished   = rawData.pop('isSubmit')
	InspectTotalNumber  = rawData.pop('totalCount') if 'totalCount' in rawData else 0
	rawData['SerialNo'] = SerialNo
	formatData   = transformRawDataIntoInsertFormatDict(rawData)
	raw = Raw_sql()
	raw.sql  = "DELETE FROM RMI_%s_DATA WHERE SerialNo = '%s' AND InspectorNo = '%s';"%(processID, SerialNo, UserID)
	for row in formatData:
		columnsString = ",".join(row.keys()) + ",InspectorNo"
		valuesString  = ",".join([formatSQLValuesString(row[key]) for key in row.keys() ]) + ",'" + UserID + "'"
		raw.sql      += "INSERT INTO RMI_%s_DATA(%s) VALUES(%s);"%(processID, columnsString, valuesString)
	raw.sql += updateStepStateAndModified(isFinished, processID, SerialNo, selectedStep, UserID, InspectTotalNumber)
	raw.update()
	return

def getAllQuestionsByQuestionClass(questionClass):
	"""
	根据产品类型筛选出所有的相关疵点
	:param questionClass:疵点种类
	:return:对应疵点种类的所有疵点
	"""
	raw       = Raw_sql()
	raw.sql   = "SELECT questionID as id, questionName as label FROM RMI_QUESTION WHERE questionClass LIKE '%%%%%s%%%%'"%questionClass
	res, cols = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(cols, res)

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
	              GROUP BY b.ProcessID, a.Name
	              ORDER BY STATES"""%(serialNo,serialNo,serialNo,serialNo)
	res, columns = raw.query_all(needColumnName=True)
	return translateQueryResIntoDict(columns, res)

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



