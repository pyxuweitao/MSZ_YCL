# -*- coding: utf-8 -*-
__author__ = "XuWeitao"
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseNotFound
from django.db import connection
from django.template.response import TemplateResponse
from django.template.loader import get_template
import urllib
import sys
from administration import *
from inspectFunction import *
import CommonUtilities
import taskEdit
import Configurations
import Statistic

reload(sys)
sys.setdefaultencoding('utf-8')


def index(request):
	html = get_template("index.html")
	return TemplateResponse(request, html)


def RTX_message(msg, receiver):
	server = '127.0.0.1'
	message = dict()
	receive_account = dict()
	message['msg'] = msg
	receive_account['receiver'] = receiver

	url_value_msg = urllib.urlencode(message)
	url_value_receiver = urllib.urlencode(receive_account)
	url = r'http://' + server + r'/sendnotify.cgi' + '?' + url_value_msg + '&' + url_value_receiver
	urllib.urlopen(url)


def login(request, Id):
	cursor = connection.cursor()
	if request.method == 'POST':
		data = json.loads(request.body)
		cursor.execute("select Password from RMI_ACCOUNT_USER where Id = '%s'" % Id)
		pw = cursor.fetchone()
		if not pw:
			return HttpResponse(status=401)
		pw = pw[0]
		if pw == data['Password']:
			#TODO:fix this bug
			cursor.execute("SELECT ID, Name, Password, DepartmentID, JobID, Permission,\
	  		CONVERT(varchar(16), CreateTime, 20) CreateTime, CONVERT(varchar(16), LastModifiedTime, 20) LastModifiedTime"
			               " FROM RMI_ACCOUNT_USER WHERE Id = '%s'" % Id)
			user_data = cursor.fetchone()
			col_names = [desc[0] for desc in cursor.description]
			user = dict(zip(col_names, user_data))
			request.session['UserId'] = Id
			request.session['Name'] = user['Name']
			response = HttpResponse(json.dumps(user, encoding='GB2312'), content_type="application/json")
			return response
		else:
			response = HttpResponse(status=401)
			return response
	else:
		response = HttpResponseBadRequest()
		return response

def logout(request, user):
	try:
		del request.session['UserId']
		del request.session['Name']
	except KeyError:
		pass
	return HttpResponse('logout!')

def editUser(request, Id):
	"""
	映射对应编辑用户信息的请求，其中包括新建和修改用户属性
	:param request: 请求
	:param Id: 用户ID
	:return: 1表示新增员工已经存在，0表示插入或者修改没有问题
	"""
	rawJson = request.body[5:]
	jsonContent = json.loads(rawJson)
	if jsonContent['isNew'] == 'True':
		if whetherAlreadyRegistered(Id):
			# 新增员工且已经存在该工号：代码为1
			return HttpResponse(1)
	editEmployeeInfo(jsonContent)
	# 没有插入或者修改问题则返回0
	return HttpResponse(0)

def deleteUser(request, Id):
	"""
	删除员工在RMI_ACCOUNT_USER中的信息
	:param request: 客户端请求
	:param Id: 用户ID
	:return:
	"""
	deleteUserInfo(Id)
	return HttpResponse()

def getDepartmentsAndJobs(request):
	"""
	获取有关部门的职位的信息
	:param request: 客户端请求
	:return: 返回Json字典，其中departments键包括组别信息，Jobs键包括职位信息
	"""
	return HttpResponse(json.dumps({"Departments":getAllDepartmentsInfo(),
	                                "Jobs":getAllJobsInfo()}, encoding='GB2312', ensure_ascii=False))

def users_info_operations(request):
	"""
	获取所有用户的信息
	:param request:客户端请求
	:return: 返回JSON用户信息，与数据库一一对应
	"""
	return HttpResponse(json.dumps(getUserInfo(), encoding='GB2312', ensure_ascii=False))


def user_info(request, Id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select * from RMI_ACCOUNT_USER where Id = '%s'" % Id)
		user_data = cursor.fetchone()
		if not user_data:
			return HttpResponseNotFound()
		col_names = [desc[0] for desc in cursor.description]
		user = dict(zip(col_names, user_data))
		return HttpResponse(json.dumps(user, encoding='GB2312'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


def getTasks(request, UserID):
	"""
	映射到获取所有对应检验列表的链接
	:param request: 客户端请求
	:param UserID: 如果是ALL在，则返回所有的检验任务列表，否则返回对应UserID的检验任务列表
	:return:返回JSON打包之后的检验任务信息列表
	"""
	return HttpResponse(json.dumps(taskEdit.getTasksList(UserID), ensure_ascii=False, encoding='GB2312'))

def editTask(request):
	"""
	映射到编辑任务的用户列表
	:param request:客户端请求，其中包含需要修改的任务的serialNo和对应的信息
	:return:
	"""
	taskEdit.editTaskInfo(json.loads(request.body[5:], encoding='utf-8'), request.session['UserId'])
	return HttpResponse()

def commitTask(request, SerialNo):
	"""
	通过任务
	:param request: 客户端请求
	:param SerialNo:任务流水号
	:return:
	"""
	taskEdit.commitTaskBySerialNo(SerialNo)
	return HttpResponse()

def getFlow(request):
	"""
	获取所有的工作流程列表
	:param request:客户端请求
	:return:返回所有键值对列表
	"""
	return HttpResponse(json.dumps(taskEdit.getFlowList(), encoding='GB2312'))

def getFormData(request, serialNo, processID, getMethod):
	"""
	根据流水号获取指定表格所有数据
	:param request: 客户端请求
	:param serialNo:任务流水号
	:param processID: 表格ID
	:param getMethod:Check：查看汇总，归并所有人的表格数据,dataEntry:WHERE出自己的数据
	:return: 返回相应JSON打包后的数据
	"""
	UserID = 'ALL' if getMethod == "Check" else request.session['UserId']
	if processID == "F01":
		return HttpResponse(json.dumps(getF01DataBySerialNoAndUserID(serialNo, processID, UserID), encoding='GB2312'))
	elif processID == "F02":
		return HttpResponse(json.dumps(getF02DataBySerialNoAndUserID(serialNo, processID, UserID), encoding='GB2312'))
	elif processID in ("F04", "F06", "F03", "F10"):#疲劳拉伸测试报告,成品洗涤测试报告, 实验室检测报告, #试模压
		return HttpResponse(json.dumps(withOutListDataGetFormDataBySerialNoAndUserID(serialNo, processID, UserID), encoding='GB2312'))
	elif processID in ("F05", "F07", "F08", "F09"):#模杯测试报告,海绵检验记录,白油检验报告，主料表
		return HttpResponse(json.dumps(WithListDataGetFormDataBySerialNoAndUserID(serialNo, processID, UserID), encoding='GB2312'))

def insertFormData(request, serialNo, processID ):
	"""
	向F01表格插入数据
	:param request:客户端请求
	:param processID: 表单ID
	:param serialNo:任务流水号
	:return:
	"""
	UserID = request.session['UserId']
	if processID == "F01":#商标纸卡不干贴
		insertF01DataBySerialNo(serialNo, json.loads(request.body[5:]), UserID)
	elif processID == "F02":#辅料检验表
		insertF02DataBySerialNo(serialNo, json.loads(request.body[5:]), UserID)
	elif processID in ("F04", "F06", "F03", "F10"):#疲劳拉伸测试报告,成品洗涤测试报告, 实验室检测报告
		WithOutListDataInsertFormDataBySerialNo(serialNo, json.loads(request.body[5:]), UserID, processID)
	elif processID in ("F05", "F07", "F08", "F09"):#模杯测试报告,海绵检验记录,白油检验报告,主料表
		WithListDataInsertFormDataBySerialNo(serialNo, json.loads(request.body[5:]), UserID, processID)

	return HttpResponse()

def getAllQuestions(request, questionClass):
	"""
	获取所有的主料疵点
	:param request:客户端请求
	:param questionClass:疵点种类
	:return: 返回指定格式的JSON
	"""
	return HttpResponse(json.dumps(getAllQuestionsByQuestionClass(questionClass), encoding='GB2312'))

def getTaskProcess(request, serialNo):
	"""
	根据任务流水号获取所有的表格的填写状态和相关信息
	:param request:客户端请求
	:param serialNo:任务流水号
	:return:与该任务对应的表单信息
	"""
	return HttpResponse(json.dumps(getAllProcessStepBySerialNo(serialNo), encoding='GB2312', cls=CommonUtilities.DecimalEncoder))

def deleteTask(request, serialNo):
	"""
	根据任务流水号删除任务所有相关数据
	:param request:客户端请求，包括任务流水号
	:param serialNo:任务流水号
	:return:
	"""
	taskEdit.deleteTaskBySerialNo(serialNo)
	return HttpResponse()

def passProcess(requests, serialNo, processID):
	"""
	审批界面通过一张表单
	:param requests:客户端请求
	:param serialNo: 任务流水号
	:param processID: 表单ID
	:return:
	"""
	UserID = requests.session['UserId']
	passProcessBySerialNo(serialNo, processID, UserID)
	return HttpResponse()

def SupplierInfo(request, fuzzySupplierName, supplierCode):
	"""
	供应商维护界面增删查改相关操作
	:param request:客户端请求，包括获取所有供应商信息，根据对应请求方法去修改、新建、删除供应商
	:param fuzzySupplierName:如果是模糊查询这个值为非空，为空时返回所有
	:param supplierCode:供应商代码
	:return:
	"""
	UserID   = request.session['UserId']
	supplier = Configurations.RestfulInfoAPI("RMI_SUPPLIER", "SupplierCode", request.session['UserId'])
	if request.method == 'GET':
		if fuzzySupplierName:
			return HttpResponse(json.dumps(
				supplier.getInfoByFuzzyInput(fuzzyInput=fuzzySupplierName, fuzzyFieldName='supplierName', columns=['SupplierCode', 'SupplierName'],
				                             columnsAlternativeNames=['id','name']), encoding='GBK'))
		else:
			return HttpResponse(json.dumps(
				supplier.getInfoByID(ID=supplierCode, queryFieldName='SupplierCode', columns=['SupplierCode', 'SupplierName'],
		                        columnsAlternativeNames=['id','name']), encoding='GBK'))
	elif request.method == 'POST':
		values = json.loads(request.POST['INFO'])
		supplier.newInfo(columns=['SupplierName', 'SupplierCode', 'LastModifiedTime', 'LastModifiedUser'],
		                 values=[values['name'], values['id'], 'GETDATE()', UserID ])
	elif request.method == 'PUT':
		info = json.loads(request.body[5:])
		supplier.updateInfo(
				updateInfoWhereValues=[supplierCode], updateInfoWhereColumns=['SupplierCode'],
				updateColumns=['SupplierName', 'SupplierCode'], updateValues=[info['name'], info['id']] )
	elif request.method == 'DELETE':
		supplier.deleteInfo(deleteIDFieldName='SupplierCode', deleteInfoID=supplierCode)
	return HttpResponse()

def MaterialTypeInfo(request, fuzzyMaterialTypeName, MaterialTypeID):
	"""
	材料种类维护界面增删查改相关操作
	:param request:客户端请求，包括获取所有供应商信息，根据对应请求方法去修改、新建、删除材料名称
	:param fuzzyMaterialTypeName:如果是模糊查询这个值为非空，为空时返回所有
	:param MaterialTypeID:材料名称种类代码
	:return:
	"""
	UserID   = request.session['UserId']
	MaterialType = Configurations.RestfulInfoAPI("RMI_MATERIAL_TYPE", 'MaterialTypeID', request.session['UserId'])
	if request.method == 'GET':
		if fuzzyMaterialTypeName:
			return HttpResponse(json.dumps(
				MaterialType.getInfoByFuzzyInput(fuzzyInput=fuzzyMaterialTypeName, fuzzyFieldName='MaterialTypeName', columns=['MaterialTypeID', 'MaterialTypeName', 'WorkTime'],
				                             columnsAlternativeNames=['id','name', 'time']), encoding='GBK'))
		else:
			pageNo           = int(request.GET['page'])
			pageSize         = int(request.GET['count'])
			materialTypeID   = request.GET['id']
			materialTypeName = request.GET['name']
			whereColumns     = list()
			whereValues      = list()
			if materialTypeID:
				whereColumns.append('MaterialTypeID')
				whereValues.append(materialTypeID)
			if materialTypeName:
				whereColumns.append('MaterialTypeName')
				whereValues.append(materialTypeName)
			return HttpResponse(json.dumps(
				MaterialType.getPagedInfo( pageNo=pageNo, pageSize=pageSize, columns=['MaterialTypeID', 'MaterialTypeName', 'WorkTime'],
		                        columnsAlternativeNames=['id','name', 'time'], whereColumns=whereColumns, whereValues=whereValues, orderString='LastModifiedTime DESC, MaterialTypeID ASC'), encoding='GBK'))
	elif request.method == 'POST':
		values = json.loads(request.POST['INFO'])
		MaterialType.newInfo(columns=['MaterialTypeName', 'MaterialTypeID', 'WorkTime', 'LastModifiedTime', 'LastModifiedUser'],
		                 values=[values['name'], values['id'], values['time'], 'GETDATE()', UserID ])
	elif request.method == 'PUT':
		info = json.loads(request.body[5:])
		MaterialType.updateInfo(
				updateInfoWhereValues=[MaterialTypeID], updateInfoWhereColumns=['MaterialTypeID'],
				updateColumns=['MaterialTypeName', 'WorkTime', 'MaterialTypeID'], updateValues=[info['name'], info['time'], info['id']] )
	elif request.method == 'DELETE':
		MaterialType.deleteInfo(deleteIDFieldName='MaterialTypeID', deleteInfoID=MaterialTypeID)
	return HttpResponse()



def test(request):
	raw = Raw_sql()
	for i in range(1,10):
		raw.sql = "INSERT INTO RMI_TASK WITH(ROWLOCK) (CreateTime, LastModifiedTime, ProductNo, ColorNo, ArriveTime, UserID, FlowID) "\
		          "VALUES( '2016-02-23 16:23:09.187',	'2016-02-23 16:23:09.187',	'234','234'	,'2016-02-06 00:00:00.000',	'1227401050','b6eb0acf-7c31-44f5-ae44-931ee2ff90a2' );"
		raw.update()
	return HttpResponse()

def unitInfo(request, fuzzyUnitName, unitID):
	"""
	计量单位维护界面增删查改相关操作，任务创建界面同样调用GET接口
	:param fuzzyUnitName:如果是模糊查询这个值为非空，为空时返回所有
	:param request:客户端请求，包括获取所有计量单位信息，根据对应请求方法去修改、新建、删除计量单位
	:param unitID:计量单位ID
	:return:
	"""
	unit = Configurations.RestfulInfoAPI("RMI_UNIT", 'UnitID', request.session['UserId'])
	if request.method == 'GET':
		if fuzzyUnitName:
			return HttpResponse(json.dumps(
				unit.getInfoByFuzzyInput(fuzzyInput=fuzzyUnitName, fuzzyFieldName='UnitName', columns=['UnitID', 'UnitName'],
				                             columnsAlternativeNames=['id','name']), encoding='GBK'))
		else:
			return HttpResponse(json.dumps(
				unit.getInfoByID(ID=unitID, queryFieldName='UnitID', columns=['UnitID', 'UnitName'],
		                        columnsAlternativeNames=['id','name']), encoding='GBK'))
	elif request.method == 'POST':
		unit.newInfo(columns=['UnitName'], values=[json.loads(request.POST['INFO'])['name']])
	elif request.method == 'PUT':
		unit.updateInfo(
				updateInfoWhereColumns=['UnitID'], updateInfoWhereValues=[unitID],
				updateColumns=['UnitName'], updateValues=[json.loads(request.body[5:])['name']] )
	elif request.method == 'DELETE':
		unit.deleteInfo(deleteIDFieldName='UnitID', deleteInfoID=unitID)
	return HttpResponse()

def getMaterialNames(request, fuzzyName):
	"""
	根据模糊输入获取所有材料名称的视图函数
	:param request: 客户端请求
	:param fuzzyName: 模糊输入
	:return: 材料名称打包的JSON
	"""
	return HttpResponse(json.dumps(taskEdit.getAllMaterialByName(fuzzyName), encoding='GBK'))


def suppliersAnalysis(request):
	"""
	供应商交货情况报表视图
	:param request:客户端请求，包括时间范围的开始时间start，时间范围的结束时间end
	:return:返回报表详细数据的JSON格式文本
	"""
	start = request.GET['start']
	end   = request.GET['end']
	return HttpResponse(json.dumps(Statistic.getSuppliersAssessmentDataByDate(start, end), encoding='GBK'))