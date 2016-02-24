# -*- coding: utf-8 -*-
"""
所有权限和用户管理相关业务逻辑函数
"""
__author__ = 'XuWeitao'
from rawSql import Raw_sql
import json


def whetherAlreadyRegistered(Id):
	"""
	判断该ID是否在数据库中已经存在
	:param Id: 管理员提交的ID号
	:return: 是否数据库中已经存在的布尔值
	"""
	raw = Raw_sql()
	raw.sql = "SELECT * FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE Id = '%s'" % Id
	return True if len(raw.query_all()) != 0 else False


def authentication(Id, password):
	"""
	验证用户登录
	:param Id:用户ID
	:param password:用户密码
	:return: 返回是否验证通过的布尔值
	"""
	pass


def getEmployeeCreateTime(Id):
	"""
	获取数据库数据表RMI_ACCOUNT_USER中对应id的Createtime字段的值
	:param Id: 员工ID
	:return: 返回对应创建时间的字段的值
	"""
	raw = Raw_sql()
	raw.sql = "SELECT CONVERT(varchar(25), CreateTime, 20) CreateTime FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE Id = '%s'" % Id
	result = raw.query_one()
	if not result:
		return None
	else:
		return result[0]


def editEmployeeInfo(employeeInfo):
	"""
	根据isNew字段以及传入的信息来新插入或更新一个员工数据。
	:param employeeInfo: 员工信息字典
	:return:返回编辑成功与否的布尔标志
	"""
	permission   = 'default' if 'Permission' not in employeeInfo else json.dumps(employeeInfo['Permission'],
	                                                                           encoding='GB2312')
	permission   = permission.replace("'", '"')
	isNew        = True if employeeInfo['isNew'] == "True" else False
	raw          = Raw_sql()
	if isNew:
		raw.sql = "INSERT INTO RMI_ACCOUNT_USER WITH(ROWLOCK) (id, Password, DepartmentID, JobID, Permission, CreateTime, LastModifiedTime, Name)"\
		          " VALUES ('%s','%s','%s','%s','%s', GETDATE(), GETDATE(), '%s');" % (
			          employeeInfo['ID'], employeeInfo['Password'], employeeInfo['DepartmentID'], employeeInfo['JobID'], permission, employeeInfo['Name'])
	else:
		raw.sql  = "UPDATE RMI_ACCOUNT_USER WITH(ROWLOCK) SET Password = '%s', DepartmentID = '%s', " \
		           "JobID = '%s', Permission = '%s', LastModifiedTime = getdate(), Name = '%s' WHERE ID = '%s'"%(
			        employeeInfo['Password'], employeeInfo['DepartmentID'], employeeInfo['JobID'],
			        permission, employeeInfo['Name'], employeeInfo['ID'])
	return raw.update()


def getAllDepartmentsInfo():
	"""
	获取所有组别的信息，包括ID,部门名称和类别
	:return:返回{departmentid,department,classification}组成的字典列表
	"""
	raw = Raw_sql()
	raw.sql = "SELECT DepartmentID, Department, Classification FROM RMI_DEPARTMENT WITH(NOLOCK)"
	res = raw.query_all()
	return [ {"value":row[0], "name":row[1], "group":row[2]} for row in res ]

def getAllJobsInfo():
	"""
	获取所有职位的信息，包括ID,职位和类别
	:return:返回{jobid,job,classification}组成的字典列表
	"""
	raw = Raw_sql()
	raw.sql = "SELECT JobID, Job, Classification FROM RMI_JOB WITH(NOLOCK)"
	res = raw.query_all()
	return [ {"value":row[0], "name":row[1], "group":row[2]} for row in res ]

def getUserInfo(ID='ALL'):
	"""
	获取RMI_ACCOUNT_USER表用户所有的信息,如果指定ID，则返回对应员工的数据
	:param ID:'ALL'表示所有的员工数据，否则获取对应ID的数据
	:return:返回与数据库字段和记录一一对应的若干字典组成的列表
	"""
	raw = Raw_sql()
	raw.sql = "SELECT ID, Name, Password, DepartmentID, JobID, Permission," \
	          " CONVERT(varchar(16), CreateTime, 20) CreateTime," \
	          " CONVERT(varchar(16), LastModifiedTime, 20) LastModifiedTime FROM RMI_ACCOUNT_USER WITH(NOLOCK)"
	if ID != 'ALL':
		raw.sql += " WHERE ID = '%s'"%ID
	res, columns = raw.query_all(needColumnName=True)
	return [ dict(zip(columns, row)) for row in res ]

def deleteUserInfo(ID='ALL'):
	"""
	删除RMI_ACCOUNT_USER表用户所有的信息,如果指定ID，则删除对应员工的数据
	:param ID:'ALL'表示删除所有的员工数据，否则删除对应ID的数据
	:return:
	"""
	raw = Raw_sql()
	raw.sql = "DELETE FROM RMI_ACCOUNT_USER WITH(ROWLOCK)"
	if ID != 'ALL':
		raw.sql += " WHERE ID = '%s'"%ID
	raw.update()
