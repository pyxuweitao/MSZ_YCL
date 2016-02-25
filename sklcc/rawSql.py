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

	def query_all(self, owner='default', needColumnName=False):
		"""
		查询返回多条记录
		:param owner:对应settings中的数据库key，默认为default
		:param needColumnName: 是否需要返回字段名列表以方便快速生成字段和查询结果对应的字典列表
		:return: 如果不需要字段名，就返回结果元组，如果需要则返回字段列表和结果元组((res)(res))
		"""
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

	def update(self, owner='default'):
		"""
		将定义的DMLSQL提交，出现异常时rollback
		:param owner:对应settings中的数据库key，默认为default
		:return:提交成功返回True，提交失败返回False
		"""
		try:
			cursor = connections[owner].cursor()
			cursor.execute(self.sql)
			transaction.commit_unless_managed(owner)
		except Exception, e:
			transaction.rollback(owner)
			return False
		else:
			return True

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
			transaction.rollback(owner)
			return False
		else:
			return True

	def callproc(self, procname, parameter, owner='default'):
		"""
		暂不使用
		:param procname:
		:param parameter:
		:param owner:
		:return:
		"""
		try:
			cursor = connections[owner].cursor()
			res = cursor.callproc(procname, parameter)
			return res
		except Exception, e:
			return e
