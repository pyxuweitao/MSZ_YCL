# -*- coding: utf-8 -*-
__author__ = 'XuWeitao'

from django.db.transaction import connections
from django.db import transaction
from tempfile import TemporaryFile

class Raw_sql(object):
	"""
	创建Django与数据库的短连接，通过给sql传递原始sql语句,query_one来返回单条记录，query_all返回所有查询结果的记录
	如果查询不到返回False，若对数据库执行删除，插入或者更新操作，需要在传入SQL之后，调用update函数
	每个方法都可以指定一个参数owner，这个参数对应于settings.py中数据库配置名，如owner='default'，则将SQL执行于default数据库
	"""
	def __init__(self):
		self.sql = ""

	def query_one(self, owner='default', needColumnName=False):
		"""
		查询返回单条记录
		:param owner:对应settings中的数据库key，默认为default
		:param needColumnName: 是否需要返回字段名列表以方便快速生成字段和结果对应的字典列表
		:return: 如果不需要字段名，就返回结果元组，如果需要则返回字段列表和结果元组（res）
		"""
		try:
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			target = cursor.fetchone()
			# target -> list
			if not needColumnName:
				if len(target) == 0:
					return ()
				else:
					return target
			else:
				if len(target) == 0:
					return (), [desc[0] for desc in cursor.description]
				else:
					return target, [desc[0] for desc in cursor.description]
		except Exception,e:
			print e
			print self.sql

	def query_all(self, owner='default', needColumnName=False):
		"""
		查询返回多条记录
		:param owner:对应settings中的数据库key，默认为default
		:param needColumnName: 是否需要返回字段名列表以方便快速生成字段和查询结果对应的字典列表
		:return: 如果不需要字段名，就返回结果元组，如果需要则返回字段列表和结果元组((res)(res))
		"""
		try:
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			target_list = cursor.fetchall()
			if not needColumnName:
				if len(target_list) == 0:
					return ()
				else:
					return target_list
			else:
				if len(target_list) == 0:
					return (), [desc[0] for desc in cursor.description]
				else:
					return target_list, [desc[0] for desc in cursor.description]
		except Exception,e:
			print e
			print self.sql

	def update(self, owner='default'):
		"""
		将定义的DML SQL提交，出现异常时rollback
		:param owner:对应settings中的数据库key，默认为default
		:return:提交成功返回True，提交失败返回False
		"""
		try:
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			transaction.commit_unless_managed(owner)
		except Exception, e:
			print e
			print self.sql
			transaction.rollback(owner)
			return False
		else:
			return True

	def pagedQuery(self, pageNo, pageSize, tableName, primaryKeyField, fieldString, whereString, orderString, needCounts=False, needColumnName=False, owner='default'):
		"""
		一个分页查询的接口实现
		:param pageNo:当前页码
		:param pageSize:页面大小
		:param tableName:表名
		:param primaryKeyField:主键字段名
		:param fieldString:查询字段列表
		:param whereString:where语句
		:param orderString:order by 语句
		:param needColumnName:是否需要返回字段名称列表
		:param needCounts:是否需要返回查询结果总条数（不分页）
		:param owner:对应settings中的数据库key，默认为default
		:return:返回对应设置的分页结果
		"""
		try:
			newOrderString1 = orderString.upper().replace('DESC', '').replace('ASC', 'DESC')
			newOrderString2 = orderString.upper().replace('ASC', '')
			self.sql = """SELECT %s FROM %s t1
						  WHERE %s IN (
						  	SELECT TOP %d %s FROM (
						  	  SELECT TOP %d %s FROM %s %s ORDER BY %s
						  	) t2 ORDER BY %s
						  ) ORDER BY %s"""%(
				fieldString, tableName, primaryKeyField, pageSize, primaryKeyField,
				pageSize * pageNo, primaryKeyField, tableName, whereString,
				newOrderString2, newOrderString1, newOrderString2)
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			target_list = cursor.fetchall()
			if not needCounts:
				if needColumnName:
					if len(target_list) == 0:
						return (), [desc[0] for desc in cursor.description]
					else:
						return target_list, [desc[0] for desc in cursor.description]
				else:
					if len(target_list) == 0:
						return ()
					else:
						return target_list
			else:
				self.sql  = "SELECT COUNT(*) FROM %s %s"%( tableName, whereString )
				count = self.query_one()[0]
				if needColumnName:
					if len(target_list) == 0:
						return (), [desc[0] for desc in cursor.description], count
					else:
						return target_list, [desc[0] for desc in cursor.description], count
				else:
					if len(target_list) == 0:
						return (), count
					else:
						return target_list, count
		except Exception,e:
			print e
			print self.sql

	def bulk_insert(self, rawData, owner='default'):
		"""
		暂不使用
		:param owner:对应settings中的数据库key，默认为default
		:param rawData:原始数据列表，每个元素是一行数据库记录
		:return:提交成功返回True，提交失败返回False
		"""
		try:
			tempf  = TemporaryFile(mode='w+t')
			for row in rawData:
				tempf.writelines([unicode(item)+' ' for item in row])

			tempf.seek(0)
			tempf.close()
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			transaction.commit_unless_managed(owner)
		except Exception, e:
			print e
			transaction.rollback(owner)
			return False
		else:
			return True


