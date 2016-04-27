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
	自定义decimalJSON encoder类来使decimal可以序列化
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
	SQL += """Id uniqueidentifier default NEWSEQUENTIALID() primary key,
			  SerialNo uniqueidentifier,
			  InspectorNo varchar(50)"""
	SQL += ")"
	return SQL

if __name__=="__main__":
	print JSONToCreateTable("""
{
  "KuanDuBiaoZhunZhi": "65",
  "KuanDuBiaoZhunPianCha": "6151",
  "KuanDuShiCe1": "65",
  "KuanDuShiCe2": "65",
  "KuanDuShiCe3": "165",
  "ChangDuBiaoZhunZhi": "165",
  "ChangDuBiaoZhunPianCha": "16515",
  "ChangDuShiCe1": "1651",
  "ChangDuShiCe2": "65",
  "ChangDuShiCe3": "165",
  "JuanHao": "12",
  "GangHao": "4156",
  "ShuLiangPiBiao1": "456",
  "ShuLiangShiCe1": "48",
  "ShuLiangPiBiao2": "489",
  "ShuLiangShiCe2": "84",
  "JianYanShu": "984",
  "KuanDuOrGuiGeBiaoZhunZhi": "89498",
  "KuanDuOrGuiGeBiaoZhunPianCha": "489",
  "KuanDuOrGuiGeShiCe1": "498",
  "KuanDuOrGuiGeShiCe2": "49",
  "KuanDuOrGuiGeShiCe3": "8489",
  "CiDianJiDian": "489",
  "CiDianJiFen": "4",
  "DuiChenXingOrWanQuDuBiaoZhunZhi": "894",
  "DuiChenXingOrWanQuDuBiaoZhunPianCha": "894",
  "DuiChenXingOrWanQuDuShiCe": "984",
  "KeZhongBiaoZhunPianCha": "51651",
  "KeZhongShiCe": "516",
  "KeZhongBiaoZhunZhi": "156",
  "KaiDuBiaoZhunZhi": "55",
  "KaiDuBiaoZhunPianCha": "156",
  "KaiDuShiCe": "51651",
  "HouDuBiaoZhunZhi": "651",
  "HouDuBiaoZhunPianCha": "651",
  "HouDuShiCe": "651",
  "HuaXingBiaoZhunZhi": "651",
  "HuaXingBiaoZhunPianCha": "51",
  "HuaXingShiCe": "561",
  "DengJiPanDing": "C",
  "BeiZhu": "51",
  "ShouRouHuiSuoLv": "156",
  "ZiRanHuiSuoLv": "615",
  "XiangMuFlag": {
    "hasKuanDuOrGuiGe": true,
    "hasCiDian": true,
    "hasDuiChenXingOrWanQuDu": true,
    "hasKeZhong": true,
    "hasKaiDu": true,
    "hasChangKuan": true,
    "hasHouDu": true,
    "hasHuaXingXunHuan": true
  },
  "check1": true,
  "check2": true,
  "check3": true,
  "LeiBie": "A",
  "ShuLiang": {
    "MiIsChecked": true,
    "PianIsChecked": true
  },
  "GuiGeOrKuanDu": "KuanDu",
  "GuiGeOrKuanDuDanWei": "23",
  "DuiChenXingOrWanQuDu": "WanQuDu",
  "DuiChenXingOrWanQuDuDanWei": "23",
  "hasBiaoZhunSeKa": true,
  "BiaoZhunSeKa": "516",
  "hasCaiLiaoFengYang": true,
  "CaiLiaoFengYang": "51",
  "QiWei": "ZhengChang",
  "QiWeiBeiZhu": "51",
  "AnLunShiYan": "HeGe",
  "YanZhenJieGuo": "1565",
  "ZhengFanMian": "ZhengQue",
  "ShouGan": "516",
  "ShaXiang": "ZhengQue",
  "YinBiaoWeiZhi": "ZhengQue",
  "GangTuoBeiZhu": "32452345",
  "CaiLiaoCiDianZhuYaoWenTi": "3245324523",
  "JieLun": "BuHeGe",
  "JieLunBeiZhu": "234234"
}
""")




