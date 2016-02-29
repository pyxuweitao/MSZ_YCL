# -*- coding: utf-8 -*-
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden, HttpResponseNotFound
from django.db import connection, transaction
from django.template.response import TemplateResponse
from django.template.loader import get_template
import json
import random
import time
import urllib
import sys
from administration import *
from inspectFunction import *
import CommonUtilities

reload(sys)
sys.setdefaultencoding('utf-8')


def index(request):
	html = get_template("index.html")
	return TemplateResponse(request, html)


def record_opearion(IP, userId, url, method, type, id, operation):
	cursor = connection.cursor()
	cursor.execute(
			"insert into RMI_OPERATION_RECORDING(IP,UserId,Url,Method,[Type],Id,Operation,[Time]) values ('%s','%s','%s','%s','%s','%s','%s','%s')" % (
				IP, userId, url, method, type, id, operation, int(time.time() * 1000)))
	return


def condition_judge(str, status, tags):
	if str == '1':
		return True
	condition = str.split('&&')
	for item in condition:
		if '.Status==' in item:
			tmp = item.split('.Status==')
			if tmp[0] not in status:
				return False
			if status[tmp[0]] != tmp[1]:
				return False

		if '.Status!=' in item:
			tmp = item.split('.Status!=')
			if tmp[0] not in status:
				return False
			if status[tmp[0]] == tmp[1]:
				return False

		if '.Tags=>' in item:
			tmp = item.split('.Tags=>')
			if tmp[0] not in tags:
				return False
			if tags[tmp[0]] == None:
				return False
			if tmp[1] not in tags[tmp[0]]:
				return False

		if '.Tags!=>' in item:
			tmp = item.split('.Tags!=>')
			if tmp[0] not in tags:
				return False
			if tags[tmp[0]] != None:
				if tmp[1] in tags[tmp[0]]:
					return False
	return True


def isComplete(form_id):
	cursor = connection.cursor()
	cursor.execute(
			"select ArrivalSerialNumber,ProcessTypeId,ProcessNodeTypeId,Rev from RMI_FORM where Id = '%s'" % form_id)
	res = cursor.fetchone()
	if res[0] == 'ARRIVAL':
		return

	cursor.execute(
			"select AvailableFlag from RMI_PROCESS_NODE where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
				res[0], res[2]))
	flag = cursor.fetchone()[0]

	if flag == 'true':
		cursor.execute(
				"update RMI_PROCESS set IsComplete = 'true',CompleteTime = '%s' where ArrivalSerialNumber = '%s'" % (
					int(time.time() * 1000), res[0]))

	if flag == 'default':
		cursor.execute(
				"select CompleteCondition from RMI_PROCESS_TYPE where Id = '%s' and Rev = '%s'" % (res[1], res[3]))
		CompleteCondition = cursor.fetchone()[0].decode('GB2312')
		cursor.execute("select ProcessNodeTypeId,Status,Tags from RMI_FORM where ArrivalSerialNumber = '%s'" % res[0])
		result = cursor.fetchall()
		status = {}
		tags = {}
		for ele in result:
			status[ele[0]] = ele[1]
			if ele[2] != None:
				tags[ele[0]] = json.loads(ele[2], encoding='GB2312')
		if condition_judge(CompleteCondition, status, tags) == True:
			cursor.execute(
					"update RMI_PROCESS set IsComplete = 'true',CompleteTime = '%s' where ArrivalSerialNumber = '%s'" % (
						int(time.time() * 1000), res[0]))
	return


# def form_config(id):
#     cursor = connection.cursor()
#     cursor.execute("select ProcessTypeId,ProcessNodeTypeId,Rev from RMI_FORM where Id = '%s'" % id)
#     raw = cursor.fetchone()
#     cursor.execute("select FormConfig from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Id = '%s' and Rev = %s" % (raw[0],raw[1],raw[2]))
#     tableList = json.loads(cursor.fetchone()[0],encoding='GB2312')
#     return tableList


def generate_task(param, data):
	task = []
	for dic in data:
		dic['flag'] = dict(zip(param, [dic[key] for key in param]))
	if len(data):
		task.append(data[0]['flag'])
		for obj in data:
			if obj['flag'] not in task:
				task.append(obj['flag'])
	return task


def difference(list1, list2):
	res = []
	for dic1 in list1:
		count = 0
		for dic2 in list2:
			if cmp(dic1['Parameter'], dic2['Parameter']) == 0:
				count += 1
				break
		if count == 0:
			res.append(dic1)
	return res


def RTX_message(msg, receiver):
	server = '127.0.0.1'
	message = {}
	receive_account = {}
	message['msg'] = msg
	receive_account['receiver'] = receiver

	url_value_msg = urllib.urlencode(message)
	url_value_receiver = urllib.urlencode(receive_account)
	url = r'http://' + server + r'/sendnotify.cgi' + '?' + url_value_msg + '&' + url_value_receiver
	urllib.urlopen(url)


# def register(request):
#     cursor = connection.cursor()
#     if request.method == 'POST':
#         data = json.loads(request.body)
#         cursor.execute("insert into RMI_ACCOUNT_USER(Id,Username,Password,Avatar,Department,Job,Permission,CreateTime,LastModifiedTime) values('%s','%s','%s','%s','%s','%s','%s','%s','%s')" % (data['Id'],data['Username'],data['Password'],data['Avatar'],data['Department'],data['Job'],data['Permission'],int(time.time()*1000),int(time.time()*1000)))
#         transaction.commit_unless_managed()
#         return HttpResponse(request.body,content_type="aplication/json")
#     else:
#         return HttpResponseBadRequest()

def login(request, Id):
	try:
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
	except Exception,e:
		print e

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


# 创建随机数
def set_randhex(id, tableName):
	cursor = connection.cursor()
	randhex = hex(random.randint(1, 16777216)).replace('0x', '').zfill(6)
	cursor.execute("select * from %s where %s = '%s'" % (tableName, id, randhex))
	raw = cursor.fetchall()
	while len(raw):
		randhex = hex(random.randint(1, 16777216)).replace('0x', '').zfill(6)
		cursor.execute("select * from %s where %s = '%s'" % (tableName, id, randhex))
		raw = cursor.fetchall()
	return randhex


def get_form_config(request, form_id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select ProcessTypeId,ProcessNodeTypeId,Rev from RMI_FORM where Id = '%s'" % form_id)
		raw = cursor.fetchone()
		if not raw:
			return HttpResponseNotFound()
		cursor.execute(
				"select FormConfig from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Id = '%s' and Rev = %s" % (
					raw[0], raw[1], raw[2]))
		config = cursor.fetchone()[0]
		return HttpResponse(config.decode('GB2312').encode('UTF-8'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


# GET、POST正确
def get_form(request):
	if request.method == 'GET':
		# 查看到货清单等表单
		if 'ProcessTypeId' in request.GET and request.GET['ProcessTypeId'] and 'ProcessNodeTypeId' in request.GET and\
				request.GET['ProcessNodeTypeId']:
			ProcessTypeId = request.GET['ProcessTypeId']
			ProcessNodeTypeId = request.GET['ProcessNodeTypeId']
			Rev = request.GET['Rev']
			cursor = connection.cursor()
			if 'StartTime' in request.GET and request.GET['StartTime'] and 'EndTime' in request.GET and request.GET[
				'EndTime'] and 'Status' in request.GET and request.GET['Status']:
				cursor.execute(
						"select * from RMI_FORM_DATA where ProcessTypeId = '%s' and ProcessNodeTypeId = '%s' and Rev = '%s',Status = '%s' and CreateTime between '%s' and '%s' order by CreateTime desc" % (
							ProcessTypeId, ProcessNodeTypeId, Rev, request.GET['Status'], request.GET['StartTime'],
							request.GET['EndTime']))
			elif 'StartTime' in request.GET and request.GET['StartTime'] and 'EndTime' in request.GET and request.GET[
				'EndTime']:
				cursor.execute(
						"select * from RMI_FORM_DATA where ProcessTypeId = '%s' and ProcessNodeTypeId = '%s' and Rev = '%s',and CreateTime between '%s' and '%s' order by CreateTime desc" % (
							ProcessTypeId, ProcessNodeTypeId, Rev, request.GET['Status'], request.GET['StartTime']))
			elif 'Status' in request.GET and request.GET['Status']:
				cursor.execute(
						"select * from RMI_FORM_DATA where ProcessTypeId = '%s' and ProcessNodeTypeId = '%s' and Rev = '%s',and Status = '%s' order by CreateTime desc" % (
							ProcessTypeId, ProcessNodeTypeId, Rev, request.GET['Status']))
			else:
				cursor.execute(
						"select * from RMI_FORM_DATA where ProcessTypeId = '%s' and ProcessNodeTypeId = '%s' and Rev = '%s'order by CreateTime desc" % (
							ProcessTypeId, ProcessNodeTypeId, Rev))
			raw = cursor.fetchall()
			if not len(raw):
				return HttpResponseNotFound()
			col_names = [desc[0] for desc in cursor.description]
			list = [dict(zip(col_names, obj)) for obj in raw]
		else:
			return HttpResponseBadRequest()
		return HttpResponse(json.dumps(list, encoding='GB2312'), content_type="application/json")

	elif request.method == 'POST':
		# 创建新的到货清单
		data = json.loads(request.body)
		cursor = connection.cursor()

		if data['create'] != 'true':
			return HttpResponseBadRequest()

		randhex = set_randhex('Id', 'RMI_FORM')
		cursor.execute(
				"insert into RMI_FORM(Id,ArrivalSerialNumber,ProcessTypeId,ProcessNodeTypeId,[Status],CreateUserId,CreateTime,LastModifiedTime,LastModifiedUserId,Rev) values ('%s','%s','%s','%s','%s','%s','%s','%s','%s',%s)" % (
					randhex, data['ArrivalSerialNumber'], data['ProcessTypeId'], data['ProcessNodeTypeId'],
					data['Status'],
					request.session['UserId'], int(time.time() * 1000), int(time.time() * 1000),
					request.session['UserId'],
					data['Rev']))

		cursor.execute("select * from RMI_FORM where Id = '%s'" % randhex)
		raw = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		dic = dict(zip(col_names, raw))

		record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'], request.get_full_path(),
		                request.method, 'form', randhex, u'创建到货清单' + randhex)

		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(dic, ensure_ascii=False), content_type="application/json")
	else:
		return HttpResponseBadRequest()


# GET、POST正确
def get_form_id(request, id):
	cursor = connection.cursor()
	if request.method == 'GET':
		# 获取创建人、状态、创建时间等信息
		cursor.execute("select * from RMI_FORM_DATA where Id = '%s'" % id)
		raw = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		raw = dict(zip(col_names, raw))
		return HttpResponse(json.dumps(raw, encoding='GB2312'), content_type="application/json")

	elif request.method == 'POST':
		# 收货报告提交时更改状态并添加到到货队列，status和addtoarrival两个同时请求
		# 或者更改表单状态
		data = json.loads(request.body)
		if 'Status' in data:
			cursor.execute("update RMI_FORM set Status = '%s',LastModifiedTime = '%s' where Id = '%s'" % (
				data['Status'], int(time.time() * 1000), id))

			cursor.execute("select * from RMI_FORM where Id = '%s'" % id)
			form_data = cursor.fetchone()
			col_names = [desc[0] for desc in cursor.description]
			form_data = dict(zip(col_names, form_data))

			isComplete(id)

			msg = '收货报告' + id + '已提交！'
			# RTX_message(msg,'username')
			record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'],
			                request.get_full_path(), request.method, 'form', id, u'收货报告' + id + u'已提交')

			transaction.commit_unless_managed()
			return HttpResponse(json.dumps(form_data, encoding='GB2312'), content_type="application/json")

		if 'addToArrival' in data and data['addToArrival'] == 'true':
			# tableList = form_config(id)
			# for tableDict in tableList['Components']:
			#     if tableDict['Type'] == 'table':
			#         param = 'wuliaomingcheng,huohao,yanse,gongyingshang'
			#         cursor.execute("select distinct %s from %s where FormId = '%s'" % (param,tableDict['DatabaseTableName'],id))
			#         raw = cursor.fetchall()
			#         col_names = [desc[0] for desc in cursor.description]
			#         for parameter in raw:
			#             parameter = dict(zip(col_names, parameter))
			#             cursor.execute("select ProcessTypeId from RMI_PROCESS_TYPE_SUBCLASS where Subclass = '%s'" % str(parameter['wuliaomingcheng']).decode('GB2312'))
			#             process_type_id = cursor.fetchone()
			#             if not len(process_type_id):
			#                 continue
			#             randhex = set_randhex('ArrivalSerialNumber','RMI_ARRIVAL')
			#             cursor.execute("insert into RMI_ARRIVAL(ArrivalSerialNumber,ProcessTypeId,SourceFormId,OutFlag,InTime,Parameter) values('%s','%s','%s','false','%s','%s')" % (randhex,process_type_id[0],id,int(time.time()*1000),json.dumps(parameter,encoding='GB2312')))
			param = ['wuliaomingcheng', 'huohao', 'yanse', 'gongyingshang', 'shouhuodanhao']
			cursor.execute("select [Data] from RMI_FORM where Id = '%s'" % id)
			form_data = json.loads(cursor.fetchone()[0], encoding='GB2312')
			parameter = generate_task(param, form_data['arrival'])
			for ele in parameter:
				cursor.execute("select ProcessTypeId from RMI_PROCESS_TYPE_SUBCLASS where Subclass = '%s'" % ele[
					'wuliaomingcheng'])
				process_type_id = cursor.fetchone()
				if not len(process_type_id):
					continue
				randhex = set_randhex('ArrivalSerialNumber', 'RMI_ARRIVAL')
				cursor.execute(
						"insert into RMI_ARRIVAL(ArrivalSerialNumber,ProcessTypeId,SourceFormId,OutFlag,InTime,Parameter) values('%s','%s','%s','false','%s','%s')" % (
							randhex, process_type_id[0], id, int(time.time() * 1000),
							json.dumps(ele, encoding='GB2312')))

			cursor.execute("select * from RMI_FORM_DATA where Id = '%s'" % id)
			form_data = cursor.fetchone()
			description = [desc[0] for desc in cursor.description]
			form_data = dict(zip(description, form_data))

			msg = '收货报告' + id + '已加入到货队列！'
			# RTX_message(msg,'username')

			record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'],
			                request.get_full_path(), request.method, 'form', id, u'收货报告' + id + u'已加入到货队列')

			transaction.commit_unless_managed()
			return HttpResponse(json.dumps(form_data, encoding='GB2312'), content_type="application/json")

		# 添加到到货队列同时添加到待检验队列
		if 'addToArrivalAndAddToProcess' in data and data['addToArrivalAndAddToProcess'] == 'true':
			# tableList = form_config(id)
			# for tableDict in tableList['Components']:
			#     if tableDict['Type'] == 'table':
			#         reference = {}
			#         reference['Arrival'] = {}
			#         reference['Arrival']['Arrival'] = {}
			#         reference['Arrival']['GenerateCondition'] = {}
			#
			#         param = 'wuliaomingcheng,huohao,yanse,gongyingshang'
			#         cursor.execute("select distinct %s from %s where FormId = '%s'" % (param,tableDict['DatabaseTableName'],id))
			#         raw = cursor.fetchall()
			#         col_names = [desc[0] for desc in cursor.description]
			#         raw = [dict(zip(col_names, item)) for item in raw]
			#
			#         reference['Arrival']['Arrival']['Data'] = raw
			#
			#         for parameter in raw:
			#             cursor.execute("select ProcessTypeId from RMI_PROCESS_TYPE_SUBCLASS where Subclass = '%s'" % str(parameter['wuliaomingcheng']).decode('GB2312'))
			#             process_type_id = cursor.fetchone()
			#             if not len(process_type_id):
			#                 continue
			#             cursor.execute("select top 1 Rev from RMI_PROCESS_TYPE where Id = '%s' order by Rev DESC" % process_type_id[0])
			#             rev = cursor.fetchone()[0]
			#
			#             reference['Arrival']['GenerateCondition']['Data'] = parameter
			#             refer = json.dumps(reference,encoding='GB2312')
			#             randhex = set_randhex('ArrivalSerialNumber','RMI_ARRIVAL')
			#             #mark
			#             cursor.execute("insert into RMI_PROCESS(ArrivalSerialNumber,TypeId,StartTime,IsComplete,Rev,Reference,Parameter) values('%s','%s','%s','false',%s,'%s','%s')" %(randhex,process_type_id[0],int(time.time()*1000),rev,refer,json.dumps(parameter,encoding='GB2312')))
			#             cursor.execute("insert into RMI_ARRIVAL(ArrivalSerialNumber,ProcessTypeId,SourceFormId,OutFlag,InTime,OutTime,Parameter) values('%s','%s','%s','true','%s','%s','%s')" % (randhex,process_type_id[0],id,int(time.time()*1000),int(time.time()*1000),json.dumps(parameter,encoding='GB2312')))
			#
			#             cursor.execute("select Id from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = '%s'" % (process_type_id[0],rev))
			#             process_node_type_ids = cursor.fetchall()
			#             for process_node_type_id in process_node_type_ids:
			#                 cursor.execute("insert into RMI_PROCESS_NODE(ArrivalSerialNumber,ProcessNodeTypeId,AvailableFlag) values('%s','%s','default')" % (randhex,process_node_type_id[0]))

			# mark reference待考虑
			param = ['wuliaomingcheng', 'huohao', 'yanse', 'gongyingshang', 'shouhuodanhao']
			cursor.execute("select [Data] from RMI_FORM where Id = '%s'" % id)
			form_data = json.loads(cursor.fetchone()[0], encoding='GB2312')
			parameter = generate_task(param, form_data['arrival'])
			form_parameter = {}
			form_parameter['processes'] = []
			for ele in parameter:
				cursor.execute("select ProcessTypeId from RMI_PROCESS_TYPE_SUBCLASS where Subclass = '%s'" % ele[
					'wuliaomingcheng'])
				process_type_id = cursor.fetchone()
				if not len(process_type_id):
					continue
				cursor.execute(
						"select top 1 Rev from RMI_PROCESS_TYPE where Id = '%s' order by Rev DESC" % process_type_id[0])
				rev = cursor.fetchone()[0]
				randhex = set_randhex('ArrivalSerialNumber', 'RMI_ARRIVAL')
				form_parameter['processes'].append(randhex)
				cursor.execute(
						"insert into RMI_PROCESS(ArrivalSerialNumber,TypeId,StartTime,IsComplete,Rev,Parameter) values('%s','%s','%s','false','%s','%s')" % (
							randhex, process_type_id[0], int(time.time() * 1000), rev,
							json.dumps(ele, encoding='GB2312')))
				cursor.execute(
						"insert into RMI_ARRIVAL(ArrivalSerialNumber,ProcessTypeId,SourceFormId,OutFlag,InTime,Parameter) values('%s','%s','%s','false','%s','%s')" % (
							randhex, process_type_id[0], id, int(time.time() * 1000),
							json.dumps(ele, encoding='GB2312')))

				cursor.execute("select Id from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = '%s'" % (
					process_type_id[0], rev))
				process_node_type_ids = cursor.fetchall()
				for process_node_type_id in process_node_type_ids:
					cursor.execute(
							"insert into RMI_PROCESS_NODE(ArrivalSerialNumber,ProcessNodeTypeId,AvailableFlag) values('%s','%s','default')" % (
								randhex, process_node_type_id[0]))

			cursor.execute("update RMI_FORM set Parameter = '%s' where Id = '%s'" % (json.dumps(form_parameter), id))

			cursor.execute("select * from RMI_FORM_DATA where Id = '%s'" % id)
			form_data = cursor.fetchone()
			description = [desc[0] for desc in cursor.description]
			form_data = dict(zip(description, form_data))

			msg = '收货报告' + id + '已加入到货队列并且送至待检验队列！'
			# RTX_message(msg,'username')

			record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'],
			                request.get_full_path(), request.method, 'form', id, u'收货报告' + id + u'已加入到货队列并且送至待检验队列')

			transaction.commit_unless_managed()
			return HttpResponse(json.dumps(form_data, encoding='GB2312'), content_type="application/json")

		if 'reAddToArrivalAndAddToProcess' in data and data['reAddToArrivalAndAddToProcess'] == 'true':

			# mark reference待考虑
			# 获取旧数据
			cursor.execute("select ArrivalSerialNumber,Parameter from RMI_ARRIVAL where SourceFormId = '%s'" % id)
			res = cursor.fetchall()
			old_param = [dict(zip([desc[0] for desc in cursor.description], item)) for item in res]
			for ele in old_param:
				ele['Parameter'] = json.loads(ele['Parameter'], encoding='GB2312')

			param = ['wuliaomingcheng', 'huohao', 'yanse', 'gongyingshang', 'shouhuodanhao']

			# 获取新数据
			cursor.execute("select [Data] from RMI_FORM where Id = '%s'" % id)
			form_data = json.loads(cursor.fetchone()[0], encoding='GB2312')
			parameter = generate_task(param, form_data['arrival'])
			new_param = []
			for item in parameter:
				dic = {}
				dic['Parameter'] = item
				dic['ArrivalSerialNumber'] = set_randhex('ArrivalSerialNumber', 'RMI_ARRIVAL')
				new_param.append(dic)

			new = difference(new_param, old_param)
			old = difference(old_param, new_param)

			for item in old:
				cursor.execute("delete from RMI_ARRIVAL where ArrivalSerialNumber = '%s'" % item['ArrivalSerialNumber'])
				cursor.execute("delete from RMI_PROCESS where ArrivalSerialNumber = '%s'" % item['ArrivalSerialNumber'])
				cursor.execute("delete from RMI_FORM where ArrivalSerialNumber = '%s'" % item['ArrivalSerialNumber'])
				cursor.execute(
						"delete from RMI_PROCESS_NODE where ArrivalSerialNumber = '%s'" % item['ArrivalSerialNumber'])

			form_parameter = {}
			form_parameter['processes'] = []
			for ele in new:
				ele = ele['Parameter']
				cursor.execute("select ProcessTypeId from RMI_PROCESS_TYPE_SUBCLASS where Subclass = '%s'" % ele[
					'wuliaomingcheng'])
				process_type_id = cursor.fetchone()
				if not len(process_type_id):
					continue
				cursor.execute(
						"select top 1 Rev from RMI_PROCESS_TYPE where Id = '%s' order by Rev DESC" % process_type_id[0])
				rev = cursor.fetchone()[0]
				randhex = set_randhex('ArrivalSerialNumber', 'RMI_ARRIVAL')
				form_parameter['processes'].append(randhex)
				cursor.execute(
						"insert into RMI_PROCESS(ArrivalSerialNumber,TypeId,StartTime,IsComplete,Rev,Parameter) values('%s','%s','%s','false','%s','%s')" % (
							randhex, process_type_id[0], int(time.time() * 1000), rev,
							json.dumps(ele, encoding='GB2312')))
				cursor.execute(
						"insert into RMI_ARRIVAL(ArrivalSerialNumber,ProcessTypeId,SourceFormId,OutFlag,InTime,Parameter) values('%s','%s','%s','false','%s','%s')" % (
							randhex, process_type_id[0], id, int(time.time() * 1000),
							json.dumps(ele, encoding='GB2312')))

				cursor.execute("select Id from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = '%s'" % (
					process_type_id[0], rev))
				process_node_type_ids = cursor.fetchall()
				for process_node_type_id in process_node_type_ids:
					cursor.execute(
							"insert into RMI_PROCESS_NODE(ArrivalSerialNumber,ProcessNodeTypeId,AvailableFlag) values('%s','%s','default')" % (
								randhex, process_node_type_id[0]))

			cursor.execute("update RMI_FORM set Parameter = '%s' where Id = '%s'" % (json.dumps(form_parameter), id))

			cursor.execute("select * from RMI_FORM_DATA where Id = '%s'" % id)
			form_data = cursor.fetchone()
			description = [desc[0] for desc in cursor.description]
			form_data = dict(zip(description, form_data))

			msg = '收货报告' + id + '已加入到货队列并且送至待检验队列！'
			# RTX_message(msg,'username')

			record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'],
			                request.get_full_path(), request.method, 'form', id, u'收货报告' + id + u'修改')

			transaction.commit_unless_managed()
			return HttpResponse(json.dumps(form_data, encoding='GB2312'), content_type="application/json")

	else:
		return HttpResponseBadRequest()


# #fetchone-->()  fetchall-->[()]
def get_data(request, form_id):
	cursor = connection.cursor()
	if request.method == 'GET':
		# 获取物料名称、颜色等用户需要填的信息
		cursor.execute("select [Data] from RMI_FORM where Id = '%s'" % form_id)
		data = cursor.fetchone()[0]
		if data is None:
			return HttpResponse(json.dumps({}), content_type="application/json")
		else:
			return HttpResponse(data.decode('GB2312').encode('UTF-8'), content_type="application/json")
			# form_config = get_form_config(form_id)
			#
			# for data_dic in form_config['Components']:
			# 添加data
			# if data_dic['Type'] == 'table':
			#     cursor.execute("select * from %s where FormId = '%s'" % (data_dic['DatabaseTableName'],form_id))
			#     data = cursor.fetchall()
			#     col_names = [desc[0] for desc in cursor.description]
			#     data_dic['Data'] = []
			#     if len(data):
			#         data_dic['Data'] = [dict(zip(col_names,elem)) for elem in data]
			#         for item in data_dic['Data']:
			#             item.pop('FormId')
			# if data_dic['Type'] == 'map':
			#     cursor.execute("select * from %s where FormId = '%s'" % (data_dic['DatabaseTableName'],form_id))
			#     data = cursor.fetchone()
			#     col_names = [desc[0] for desc in cursor.description]
			#     data_dic['Data'] = {}
			#     if len(data):
			#         data_dic['Data'] = dict(zip(col_names,data))
			#         data_dic['Data'].pop('FormId')

			# 添加OptionResources和Options
			# for config_dic in data_dic['Config']:
			#     if 'OptionResources' in config_dic:
			#         if 'Options' not in config_dic:
			#             config_dic['Option'] = []
			#         for name in config_dic['OptionResources']:
			#             cursor.execute("select [Type],[Value] from RMI_FORM_RESOURCE_OPTION where [Name] = '%s'" % name)
			#             res = cursor.fetchone()
			#             #mark理论上只有一个，但不排除有错的可能性
			#             if res[0] == 'value':
			#                 value = json.loads(res[1],encoding='GB2312')#list
			#                 for elem in value:
			#                     config_dic['Option'].append(elem)

			# return HttpResponse(json.dumps(form_config,encoding='GB2312'),content_type="application/json")

	elif request.method == 'PUT':
		# 保存用户所填的的数据
		# data_list = json.loads(request.body)#['Components']
		# for data_dic in data_list:
		#     if not data_dic['Data']:
		#         continue
		#     cursor.execute("select FormId from %s where FormId = '%s'" % (data_dic['DatabaseTableName'],form_id))
		#     id = cursor.fetchall()
		#     if len(id):
		#         cursor.execute("delete from %s where FormId = '%s'" % (data_dic['DatabaseTableName'],form_id))
		#     if data_dic['Type'] == 'table':
		#         for data in data_dic['Data']:
		#             col_names = ','.join(['['+unicode(key)+']' for key in data.keys()])
		#             values = ','.join(["'"+unicode(value)+"'"for value in data.values()])
		#             #mark
		#             values = values.replace("'None'",'Null')
		#             cursor.execute("insert into %s(FormId,%s) values('%s',%s)" % (data_dic['DatabaseTableName'],col_names,form_id,values))
		#     if data_dic['Type'] == 'map':
		#         col_names = ','.join(['['+unicode(key)+']' for key in data_dic['Data'].keys()])
		#         values = ','.join(["'"+unicode(value)+"'"for value in data_dic['Data'].values()])
		#         #mark
		#         values = values.replace("'None'",'Null')
		#         cursor.execute("insert into %s(FormId,%s) values('%s',%s)" % (data_dic['DatabaseTableName'],col_names,form_id,values))

		cursor.execute("update RMI_FORM set [Data] = '%s' where Id = '%s'" % (request.body, form_id))

		record_opearion(request.META.get('REMOTE_ADDR', 'unknown'), request.session['UserId'], request.get_full_path(),
		                request.method, 'form', form_id, u'保存' + form_id + u'数据')

		transaction.commit_unless_managed()
		return HttpResponse(request.body, content_type="application/json")
	else:
		return HttpResponseBadRequest()


def get_all_processes(request):
	cursor = connection.cursor()
	# 根据检验类型查看检验队列（含完成与未完成）
	# if request.method == 'GET' and 'Class' in request.GET:
	#     #待检验的数据，根据主料还是辅料分类
	#     cursor.execute("select * from RMI_PROCESS_DATA where TypeClass = '%s'" % request.GET['Class'])
	#     res = cursor.fetchall()
	#     col_names = [desc[0] for desc in cursor.description]
	#     data = [dict(zip(col_names,elem)) for elem in res]
	#     for dic in data:
	#         dic['Nodes'] = []
	#         cursor.execute("select Id,[Order],ProcessTypeId,AvailableCondition,[Name],Description from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s'" % dic['TypeId'])
	#         raw = cursor.fetchall()
	#         type_names = [desc[0] for desc in cursor.description]
	#         for obj in raw:
	#             inner_dict = {}
	#             inner_dict['Type'] = dict(zip(type_names,obj))
	#             cursor.execute("select * from RMI_FORM where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (dic['ArrivalSerialNumber'],inner_dict['Type']['Id']))
	#             form = cursor.fetchone()
	#             form_names = [desc[0] for desc in cursor.description]
	#             inner_dict['Form'] = dict(zip(form_names,form))
	#             dic['Nodes'].append(inner_dict)
	#     return HttpResponse(json.dumps(data,encoding='GB2312'),content_type="application/json")

	# 切换视图时的所需数据，根据检验流程的ID，如勾袢商标等
	if request.method == 'POST' and 'ProcessTypeId' in request.POST and 'Rev' in request.POST:
		# rev
		if 'StartTime' in request.POST and request.POST['StartTime'] and 'EndTime' in request.POST and request.POST[
			'EndTime'] and 'IsComplete' in request.POST and request.POST['IsComplete']:
			cursor.execute(
					"select * from RMI_PROCESS_DATA where TypeId = '%s' and Rev = '%s' and IsComplete = '%s' and StartTime between '%s' and '%s' order by StartTime desc" % (
						request.POST['ProcessTypeId'], request.POST['Rev'], request.POST['IsComplete'],
						request.POST['StartTime'], request.POST['EndTime']))
		elif 'StartTime' in request.GET and request.POST['StartTime'] and 'EndTime' in request.POST and request.POST[
			'EndTime']:
			cursor.execute(
					"select * from RMI_PROCESS_DATA where TypeId = '%s' and Rev = '%s' and StartTime between '%s' and '%s' order by StartTime desc" % (
						request.POST['ProcessTypeId'], request.POST['Rev'], request.POST['StartTime'],
						request.POST['EndTime']))
		elif 'IsComplete' in request.GET and request.GET['IsComplete']:
			cursor.execute(
					"select * from RMI_PROCESS_DATA where TypeId = '%s' and Rev = '%s' and IsComplete = '%s' order by StartTime desc" % (
						request.POST['ProcessTypeId'], request.POST['Rev'], request.POST['IsComplete']))
		else:
			cursor.execute(
					"select * from RMI_PROCESS_DATA where TypeId = '%s' and Rev = '%s' order by StartTime desc" % (
						request.POST['ProcessTypeId'], request.POST['Rev']))
		res = cursor.fetchall()
		col_names = [desc[0] for desc in cursor.description]
		data = [dict(zip(col_names, elem)) for elem in res]
		for dic in data:
			dic['Nodes'] = []
			ASN = dic['ArrivalSerialNumber']
			cursor.execute("select SourceFormId from RMI_ARRIVAL where ArrivalSerialNumber = '%s'" % ASN)
			dic['SourceFormId'] = cursor.fetchone()[0]
			cursor.execute("select ProcessNodeTypeId,Status,Tags from RMI_FORM where ArrivalSerialNumber = '%s'" % ASN)
			result = cursor.fetchall()
			status = {}
			tags = {}
			for ele in result:
				status[ele[0]] = ele[1]
				if ele[2] is not None:
					tags[ele[0]] = json.loads(ele[2], encoding='GB2312')
			cursor.execute(
					"select Id,[Order],ProcessTypeId,AvailableCondition,[Name],Description from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = '%s'" % (
						request.POST['ProcessTypeId'], request.POST['Rev']))
			raw = cursor.fetchall()
			type_names = [desc[0] for desc in cursor.description]
			for obj in raw:
				inner_dict = dict(zip(type_names, obj))
				cursor.execute(
						"select AvailableFlag,CheckStatus,CheckUserId,CheckTime,Conclusion from RMI_PROCESS_NODE where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
							ASN, inner_dict['Id']))
				check_data = cursor.fetchone()
				if check_data[0] == 'default':
					inner_dict['Available'] = condition_judge(inner_dict['AvailableCondition'], status, tags)
				else:
					inner_dict['Available'] = check_data[0]
				node_name = [desc[0] for desc in cursor.description]
				inner_dict.update(dict(zip(node_name, check_data)))
				cursor.execute(
						"select * from RMI_FORM where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
							ASN, inner_dict['Id']))
				form = cursor.fetchone()
				form_names = [desc[0] for desc in cursor.description]
				inner_dict['Form'] = dict(zip(form_names, form))
				dic['Nodes'].append(inner_dict)
		return HttpResponse(json.dumps(data, encoding='GB2312'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


def get_process(request, ASN):
	cursor = connection.cursor()
	if request.method == 'GET':
		# 根据流水号查看某一行时所需数据
		cursor.execute("select * from RMI_PROCESS_DATA where ArrivalSerialNumber = '%s'" % ASN)
		res = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		dic = dict(zip(col_names, res))
		dic['Nodes'] = []
		cursor.execute("select SourceFormId from RMI_ARRIVAL where ArrivalSerialNumber = '%s'" % ASN)
		dic['SourceFormId'] = cursor.fetchone()[0]
		cursor.execute("select ProcessNodeTypeId,Status,Tags from RMI_FORM where ArrivalSerialNumber = '%s'" % ASN)
		result = cursor.fetchall()
		status = {}
		tags = {}
		for ele in result:
			status[ele[0]] = ele[1]
			if ele[2] is not None:
				tags[ele[0]] = json.loads(ele[2], encoding='GB2312')
		cursor.execute(
				"select Id,[Order],ProcessTypeId,AvailableCondition,[Name],Description from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = '%s'" % (
					dic['TypeId'], dic['Rev']))
		raw = cursor.fetchall()
		type_names = [desc[0] for desc in cursor.description]
		for obj in raw:
			inner_dict = dict(zip(type_names, obj))
			cursor.execute(
					"select AvailableFlag,CheckStatus,CheckUserId,CheckTime,Conclusion from RMI_PROCESS_NODE where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
						ASN, inner_dict['Id']))
			check_data = cursor.fetchone()
			node_name = [desc[0] for desc in cursor.description]
			if check_data[0] == 'default':
				inner_dict['Available'] = condition_judge(inner_dict['AvailableCondition'], status, tags)
			else:
				inner_dict['Available'] = check_data[0]
			inner_dict.update(dict(zip(node_name, check_data)))
			cursor.execute("select * from RMI_FORM where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
				ASN, inner_dict['Id']))
			form = cursor.fetchone()
			form_names = [desc[0] for desc in cursor.description]
			inner_dict['Form'] = dict(zip(form_names, form))
			dic['Nodes'].append(inner_dict)
		return HttpResponse(json.dumps(dic, encoding='GB2312'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


# GET正确
# 好像没用到
def add_all_arrival_process(request):
	cursor = connection.cursor()
	if request.method == 'GET' and 'Class' in request.GET:
		# 查看到货队列
		cursor.execute("select * from RMI_ARRIVAL_TYPE where Class = '%s'" % request.GET['Class'])
		raw = cursor.fetchall()
		col_names = [desc[0] for desc in cursor.description]
		result = [dict(zip(col_names, item)) for item in raw]
		return HttpResponse(json.dumps(result, encoding='GB2312'), content_type="application/json")

	if request.method == 'POST':
		# 加入待检队列,可能要改
		data = json.loads(request.body)
		if data['addToProcess'] != 'true':
			return HttpResponse('what do you want to do?')
		cursor.execute("SELECT ArrivalSerialNumber,ProcessTypeId FROM RMI_ARRIVAL WHERE OutFlag = 'false'")
		raw = cursor.fetchall()
		for obj in raw:
			cursor.execute(
					"insert into RMI_PROCESS(ArrivalSerialNumber,TypeId,IsComplete) values('%s','%s','false')" % (
						obj[0], obj[1]))
			cursor.execute("update RMI_ARRIVAL set OutFlag = 'true',OutTime = '%s' where ArrivalSerialNumber = '%s'" % (
				int(time.time() * 1000), obj[0]))
			transaction.commit_unless_managed()
		return HttpResponse('Update successfully!')
	else:
		return HttpResponseBadRequest()


# 目前没用到
def add_arrival_process(request, ASN):
	cursor = connection.cursor()
	if request.method == 'POST':
		data = json.loads(request.body)
		if data['addToProcess'] != 'true':
			return HttpResponse('what do you want to do?')
		cursor.execute(
				"select ProcessTypeId from RMI_ARRIVAL where OutFlag = 'false' and ArrivalSerialNumber = '%s'" % ASN)
		raw = cursor.fetchone()
		if not len(raw):
			return HttpResponseBadRequest()
		cursor.execute(
				"insert into RMI_PROCESS(ArrivalSerialNumber,TypeId,IsComplete) values('%s','%s','false')" % (
				ASN, raw[0]))
		cursor.execute("update RMI_ARRIVAL set OutFlag = 'true',OutTime = '%s' where ArrivalSerialNumber = '%s'" % (
			int(time.time() * 1000), ASN))
		transaction.commit_unless_managed()
		return HttpResponse('Update successfully!')
	else:
		return HttpResponseBadRequest()


def kvstore(request, key):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select [Value] from RMI_KVSTORE where [Key] = '%s'" % key)
		values = cursor.fetchone()
		if not len(values):
			return HttpResponseNotFound()
		return HttpResponse(values[0].decode('GB2312'))
	elif request.method == 'POST':  # 增
		value = request.body
		cursor.execute("select * from RMI_KVSTORE where [Key] = '%s'" % key)
		res = cursor.fetchone()
		if len(res):
			return HttpResponseBadRequest()
		cursor.execute("insert into RMI_KVSTORE ([Key],[Value]) values ('%s','%s')" % (key, value))
		transaction.commit_unless_managed()
		return HttpResponse(value)
	elif request.method == 'PUT':  # 改
		value = request.body
		cursor.execute("update RMI_KVSTORE set [Value] = '%s' where [Key] = '%s'" % (value, key))
		transaction.commit_unless_managed()
		return HttpResponse(value)
	elif request.method == 'DELETE':
		cursor.execute("select [Value] from RMI_KVSTORE where [Key] = '%s'" % key)
		value = cursor.fetchone()
		if not len(value):
			return HttpResponseBadRequest()
		cursor.execute("delete from RMI_KVSTORE where [Key] = '%s'" % key)
		transaction.commit_unless_managed()
		return HttpResponse(value[0].decode('GB2312'))
	else:
		return HttpResponseBadRequest()


def process_type_all_operation(request):
	# 根据主料或辅料获取检验类型分类（商标、勾袢等）
	# mark
	cursor = connection.cursor()
	if request.method == 'GET':
		if 'Class' in request.GET:
			cursor.execute("select * from RMI_PROCESS_TYPE where Class = '%s'" % request.GET['Class'])
		else:
			cursor.execute("SELECT * FROM RMI_PROCESS_TYPE")
		raw = cursor.fetchall()
		col_names = [desc[0] for desc in cursor.description]
		raw = [dict(zip(col_names, item)) for item in raw]
		return HttpResponse(json.dumps(raw, encoding='GB2312'), content_type='application/json')
	else:
		return HttpResponseBadRequest()


def process_type_operation(request, type_id):
	# 对检验流程增删查改
	cursor = connection.cursor()
	if request.method == 'GET':
		# mark
		cursor.execute("select * from RMI_PROCESS_TYPE where Id = '%s' and Rev = %s" % (type_id, request.GET['Rev']))
		res = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		res = dict(zip(col_names, res))
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type='application/json')
	elif request.method == 'POST':  # 增
		data = json.loads(request.body)
		cursor.execute("select * from RMI_PROCESS_TYPE where Id = '%s' and Rev = %s " % (type_id, data['Rev']))
		res = cursor.fetchone()
		if len(res):
			return HttpResponseBadRequest()
		col_names = ','.join(['[' + unicode(key) + ']' for key in data.keys()])
		values = ','.join(["'" + unicode(value) + "'" for value in data.values()])
		cursor.execute("insert into RMI_PROCESS_TYPE (%s) values (%s)" % (col_names, values))
		transaction.commit_unless_managed()
		return HttpResponse(request.body, content_type="application/json")
	# elif request.method == 'PUT':#改
	#     data = json.loads(request.body)
	#     for key,value in data.iteritems():#此处title已删
	#         cursor.execute("update RMI_PROCESS_TYPE set %s = '%s' where Id = '%s'" % (key,value,type_id))
	#     transaction.commit_unless_managed()
	#     return HttpResponse(json.dumps(data,ensure_ascii=False),content_type="application/json")
	# elif request.method == 'DELETE':
	#     cursor.execute("select * from RMI_PROCESS_TYPE where Id = '%s' and Rev = %s" % (type_id,))
	#     res = cursor.fetchone()
	#     if not len(res):
	#         return HttpResponseBadRequest()
	#     cursor.execute("delete from RMI_PROCESS_TYPE where Id = '%s'" % type_id)
	#     transaction.commit_unless_managed()
	#     return HttpResponse(json.dumps(res,encoding='GB2312'),content_type="application/json")
	else:
		return HttpResponseBadRequest()


def process_node_type_all_operation(request, type_id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select * from RMI_PROCESS_NODE_TYPE where ProcessTypeId = '%s' and Rev = %s" % (
			type_id, request.GET['Rev']))
		res = cursor.fetchall()
		col_names = [desc[0] for desc in cursor.description]
		res = [dict(zip(col_names, item)) for item in res]
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type="application/json")

	if request.method == 'POST':  # 增
		data_list = json.loads(request.body)
		for data_dic in data_list:
			cursor.execute(
					"select * from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s' and Rev = %s" % (
						data_dic['Id'], type_id, data_dic['Rev']))
			res = cursor.fetchone()
			if len(res):
				return HttpResponseBadRequest()

			data_dic['FormConfig'] = json.dumps(data_dic['FormConfig'])  # 先转成json字符串

			col_names = ','.join(['[' + unicode(key) + ']' for key in data_dic.keys()])
			values = ','.join(["'" + unicode(value) + "'" for value in data_dic.values()])
			cursor.execute("insert into RMI_PROCESS_NODE_TYPE (%s) values (%s)" % (col_names, values))

			# mark有可能创建的表单数据库中已存在
			for item in json.loads(data_dic['FormConfig'])['Components']:
				# attribute_name = ['['+dic['AttributeName'].encode('UTF-8')+'] varchar(50)' for dic in item['Config']]
				attribute_name = ['[' + unicode(dic['AttributeName']) + '] varchar(50)' for dic in item['Config']]
				if item['Type'] == 'table':
					cursor.execute("create table %s([FormId] varchar(50),%s,[ClientCreateTime] varchar(50))" % (
						item['DatabaseTableName'], ','.join(attribute_name)))
				if item['Type'] == 'map':
					cursor.execute("create table %s([FormId] varchar(50),%s)" % (
						item['DatabaseTableName'], ','.join(attribute_name)))
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(data_list, ensure_ascii=False), content_type="application/json")

	# elif request.method == 'PUT':
	#     data_list = json.loads(request.body)
	#     for data_dic in data_list:
	#         cursor.execute("delete from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s'" % (data_dic['Id'],type_id))
	#
	#         data_dic['FormConfig'] = json.dumps(data_dic['FormConfig'])#先转成json字符串
	#
	#         col_names = ','.join(['['+unicode(key)+']' for key in data_dic.keys()])
	#         values = ','.join(["'"+unicode(value)+"'" for value in data_dic.values()])
	#         cursor.execute("insert into RMI_PROCESS_NODE_TYPE (%s) values(%s)" % (col_names,values))
	#
	#         for item in json.loads(data_dic['FormConfig'])['Components']:
	#             cursor.execute("drop table %s" % item['DatabaseTableName'])
	#             #attribute_name = ['['+dic['AttributeName'].encode('UTF-8')+'] varchar(50)' for dic in item['Config']]
	#             attribute_name = ['['+unicode(dic['AttributeName'])+'] varchar(50)' for dic in item['Config']]
	#             if item['Type'] == 'table':
	#                 cursor.execute("create table %s([FormId] varchar(50),%s,[ClientCreateTime] varchar(50))" % (item['DatabaseTableName'],','.join(attribute_name)))
	#             if item['Type'] == 'map':
	#                 cursor.execute("create table %s([FormId] varchar(50),%s)" % (item['DatabaseTableName'],','.join(attribute_name)))
	#     transaction.commit_unless_managed()
	#     return HttpResponse(request.body,content_type="application/json")
	else:
		return HttpResponseBadRequest()


# 对检验流程节点的增删查改
def process_node_type_operation(request, type_id, node_id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select * from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s' and Rev = %s" % (
			node_id, type_id, request.GET['Rev']))
		res = cursor.fetchone()
		if not len(res):
			return HttpResponseNotFound()
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type='application/json')
	elif request.method == 'POST':  # 增
		data = json.loads(request.body)
		cursor.execute("select * from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s' and Rev = %s" % (
			node_id, type_id, data['Rev']))
		res = cursor.fetchone()
		if len(res):
			return HttpResponseBadRequest()
		col_names = ','.join(['[' + unicode(key) + ']' for key in data.keys()])
		values = ','.join(["'" + unicode(value) + "'" for value in data.values()])
		cursor.execute("insert into RMI_PROCESS_NODE_TYPE (%s) values (%s)" % (col_names, values))
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(data, ensure_ascii=False), content_type="application/json")
	# elif request.method == 'PUT':#改
	#     data = json.loads(request.body)
	#     for key,value in data.iteritems():
	#         cursor.execute("update RMI_PROCESS_NODE_TYPE set %s = '%s' where Id = '%s' and ProcessTypeId = '%s'" % (key,value,node_id,type_id))
	#     transaction.commit_unless_managed()
	#     return HttpResponse(json.dumps(data,ensure_ascii=False),content_type="application/json")
	# elif request.method == 'DELETE':
	#     cursor.execute("select * from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s'" % (node_id,type_id))
	#     res = cursor.fetchone()
	#     if not len(res):
	#         return HttpResponseBadRequest()
	#     cursor.execute("delete from RMI_PROCESS_NODE_TYPE where Id = '%s' and ProcessTypeId = '%s'" % (node_id,type_id))
	#     transaction.commit_unless_managed()
	#     return HttpResponse(json.dumps(res,encoding='GB2312'),content_type="application/json")
	else:
		return HttpResponseBadRequest()


def sqlquery(request):
	if request.method == 'GET' and 'sql' in request.GET:
		cursor = connection.cursor()
		cursor.execute(request.GET['sql'])
		res = cursor.fetchall()
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


def forms_resources_all_options(request):
	if request.method == 'GET':
		cursor = connection.cursor()
		cursor.execute("SELECT * FROM RMI_FORM_RESOURCE_OPTION")
		res = cursor.fetchall()
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type="application/json")


def forms_resources_options(request, id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select * from RMI_FORM_RESOURCE_OPTION where Id = '%s'" % id)
		res = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		res = dict(zip(col_names, res))
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type="application/json")
	elif request.method == 'POST':
		data = json.loads(request.body)
		cursor.execute("select * from RMI_FORM_RESOURCE_OPTION where Id = '%s'" % id)
		res = cursor.fetchone()
		if len(res):
			return HttpResponseBadRequest()
		col_names = ','.join(['[' + unicode(key) + ']' for key in data.keys()])
		values = ','.join(["'" + unicode(value) + "'" for value in data.values()])
		cursor.execute("insert into RMI_FORM_RESOURCE_OPTION(Id,%s) values ('%s',%s)" % (col_names, id, values))
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(data, ensure_ascii=False), content_type="application/json")
	elif request.method == 'PUT':
		data = json.loads(request.body)
		for key, value in data.iteritems():
			cursor.execute("update RMI_FORM_RESOURCE_OPTION set %s = '%s' where Id = '%s'" % (key, value, id))
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(data, ensure_ascii=False), content_type="application/json")
	elif request.method == 'DELETE':
		cursor.execute("select * from RMI_FORM_RESOURCE_OPTION where Id = '%s'" % id)
		res = cursor.fetchone()
		if not len(res):
			return HttpResponseBadRequest()
		col_names = [desc[0] for desc in cursor.description]
		res = dict(zip(col_names, res))
		cursor.execute("delete from RMI_FORM_RESOURCE_OPTION where Id = '%s'" % id)
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type="application/json")
	else:
		return HttpResponseBadRequest()


def tags_operation(request, form_id):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select Tags from RMI_FORM where Id = '%s'" % form_id)
		res = cursor.fetchone()
		if len(res):
			res = res[0]
		return HttpResponse(res.decode('GB2312').encode('UTF-8'), content_type="application/json")

	elif request.method == 'PUT':
		cursor.execute("update RMI_FORM set Tags = '%s' where Id = '%s'" % (request.body, form_id))

		isComplete(form_id)
		transaction.commit_unless_managed()
		return HttpResponse(request.body, content_type="application/json")
	else:
		return HttpResponseBadRequest()


def feedback(request):
	cursor = connection.cursor()
	if request.method == 'POST':
		fb = json.loads(request.body)
		col_names = ','.join(['[' + unicode(key) + ']' for key in fb.keys()])
		values = ','.join(["'" + unicode(value) + "'" for value in fb.values()])
		cursor.execute("insert into RMI_FEEDBACK (%s) values(%s)" % (col_names, values))
		transaction.commit_unless_managed()
	return HttpResponse()


def reference(request, ASN):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select TypeId,Rev,Reference from RMI_PROCESS where ArrivalSerialNumber = '%s'" % ASN)
		raw = cursor.fetchone()
		reference_process = json.loads(raw[2], encoding='GB2312')
		cursor.execute("select Reference from RMI_PROCESS_TYPE where Id = '%s' and Rev = '%s'" % (raw[0], raw[1]))
		reference_type = json.loads(cursor.fetchone()[0], encoding='GB2312')

		for dic in reference_type:
			for ele in dic['Components']:
				if ele['DataRetrieveMode'] == 'dynamic':
					if ele['Id'] == 'Arrival':
						ele['Data'] = reference_process['Arrival']['Arrival']['Data']
					if ele['Id'] == 'GenerateCondition':
						ele['Data'] = reference_process['Arrival']['GenerateCondition']['Data']
		return HttpResponse(json.dumps(reference_type, encoding='GB2312'), content_type="application/json")


def users_operation(request, user):
	cursor = connection.cursor()
	if request.method == 'GET':
		cursor.execute("select top %s * from RMI_OPERATION_RECORDING where UserId = '%s' order by Time DESC" % (
			request.GET['top'], user))
		res = cursor.fetchall()
		col_names = [desc[0] for desc in cursor.description]
		res = [dict(zip(col_names, item)) for item in res]
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type='application/json')
	else:
		return HttpResponseBadRequest()


def subclasses(request):
	cursor = connection.cursor()
	if request.method == 'GET':
		# new
		cursor.execute(
				"SELECT RMI_PROCESS_TYPE_SUBCLASS.Id,RMI_PROCESS_TYPE_SUBCLASS.Subclass,RMI_PROCESS_TYPE_SUBCLASS.ProcessTypeId,RMI_PROCESS_TYPE.Class,RMI_PROCESS_TYPE.Name FROM RMI_PROCESS_TYPE_SUBCLASS INNER JOIN RMI_PROCESS_TYPE ON  RMI_PROCESS_TYPE_SUBCLASS.ProcessTypeId = RMI_PROCESS_TYPE.Id")
		# cursor.execute("select RMI_PROCESS_TYPE_SUBCLASS.Subclass,RMI_PROCESS_TYPE_SUBCLASS.ProcessTypeId,RMI_PROCESS_TYPE.Class,RMI_PROCESS_TYPE.Name from RMI_PROCESS_TYPE_SUBCLASS INNER JOIN RMI_PROCESS_TYPE ON  RMI_PROCESS_TYPE_SUBCLASS.ProcessTypeId = RMI_PROCESS_TYPE.Id")
		col_names = [desc[0] for desc in cursor.description]
		data = cursor.fetchall()
		data = [dict(zip(col_names, ele)) for ele in data]
		return HttpResponse(json.dumps(data, encoding='GB2312'), content_type='application/json')
	elif request.method == 'POST':
		data = json.loads(request.body)
		id = set_randhex('Id', 'RMI_PROCESS_TYPE_SUBCLASS')
		cursor.execute("insert into RMI_PROCESS_TYPE_SUBCLASS(Id,Subclass,ProcessTypeId) values('%s','%s','%s')" % (
			id, data['Subclass'], data['ProcessTypeId']))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()


def delete_subclass(request, Id):
	cursor = connection.cursor()
	if request.method == 'DELETE':
		cursor.execute("select * from RMI_PROCESS_TYPE_SUBCLASS where Id = '%s'" % Id)
		res = cursor.fetchone()
		col_names = [desc[0] for desc in cursor.description]
		res = dict(zip(col_names, res))
		cursor.execute("delete from RMI_PROCESS_TYPE_SUBCLASS where Id = '%s'" % Id)
		transaction.commit_unless_managed()
		return HttpResponse(json.dumps(res, encoding='GB2312'), content_type='application/json')
	else:
		return HttpResponseBadRequest()


def node_conclusion(request, ASN, NodeTypeId):
	cursor = connection.cursor()
	if request.method == 'PUT':
		conclusion = json.loads(request.body)
		cursor.execute(
				"update RMI_PROCESS_NODE set Conclusion = '%s' where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
					conclusion, ASN, NodeTypeId))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()


def node_availableflag(request, ASN, NodeTypeId):
	cursor = connection.cursor()
	if request.method == 'PUT':
		cursor.execute(
				"update RMI_PROCESS_NODE set AvailableFlag = '%s' where ArrivalSerialNumber = '%s' and ProcessNodeTypeId = '%s'" % (
					request.body, ASN, NodeTypeId))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()


def node_check_status(request, ASN, NodeTypeId):
	cursor = connection.cursor()
	if request.method == 'PUT':
		status = json.loads(request.body)
		cursor.execute(
				"update RMI_PROCESS_NODE set CheckStatus = '%s',CheckUserId = '%s',CheckTime = '%s' where ArrivalSerialNumber= '%s' and ProcessNodeTypeId = '%s'" % (
					status, request.session['UserId'], int(time.time()) * 1000, ASN, NodeTypeId))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()


def process_check_status(request, ASN):
	cursor = connection.cursor()
	if request.method == 'PUT':
		status = json.loads(request.body)
		cursor.execute("update RMI_PROCESS set CheckStatus = '%s' where ArrivalSerialNumber= '%s'" % (status, ASN))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()


def process_iscomplete(request, ASN):
	cursor = connection.cursor()
	if request.method == 'PUT':
		flag = json.loads(request.body)
		cursor.execute("update RMI_PROCESS set IsComplete = '%s' where ArrivalSerialNumber = '%s'" % (flag, ASN))
		if flag == 'true':
			cursor.execute("update RMI_PROCESS set CompleteTime = '%s' where ArrivalSerialNumber = '%s'" % (
				int(time.time() * 1000), ASN))
		transaction.commit_unless_managed()
		return HttpResponse(request.body)
	else:
		return HttpResponseBadRequest()

#==============================================================

def getTasks(request, UserID):
	"""
	映射到获取所有对应检验列表的链接
	:param request: 客户端请求
	:param UserID: 如果是ALL在，则返回所有的检验任务列表，否则返回对应UserID的检验任务列表
	:return:返回JSON打包之后的检验任务信息列表
	"""
	return HttpResponse(json.dumps(getTasksList(UserID), ensure_ascii=False, encoding='GB2312'))

def editTask(request):
	"""
	映射到编辑任务的用户列表
	:param request:客户端请求，其中包含需要修改的任务的serialNo和对应的信息
	:return:
	"""
	editTaskInfo(json.loads(request.body[5:], encoding='utf-8'), request.session['UserId'])
	return HttpResponse()

def getFlow(request):
	"""
	获取所有的工作流程列表
	:param request:客户端请求
	:return:返回所有键值对列表
	"""
	return HttpResponse(json.dumps(getFlowList(), encoding='GB2312'))

def getF01Data(request, serialNo, getMethod):
	"""
	根据流水号获取F01所有数据
	:param request: 客户端请求
	:param serialNo:任务流水号
	:param getMethod:Check：查看汇总，归并所有人的表格数据,dataEntry:WHERE出自己的数据
	:return: 返回相应JSON打包后的数据
	"""

	UserID = 'ALL' if getMethod == "Check" else request.session['UserId']
	return HttpResponse(json.dumps(getF01DataBySerialNoAndUserID(serialNo, 'F01', UserID), encoding='GB2312'))

def insertF01Data(request, serialNo):
	"""
	向F01表格插入数据
	:param request:客户端请求
	:param serialNo:任务流水号
	:return:
	"""
	UserID = request.session['UserId']
	insertF01DataBySerialNo(serialNo, json.loads(request.body[5:]), UserID)
	return HttpResponse()

def getTaskProcess(request, serialNo):
	"""
	根据任务流水号获取所有的表格的填写状态和相关信息
	:param request:客户端请求
	:param serialNo:任务流水号
	:return:与该任务对应的表单信息
	"""
	return HttpResponse(json.dumps(getAllProcessBySerialNo(serialNo), encoding='GB2312', cls=CommonUtilities.DecimalEncoder))



def test(request):
	raw = Raw_sql()
	for i in range(1,10):
		raw.sql = "INSERT INTO RMI_TASK WITH(ROWLOCK) (CreateTime, LastModifiedTime, ProductNo, ColorNo, ArriveTime, UserID, FlowID) "\
		          "VALUES( '2016-02-23 16:23:09.187',	'2016-02-23 16:23:09.187',	'234','234'	,'2016-02-06 00:00:00.000',	'1227401050','b6eb0acf-7c31-44f5-ae44-931ee2ff90a2' );"
		raw.update()
	return HttpResponse()
