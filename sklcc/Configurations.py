# -*- coding: utf-8 -*-
"""
所有系统配置相关功能函数
"""
__author__ = "XuWeitao"
import CommonUtilities
import rawSql

class RestfulInfoAPI(object):
	"""
	Restful增删查改的API类
	"""
	def __init__(self, tableName, userID):
		self.__defaultUpdateString  = ", LastModifiedUser = '%s', LastModifiedTime = GETDATE()"%userID
		self.__defaultInsertColumns = ", LastModifiedTime, LastModifiedUser"
		self.__defaultInsertValues  = ", '%s', GETDATE()"%userID
		self.dataSourceTable        = tableName
		self.userID                 = userID
		return

	def setDefaultUpdateString(self, alternativeStrings):
		self.__defaultUpdateString = alternativeStrings

	def setDefaultInsertColumnsAndValues(self, alternativeColumns, alternativeValues):
		self.__defaultInsertColumns = alternativeColumns
		self.__defaultInsertValues  = alternativeValues

	@staticmethod
	def formatColumnString(columns=None, columnsAlternativeNames=None):
		"""

		:param columns:
		:param columnsAlternativeNames:
		:return:
		"""
		if columns is not None:
			if columnsAlternativeNames is not None:
				columnString = ",".join([field + ' AS ' + columnsAlternativeNames[i] for i, field in enumerate(columns)])
			else:
				columnString = ",".join(columns)
		else:
			columnString = "*"

		return columnString

	@staticmethod
	def smartReturn(res, cols):
		"""

		:param res:
		:param cols:
		:return:
		"""
		if len(cols) == 1:
			return 	[ row[0] for row in res ]
		else:
			return CommonUtilities.translateQueryResIntoDict(cols, res)

	@staticmethod
	def formatUpdateString(updateColumns=None, updateValues=None):
		return ",".join([updateCol + '=' + "'%s'"%updateValues[i] for i, updateCol in enumerate(updateColumns)])

	def getInfoByName(self, fuzzyInput, fuzzyFieldName, columns=None, columnsAlternativeNames=None):
		"""
		模糊查询获取匹配到的数据
		:param fuzzyInput: 模糊查询的输入
		:param fuzzyFieldName:
		:param columns:
		:param columnsAlternativeNames:
		:return:
		"""
		raw = rawSql.Raw_sql()

		raw.sql = """SELECT %s FROM %s WITH(NOLOCK) WHERE %s LIKE '%%%%%s%%%%'"""%(
			self.formatColumnString(columns, columnsAlternativeNames), self.dataSourceTable, fuzzyFieldName, fuzzyInput)

		res, cols = raw.query_all(needColumnName=True)
		return self.smartReturn(res, cols)

	def getInfoByID(self, ID, queryFieldName, columns=None, columnsAlternativeNames=None):
		"""

		:param ID:
		:param queryFieldName:
		:param columns:
		:param columnsAlternativeNames:
		:return:
		"""
		raw = rawSql.Raw_sql()
		raw.sql = """SELECT %s FROM %s WITH(NOLOCK)"""%(
			self.formatColumnString(columns, columnsAlternativeNames), self.dataSourceTable)
		if ID:
			raw.sql += " WHERE %s = '%s'"%(queryFieldName, ID)
		res, cols = raw.query_all(needColumnName=True)
		return self.smartReturn(res, cols)

	def newInfo(self, columns=None, values=None):
		raw = rawSql.Raw_sql()
		raw.sql = """INSERT INTO %s WITH(ROWLOCK)
 					( %s )
 	    			VALUES ( %s )"""%(
			self.dataSourceTable, ",".join(columns), ",".join(['%s'%item for item in values]))
		raw.update()
		return

	def updateInfo(self, updateInfoID, updateIDFieldName, updateColumns=None, updateValues=None):
		raw = rawSql.Raw_sql()
		raw.sql = """UPDATE %s SET %s%s
 	    			WHERE %s = '%s'"""%(
			self.dataSourceTable, self.formatUpdateString(updateColumns, updateValues), self.__defaultUpdateString, updateIDFieldName, updateInfoID)
		raw.update()
		return

	def deleteInfo(self, deleteInfoID, deleteIDFieldName):
		raw = rawSql.Raw_sql()
		raw.sql = "DELETE FROM %s WITH(ROWLOCK) WHERE %s = '%s'"%(self.dataSourceTable, deleteIDFieldName, deleteInfoID)
		raw.update()
		return



def getSuppliersByName(supplierName):
	"""
	根据供应商模糊名查询获取供应商列表
	:param supplierName: 供应商的模糊名
	:return: 返回[供应商名称]
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT SupplierName FROM RMI_SUPPLIER WHERE SupplierName LIKE '%%%%%s%%%%'"""%supplierName
	return 	[ row[0] for row in raw.query_all() ]

def getSupplierByCode(supplierCode):
	"""
	获取所有供应商信息
	:param supplierCode:供应商代码，为空则返回所有供应商
	:return:[{"id":供应商代码，"name":供应商名称}]
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT SupplierCode AS id, SupplierName AS name FROM RMI_SUPPLIER WITH(NOLOCK)"""
	if supplierCode:
		raw.sql += " WHERE SupplierCode = '%s'"%supplierCode
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(cols, res)

def newSupplier(userID, supplierInfo):
	"""
	创建新的供应商
	:param userID:最近一次修改用户的ID
	:param supplierInfo:供应商相关信息
	:return:
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """INSERT INTO RMI_SUPPLIER WITH(ROWLOCK) (SupplierCode, SupplierName, LastModifiedTime, LastModifiedUser )
 				VALUES('%s', '%s', '%s', GETDATE())"""%(supplierInfo['id'], supplierInfo['name'], userID)
	raw.update()
	return


def updateSupplier(userID, supplierCode, supplierInfo):
	"""
	更新供应商相关信息
	:param userID:最近一次修改人ID
	:param supplierCode:指定的供应商代码
	:param supplierInfo:供应商信息
	:return:
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """UPDATE RMI_SUPPLIER SET supplierName = '%s', LastModifiedUser = '%s',
				LastModifiedTime = GETDATE()
 				WHERE SupplierCode = '%s'"""%(supplierInfo['name'], supplierCode, userID)
	raw.update()
	return

def deleteSupplier(supplierCode):
	"""
	删除对应代码的供应商信息
	:param supplierCode:供应商代码
	:return:
	"""
	raw = rawSql.Raw_sql()
	raw.sql = "DELETE FROM RMI_SUPPLIER WHERE SupplierCode = '%s'"%supplierCode
	raw.update()
	return

def getAllUnits():
	"""
	获取所有的计量单位列表
	:return: 返回[{"id":"","name":""}]
	"""
	raw       = rawSql.Raw_sql()
	raw.sql   = """SELECT UnitID AS id, UnitName AS name  FROM RMI_UNIT"""
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(columns=cols, res=res)
