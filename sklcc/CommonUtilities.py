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
	rawDict = json.loads(JSON)
	SQL = "CREATE TABLE("
	for k, v in rawDict.items():
		temp = "%s varchar(50),\n"%k if not isinstance(v, bool) else "%s bit,\n"%k
		SQL += temp

	SQL += ")"
	return SQL

if __name__=="__main__":
	print JSONToCreateTable("""{
  "QiZhouQiMao1": "215",
  "QiZhouQiMao2": "2134",
  "QiZhouQiMao3": "2314",
  "QiZhouQiMao4": "2143",
  "TuoJiaoQiPao1": "123",
  "TuoJiaoQiPao2": "2135",
  "TuoJiaoQiPao3": "23",
  "TuoJiaoQiPao4": "2134",
  "BaoKou1": "1234",
  "BaoKou2": "345",
  "BaoKou3": "234",
  "BaoKou4": "1234",
  "ShenQingBuMen": "1234",
  "MoBeiBeiXing": "234",
  "MoYaTiaoJianWenDu": "1234213",
  "MoYaTiaoJianShiJian": "4231423",
  "ShenQingRiQi": "2016-03-07T16:00:00.000Z",
  "YanSe": "234",
  "ShuLiang": "2134",
  "TieHeTiaoJianWenDu": "3",
  "TieHeTiaoJianShiJian": "1234",
  "ShuiWen": "LenShui",
  "ZhuanSu": "600",
  "HongGan": "BiaoZhun",
  "XiDiCiShu": "5",
  "XiDiJi": "Jia",
  "QiTaYaoQiu": "2134",
  "hasQiZhouQiMao": true,
  "hasBaoKou": true,
  "hasTuoJiaoQiPao": true
}
""")
