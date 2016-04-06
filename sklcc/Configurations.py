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
		"""
		__defaultUpdateString  :数据库更新语句默认的插入项，添加到更新语句对应位置中
		__defaultInsertColumns :数据库插入语句默认的插入项，添加到插入语句对应位置中
		__defaultInsertValues  :数据库插入语句默认插入项的值
		dataSourceTable        :该实例对应的数据表
		userID                 :修改该实例对应数据表的用户ID
		raw                    :数据库连接对象
		:param tableName: 初始化数据表名称
		:param userID: 用户ID
		"""
		self.__defaultUpdateString  = ", LastModifiedUser = '%s', LastModifiedTime = GETDATE()"%userID
		self.__defaultInsertColumns = ", LastModifiedTime, LastModifiedUser"
		self.__defaultInsertValues  = ", '%s', GETDATE()"%userID
		self.dataSourceTable        = tableName
		self.userID                 = userID
		self.raw                    = rawSql.Raw_sql()

	def setDefaultUpdateString(self, alternativeStrings):
		"""
		修改数据库默认更新项语句
		:param alternativeStrings:欲替换的数据库默认更新项语句
		"""
		self.__defaultUpdateString = alternativeStrings

	def setDefaultInsertColumnsAndValues(self, alternativeColumns, alternativeValues):
		"""
		修改数据库默认插入项语句
		:param alternativeColumns: 欲替换的数据库默认插入项语句
		:param alternativeValues: 欲替换的数据库默认插入项语句
		"""
		self.__defaultInsertColumns = alternativeColumns
		self.__defaultInsertValues  = alternativeValues

	@staticmethod
	def formatColumnString(columns=None, columnsAlternativeNames=None):
		"""
		根据传入的字段名列表和字段别名列表，用AS连接，生成SELECT时的字段名字符串
		:param columns:字段原名列表
		:param columnsAlternativeNames:字段别名列表
		:return:返回生成的字段名字符串
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
		根据查询的字段数，如果只有一个字段，直接将结果存入一个列表中返回，否则返回一个键值对组成的列表
		:param res:查询结果序列
		:param cols:查询字段序列
		:return:
		"""
		if len(cols) == 1:
			return 	[ row[0] for row in res ]
		else:
			return CommonUtilities.translateQueryResIntoDict(cols, res)

	@staticmethod
	def formatUpdateString(updateColumns=None, updateValues=None):
		"""
		根据更新字段序列和更新值序列生成update语句的值SET语句字符串
		:param updateColumns: 更新字段序列
		:param updateValues: 更新字段对应值序列
		:return: 返回生成的UPDATE的SET部分字符串
		"""
		return ",".join([updateCol + '=' + "'%s'"%updateValues[i] for i, updateCol in enumerate(updateColumns)])

	def getInfoByFuzzyInput(self, fuzzyInput, fuzzyFieldName, columns=None, columnsAlternativeNames=None):
		"""
		模糊查询获取匹配到的数据，传入的字段原名和字段别名序列顺序必须保持一致
		:param fuzzyInput: 模糊查询的输入
		:param fuzzyFieldName:模糊字段名称
		:param columns:字段原名序列
		:param columnsAlternativeNames:字段别名序列
		:return:调用smartReturn来返回数据集
		"""
		self.raw.sql = """SELECT %s FROM %s WITH(NOLOCK)"""%(self.formatColumnString(columns, columnsAlternativeNames), self.dataSourceTable)
		if fuzzyInput:
			self.raw.sql += """ WHERE %s LIKE '%%%%%s%%%%'"""%(fuzzyFieldName, fuzzyInput)
		res, cols = self.raw.query_all(needColumnName=True)
		return self.smartReturn(res, cols)

	def getInfoByID(self, ID, queryFieldName, columns=None, columnsAlternativeNames=None):
		"""
		根据制定ID获取对应信息，如果ID为空则返回所有信息
		:param ID:指定ID
		:param queryFieldName:指定的ID的字段名
		:param columns:获取记录的字段序列
		:param columnsAlternativeNames:查询结果字段别名
		:return:调用smartReturn来返回数据集
		"""
		self.raw.sql = """SELECT %s FROM %s WITH(NOLOCK)"""%(
			self.formatColumnString(columns, columnsAlternativeNames), self.dataSourceTable)
		if ID:
			self.raw.sql += " WHERE %s = '%s'"%(queryFieldName, ID)
		res, cols = self.raw.query_all(needColumnName=True)
		return self.smartReturn(res, cols)

	def newInfo(self, columns=None, values=None):
		"""
		向对应数据源表插入数据
		:param columns: 字段名序列
		:param values: 字段名对应的插入值的序列
		"""
		self.raw.sql = """INSERT INTO %s WITH(ROWLOCK)
 					( %s )
 	    			VALUES ( %s )"""%(
			self.dataSourceTable, ",".join(columns), ",".join(['%s'%item for item in values]))
		self.raw.update()

	def updateInfo(self, updateInfoID, updateIDFieldName, updateColumns=None, updateValues=None):
		"""
		在数据源表中更新指定ID的相关值
		:param updateInfoID: 制定更新记录的ID
		:param updateIDFieldName: 更新记录ID所在的字段的名称
		:param updateColumns: 欲更新的字段的序列
		:param updateValues: 与欲更新字段序列顺序对应的更新值
		:return:
		"""
		self.raw.sql = """UPDATE %s SET %s%s
 	    			WHERE %s = '%s'"""%(
			self.dataSourceTable, self.formatUpdateString(updateColumns, updateValues), self.__defaultUpdateString, updateIDFieldName, updateInfoID)
		self.raw.update()

	def deleteInfo(self, deleteInfoID, deleteIDFieldName):
		"""
		在数据源列表中删除制定ID的数据
		:param deleteInfoID:指定的ID
		:param deleteIDFieldName:指定的ID所对应的字段名称
		"""
		self.raw.sql = "DELETE FROM %s WITH(ROWLOCK) WHERE %s = '%s'"%(self.dataSourceTable, deleteIDFieldName, deleteInfoID)
		self.raw.update()
