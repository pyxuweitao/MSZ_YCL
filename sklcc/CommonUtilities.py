# -*- coding: utf-8 -*-
"""
所有通用的功能函数
"""
__author__ = 'XuWeitao'

def translateQueryResIntoJSON(columns, res):
	"""
	将数据库中检索到的数据按照字段名和记录构成字典列表
	:param columns: 字段名列表
	:param res: 检索结果元组
	:return:返回字典形式的结果列表，即[{"column":rowValue}]
	"""
	return [ dict(zip(columns, row)) for row in res ]