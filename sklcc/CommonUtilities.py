# -*- coding: utf-8 -*-
"""
所有通用的功能函数
"""
__author__ = 'XuWeitao'

import json
import decimal

def translateQueryResIntoDict(columns, res):
	"""
	将数据库中检索到的数据按照字段名和记录构成字典列表
	:param columns: 字段名列表
	:param res: 检索结果元组
	:return:返回字典形式的结果列表，即[{"column":rowValue}]
	"""
	if not res:
		return [dict(zip(columns, [None for i in range(0, len(columns))]))]
	return [dict(zip(columns, row)) for row in res]


class DecimalEncoder(json.JSONEncoder):
	"""
	自定义decimalJSONencoder类来使decimal可以序列化
	"""
	def default(self, o):
		if isinstance(o, decimal.Decimal):
			return float(o) * 100 #去掉百分号的结果
		return json.JSONEncoder.default(self, o)

def JSONToCreateTable(JSON):
	"""
	根据所有的表格插入时发来的JSON生成创建数据表的SQL
	:param JSON:表格插入发来的JSON
	:return:创建表格生成的SQL
	"""
	rawDict = json.loads(JSON)
	SQL = "CREATE TABLE("
	for k, v in rawDict.items():
		temp = "%s varchar(50),\n"%k if not isinstance(v, bool) else "%s bit,\n"%k
		SQL += temp
	SQL += """Id uniqueidentifier default newid() primary key,
			  SerialNo uniqueidentifier,
			  InspectorNo varchar(50)"""
	SQL += ")"
	return SQL

if __name__=="__main__":
	print JSONToCreateTable("""{
  "TongHao": "1234",
  "BiaoZhiShu": "1234",
  "ShiCeShu": "2134",
  "BiaoZhi": "Shi",
  "WaiBaoZhuang": "Shi",
  "ZaZhi": "Wu",
  "YanSe": "YiChang",
  "YiWei": "You",
  "JieGuo": "OK",
  "DaoHuoShuLiang": "1243",
  "JianYanShuLiang": "请让我",
  "GongHuoShang": "2134",
  "SongHuoDanHao": "1234",
  "BeiZhu": "2134",
  "PanDing": "HeGe"
}
""")

