# -*- coding: utf-8 -*-
"""
所有通用的功能函数
"""
__author__ = 'XuWeitao'

import json
import decimal
import rawSql

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

def MSZDBSyncToLocal():
	raw = rawSql.Raw_sql()
	raw.sql = "SELECT * FROM RMI_TASK"
	return

if __name__=="__main__":
	print JSONToCreateTable("""
  {
  "CaiLiaoChengFen": "1234",
  "JuanHao": "1234",
  "GangHao": "1234",
  "PingPai": "2134",
  "KuanHao": "1234",
  "YongTu": "QiTa",
  "YongTuBeiZhu": "1234",
  "TiaoJianShangMoWenDu": "1234",
  "TiaoJianXiaMoWenDu": "1234",
  "TiaoJianShiJian": "1234",
  "TiaoJianShenDu": "3124",
  "SongJianRen": "2134",
  "SongJianRenRiQi": "1324",
  "MoYaTiaoJianBeiZhu": "1324",
  "ShiYongMuJu": "3412",
  "ZhuLiao": "3124",
  "CanShuShangMoWenDu": "134",
  "CanShuXiaMoWenDu": "1234",
  "CanShuShiJian": "1234",
  "CanShuShenDu": "1241233",
  "GongYiYuan": "2134",
  "GongYiYuanRiQi": "2314",
  "MoYaCanShuBeiZhu": "1234231",
  "TieHeJiaoShui": "43214",
  "TieHeWenDu": "231432",
  "TieHeSuDu": "11234",
  "TieHeYaLi": "1234",
  "TieHeQiTa": "1234",
  "JiShuCanShuShangMoWenDu": "1234",
  "JiShuCanShuXiaMoWenDu": "1234",
  "JiShuCanShuShiJian": "1234",
  "JiShuCanShuShenDu": "1234",
  "JiShuCanShuBeiZhu": "1234",
  "WenTiDian": "1234",
  "ShiYangRen": "1234",
  "ShiYangRenRiQi": "1234",
  "ShiYaHouQueRen": "1234",
  "ShiYaHouQueRenRiQi": "1234",
  "GongYiQueRen": "1234",
  "GongYiQueRenRiQi": "1234",
  "CaiGouBuMenQueRen": "1234",
  "CaiGouBuMenQueRenRiQi": "1234",
  "CaiGouBuMenShenHe": "1234",
  "CaiGouBuMenShenHeRiQi": "1234"
}
""")

