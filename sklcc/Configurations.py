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
	def __init__(self, tableName, primaryKey, userID):
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
		self.__defaultUpdateString    = ", LastModifiedUser = '%s', LastModifiedTime = GETDATE()"%userID
		self.__defaultInsertColumns   = ", LastModifiedTime, LastModifiedUser"
		self.__defaultInsertValues    = ", '%s', GETDATE()"%userID
		self.dataSourceTable          = tableName
		self.primaryKey               = primaryKey
		self.userID                   = userID
		self.raw                      = rawSql.Raw_sql()
		self.MSDBBuiltInFunctionNames = ['GETDATE']

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

	def judgeWhetherFunctionOrObjects(self, value):
		"""
		判断某个待更新或插入的值是否是数据库函数或对象来确定是否需要加上''
		:param value:待更新或插入的值
		:return:如果是数据库内置函数或对象则返回True，否则返回False
		"""
		if '(' in value and ')' in value:
			if value[0:value.index('(')] in self.MSDBBuiltInFunctionNames:
				return True
		elif value.startswith('DBO.') or value.startswith('dbo.'):
			return True
		else:
			return False

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

	def __formatValuesString(self, valuesList=None):
		"""
		根据传入的插入值的列表生成用,分隔的SQL中的插入值字符串
		:param valuesList:插入值列表
		:return:返回生成的插入值字符串
		"""
		valuesString = ""
		for item in valuesList:
			if self.judgeWhetherFunctionOrObjects(item):
				valuesString += (unicode(item) + ',')
			else:
				valuesString += ("'" + unicode(item) + "'" + ',')
		return valuesString[:-1]

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

	@staticmethod
	def formatWhereString(whereColumns=None, whereValues=None):
		"""
		生成WHERE语句的字符串
		:param whereColumns:WHERE条件中的字段名列表
		:param whereValues:WHERE条件每个字段对应的值
		:return:返回生成的WHERE条件字符串
		"""
		if not whereColumns and not whereValues: #如果WHERE字段或者WHERE值为空，不生成WHERE字符串
			return ""
		WhereString = "WHERE "
		whereConditionRawList = zip(whereColumns, whereValues)
		whereConditionList    = list()
		for condition in whereConditionRawList:
			whereConditionList.append("=".join([condition[0], "'"+unicode(condition[1])+"'"]))
		WhereString +=  " AND ".join(whereConditionList)
		return WhereString

	@staticmethod
	def formatFuzzyWhereString(whereColumns=None, whereValues=None):
		"""
		生成Like条件的模糊查询WHERE语句的字符串
		:param whereColumns:WHERE条件中的字段名列表
		:param whereValues:WHERE条件每个字段对应的值
		:return:返回生成的WHERE条件字符串
		"""
		if not whereColumns and not whereValues: #如果WHERE字段或者WHERE值为空，不生成WHERE字符串
			return ""
		WhereString = "WHERE "
		whereConditionRawList = zip(whereColumns, whereValues)
		whereConditionList    = list()
		for condition in whereConditionRawList:
			whereConditionList.append(" LIKE ".join([condition[0], "'%%%%"+unicode(condition[1])+"%%%%'"]))
		WhereString +=  " AND ".join(whereConditionList)
		return WhereString

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

	def getInfoByID(self, ID, columns=None, columnsAlternativeNames=None):
		"""
		根据制定ID获取对应信息，如果ID为空则返回所有信息
		:param ID:指定ID
		:param columns:获取记录的字段序列
		:param columnsAlternativeNames:查询结果字段别名
		:return:调用smartReturn来返回数据集
		"""
		self.raw.sql = """SELECT %s FROM %s WITH(NOLOCK)"""%(
			self.formatColumnString(columns, columnsAlternativeNames), self.dataSourceTable)
		if ID:
			self.raw.sql += " WHERE %s = '%s'"%(self.primaryKey, ID)
		res, cols = self.raw.query_all(needColumnName=True)
		return self.smartReturn(res, cols)

	def getPagedInfo(self, pageNo, pageSize, columns, columnsAlternativeNames, whereColumns, whereValues, orderString):
		"""
		分页查询接口
		:param pageNo:页码
		:param pageSize:页面大小
		:param columns:字段
		:param columnsAlternativeNames:字段替代名
		:param whereColumns:where语句的字段列表
		:param whereValues:where语句的字段列表对应的值
		:param orderString:排序语句
		:return:{''}
		"""
		res, cols, count = self.raw.pagedQuery(pageNo, pageSize, self.dataSourceTable, self.primaryKey, self.formatColumnString(columns, columnsAlternativeNames),
		                    self.formatFuzzyWhereString(whereColumns, whereValues), orderString, needCounts=True, needColumnName=True )
		return {'listData':CommonUtilities.translateQueryResIntoDict(cols, res), 'count':count}

	def newInfo(self, columns=None, values=None):
		"""
		向对应数据源表插入数据
		:param columns: 字段名序列
		:param values: 字段名对应的插入值的序列
		"""
		self.raw.sql = """INSERT INTO %s WITH(ROWLOCK)
						 ( %s )
					     VALUES ( %s )"""%(
				self.dataSourceTable, ",".join(columns), self.__formatValuesString(values))
		self.raw.update()

	def updateInfo(self, updateInfoWhereValues, updateInfoWhereColumns, updateColumns=None, updateValues=None):
		"""
		在数据源表中更新指定ID的相关值
		:param updateInfoWhereValues: 更新的WHERE条件的值列表
		:param updateInfoWhereColumns: 更新的WHERE条件字段的名称列表
		:param updateColumns: 欲更新的字段的序列
		:param updateValues: 与欲更新字段序列顺序对应的更新值
		:return:
		"""
		self.raw.sql = """UPDATE %s SET %s%s
 	    			%s"""%(
			self.dataSourceTable, self.formatUpdateString(updateColumns, updateValues),
			self.__defaultUpdateString, self.formatWhereString(updateInfoWhereColumns, updateInfoWhereValues))
		self.raw.update()

	def deleteInfo(self, deleteInfoID):
		"""
		在数据源列表中删除制定ID的数据
		:param deleteInfoID:指定的ID
		"""
		self.raw.sql = "DELETE FROM %s WITH(ROWLOCK) WHERE %s = '%s'"%(self.dataSourceTable, self.primaryKey, deleteInfoID)
		self.raw.update()
