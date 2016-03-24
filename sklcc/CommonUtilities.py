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
  "CiDian": [
    {
      "mistake": {
        "id": "1",
        "label": "疵点1"
      },
      "count": "8",
      "score": 0
    },
    {
      "mistake": {
        "id": "2",
        "label": "疵点2"
      },
      "count": "11",
      "score": 0
    },
    {
      "mistake": {
        "id": "4",
        "label": "疵点4"
      },
      "count": "8",
      "score": 0
    },
    {
      "mistake": {
        "id": "5",
        "label": "疵点5"
      },
      "count": "7",
      "score": 0
    }
  ],
  "JuanHao": "1243",
  "GangHao": "2134",
  "ShuLiangPiBiao1": 2134,
  "ShuLiangShiCe1": 2134,
  "ShuLiangPiBiao2": "2314",
  "ShuLiangShiCe2": "2134",
  "JianYanShu": 2134,
  "DengJiPanDing": "A",
  "BeiZhu": "2314",
  "ShouRouHuiSuoLv": "3223",
  "ZiRanHuiSuoLv": "2134",
  "KuanDuOrGuiGeBiaoZhunZhi": "1234",
  "KuanDuOrGuiGeBiaoZhunPianCha": "2341",
  "KuanDuOrGuiGeShiCe1": "1234",
  "KuanDuOrGuiGeShiCe2": "2134",
  "KuanDuOrGuiGeShiCe3": "1243",
  "DuiChenXingOrWanQuDuBiaoZhunZhi": "1234",
  "DuiChenXingOrWanQuDuBiaoZhunPianCha": "1234",
  "DuiChenXingOrWanQuDuShiCe": 23341,
  "KeZhongBiaoZhunZhi": "2134",
  "KeZhongBiaoZhunPianCha": "2134",
  "KeZhongShiCe": 1234,
  "KaiDuBiaoZhunZhi": "142",
  "KaiDuBiaoZhunPianCha": "1234",
  "KaiDuShiCe": "2134",
  "HouDuBiaoZhunZhi": "412",
  "HouDuBiaoZhunPianCha": "4123",
  "HouDuShiCe": 434242,
  "HuaXingBiaoZhunZhi": "1",
  "HuaXingBiaoZhunPianCha": "34132",
  "ShuiXi": "HeGe",
  "HuaXingShiCe": 432,
  "XiangMuFlag": {
    "hasCiDian": true,
    "hasKuanDuOrGuiGe": true,
    "hasDuiChenXingOrWanQuDu": true,
    "hasKeZhong": true,
    "hasKaiDu": true,
    "hasHouDu": true,
    "hasHuaXingXunHuan": true,
    "hasShuiXi": true
  },
  "ShuLiang": {
    "MiIsChecked": true
  },
  "LeiBie": "B",
  "CaiLiaoMingCheng": "2134",
  "DaoLiaoZongShu": 2341,
  "ChanPinZhongLei": "肩带",
  "GongYingShang": "2134",
  "hasBiaoZhunSeKa": true,
  "BiaoZhunSeKa": "234",
  "CaiLiaoFengYang": "124",
  "hasCaiLiaoFengYang": true,
  "QiWeiBeiZhu": "1234",
  "QiWei": "BuZhengChang",
  "AnLunShiYan": "HeGe",
  "YanZhenJieGuo": "2143",
  "ZhengFanMian": "ZhengQue",
  "ShouGan": "1243",
  "ShaXiang": "BuZhengQue",
  "CaiLiaoCiDianZhuYaoWenTi": "124",
  "YinBiaoWeiZhi": "BuZhengQue",
  "JieLun": "BuZuoPanDing",
  "GuiGeOrKuanDu": "KuanDu",
  "GuiGeOrKuanDuDanWei": "1243",
  "DuiChenXingOrWanQuDu": "WanQuDu",
  "DuiChenXingOrWanQuDuDanWei": "1234",
  "JieLunBeiZhu": "2134"
}
""")

