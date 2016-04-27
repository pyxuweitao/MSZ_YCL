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
  "YangPinMingChen": "1",
  "PiCiAndGangHao": "1",
  "ShenQingBuMen": "1",
  "SongJianRen": "11",
  "ZhengChangOrJiaJi": "ZhengChang",
  "CaiLiaoXingZhi": "ZiGou",
  "JianCeXingZhi": "ChouJian",
  "WeiWaiXiangMu": "LiHuaChangGui",
  "LaiYangQingKuang": "DaHuoYang",
  "CanKaoBiaoZhun": "231",
  "CaoZuoGongYi": "465",
  "WaiJianCaiLiaoMingChen1": "54",
  "WaiJianHuoHao1": "6",
  "WaiJianSeHao1": "5646",
  "WaiJianPiCiGangHao1": "5465",
  "WaiJianGongYingShang1": "465",
  "WaiJianCaiLiaoMingChen2": "465",
  "WaiJianHuoHao2": "4",
  "WaiJianSeHao2": "654",
  "WaiJianPiCiGangHao2": "65465",
  "WaiJianGongYingShang2": "465",
  "hasDuanLieQiangLi": true,
  "DuanLieQiangLiBiaoZhun1": "456",
  "DuanLieQiangLiBiaoZhun2": "456",
  "DuanLieQiangLiJianCeJieGuo2": "546",
  "DuanLieQiangLiJianCeJieGuo1": "156",
  "hasYaXianYingDu": true,
  "YaXianYingDuBiaoZhun1": "456",
  "YaXianYingDuBiaoZhun2": "456",
  "YaXianYingDuJianCeJieGuo1": "465",
  "YaXianYingDuJianCeJieGuo2": "465",
  "hasSiPoQiangLi": true,
  "SiPoQiangLiJingXiangBiaoZhun1": "456",
  "SiPoQiangLiJingXiangBiaoZhun2": "456",
  "SiPoQiangLiJingXiangJieGuo1": "456",
  "SiPoQiangLiJingXiangJieGuo2": "456",
  "hasMiDu": true,
  "MiDuBiaoZhun1": "456",
  "MiDuBiaoZhun2": "456",
  "MiDuJieGuo1": "56",
  "MiDuJieGuo2": "56",
  "SiPoQiangLiWeiXiangBiaoZhun1": "56",
  "SiPoQiangLiWeiXiangJieGuo1": "654",
  "SiPoQiangLiWeiXiangBiaoZhun2": "12",
  "SiPoQiangLiWeiXiangJieGuo2": "12",
  "hasHuiTanXing": true,
  "HuiTanGaoDuBiaoZhun1": "15",
  "HuiTanGaoDuBiaoZhun2": "65",
  "HuiTanGaoDuJieGuo1": "65",
  "HuiTanGaoDuJieGuo2": "15",
  "hasDingPoQiangLi": true,
  "DingPoQiangLiBiaoZhun1": "23",
  "DingPoQiangLiBiaoZhun2": "23",
  "DingPoQiangLiJieGuo1": "23",
  "DingPoQiangLiJieGuo2": "23",
  "HuiTanLvBiaoZhun1": "23",
  "HuiTanLvBiaoZhun2": "23",
  "HuiTanLvJieGuo1": "23",
  "HuiTanLvJieGuo2": "23",
  "BoLiQiangLi1BiaoZhun1": "23",
  "hasBoLiQiangLi": true,
  "hasTanXingShenChangLv": true,
  "TanXingShenChangLv": "23",
  "hasNaiZaoXiSeLaoDu": true,
  "hasNaiShuiXiSeLaoDu": true,
  "hasNaiHanZiSeLaoDu": true,
  "hasNaiMoCaSeLaoDu": true,
  "hasNaiReSeLaoDu": true,
  "NaiReSeLaoDuBiaoZhun1": "23",
  "NaiReSeLaoDuBiaoZhun2": "23",
  "ShiMoBiaoZhun2": "23",
  "GanMoBiaoZhun1": "32",
  "GanMoBiaoZhun2": "23",
  "ShiMoBiaoZhun1": "23",
  "QiTaYaoQiu": "23",
  "PingDing": "KaiFaCeShi",
  "BuHeGeChuLi": "23",
  "YuYangJiLu": "DiuQi",
  "XiDiSuoShuiLvWeiXiangBiaoZhun2": "23",
  "XiDiSuoShuiLvWeiXiangBiaoZhun1": "23",
  "XiDiSuoShuiLvJingXiangBiaoZhun1": "23",
  "JiaQuanBiaoZhun1": "3",
  "SiLieQiangDuSiLieQiangDuBiaoZhun1": "23",
  "LaShenQiangDuLaShenQiangDuBiaoZhun1": "23",
  "LaShenQiangDuZuiDaLiZhiBiaoZhun1": "23",
  "DuanLieShenChangLvBiaoZhun1": "23",
  "KangHuangBianBiaoZhun1": "23",
  "DuanLieBiaoJuBiaoZhun2": "23",
  "DuanLieBiaoJuBiaoZhun1": "232",
  "KangHuangBianBiaoZhun2": "3232",
  "DuanLieBiaoJuJieGuo1": "2323",
  "KangHuangBianJieGuo1": "23",
  "KangHuangBianJieGuo2": "23",
  "DuanLieBiaoJuJieGuo2": "23",
  "DuanLieShenChangLvJieGuo2": "23",
  "DuanLieShenChangLvJieGuo1": "23",
  "LaShenQiangDuZuiDaLiZhi1": "23",
  "LaShenQiangDuZuiDaLiZhi2": "23",
  "LaShenQiangDuLaShenQiangDu2": "23",
  "LaShenQiangDuLaShenQiangDu1": "233",
  "SiLieQiangDuZuiDaSiLieLiZhi1": "3",
  "SiLieQiangDuZuiDaSiLieLiZhi2": "4",
  "SiLieQiangDuSiLieQiangDu2": "45",
  "SiLieQiangDuSiLieQiangDu1": "334",
  "FenHuangBian1": "3",
  "FenHuangBian2": "42",
  "JiaQuan2": "3",
  "JiaQuan1": "12",
  "PH1": "32",
  "XiHouNiuDu2": "432",
  "XiHouNiuDu1": "23",
  "XiDiSuoShuiLvJingXiang1": "21",
  "XiDiSuoShuiLvJingXiang2": "23",
  "XiDiSuoShuiLvWeiXiang2": "342",
  "XiDiSuoShuiLvWeiXiang1": "23",
  "XiDiSuoShuiLvJingXiangBiaoZhun2": "12",
  "XiHouNiuDuBiaoZhun2": "1",
  "XiHouNiuDuBiaoZhun1": "32",
  "PHBiaoZhun1": "1",
  "PHBiaoZhun2": "2",
  "JiaQuanBiaoZhun2": "32",
  "FenHuangBianBiaoZhun1": "12",
  "FenHuangBianBiaoZhun2": "32",
  "SiLieQiangDuSiLieQiangDuBiaoZhun2": "23",
  "SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun2": "1",
  "SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun1": "21",
  "LaShenQiangDuLaShenQiangDuBiaoZhun2": "32",
  "LaShenQiangDuZuiDaLiZhiBiaoZhun2": "2",
  "DuanLieShenChangLvBiaoZhun2": "3",
  "BoLiQiangLi1JieGuo1": "12",
  "BoLiQiangLi1JieGuo2": "15",
  "hasKangHuangBian": true,
  "hasDuanLieShenChangLv": true,
  "hasLaShenQiangDu": true,
  "hasSiLieQiangDu": true,
  "hasFenHuangBian": true,
  "hasJiaQuan": true,
  "hasPH": true,
  "hasXiHouNiuDu": true,
  "hasXiDiSuoShuiLv": true,
  "BoLiQiangLi1BiaoZhun2": "12",
  "BoLiQiangLi2BiaoZhun1": "12",
  "BoLiQiangLi2BiaoZhun2": "23",
  "BoLiQiangLi2JieGuo1": "23",
  "BoLiQiangLi2JieGuo2": "34",
  "TanXingShenChangLvJingXiang1": "23",
  "TanXingShenChangLvJingXiang2": "34",
  "TanXingShenChangLvWeiXiang1": "23",
  "TanXingShenChangLvWeiXiang2": "23",
  "NaiZaoXiBianSe1": "1",
  "NaiZaoXiBianSe2": "23",
  "NaiZaoXiSeLaoDuZhanSe1": "34",
  "NaiZaoXiSeLaoDuZhanSe2": "54",
  "NaiShuiXiSeLaoDuBianSe1": "23",
  "NaiShuiXiSeLaoDuBianSe2": "54",
  "NaiShuiXiSeLaoDuZhanSe1": "5",
  "NaiShuiXiSeLaoDuZhanSe2": "3",
  "NaiHanZiSeLaoDuBianSe1": "4",
  "NaiHanZiSeLaoDuBianSe2": "12",
  "NaiHanZiSeLaoDuZhanSe1": "23",
  "NaiHanZiSeLaoDuZhanSe2": "43",
  "GanMo1": "5",
  "GanMo2": "43",
  "ShiMo2": "23",
  "ShiMo1": "23",
  "NaiReSeLaoDu2": "34",
  "NaiReSeLaoDu1": "34",
  "NaiHanZiSeLaoDuZhanSeBiaoZhun2": "2",
  "NaiHanZiSeLaoDuZhanSeBiaoZhun1": "3",
  "TanXingShenChangLvJingXiangBiaoZhun1": "12",
  "TanXingShenChangLvJingXiangBiaoZhun2": "54",
  "TanXingShenChangLvWeiXiangBiaoZhun1": "23",
  "TanXingShenChangLvWeiXiangBiaoZhun2": "45",
  "NaiZaoXiBianSeBiaoZhun2": "45",
  "NaiZaoXiBianSeBiaoZhun1": "34",
  "NaiZaoXiSeLaoDuZhanSeBiaoZhun2": "234",
  "NaiZaoXiSeLaoDuZhanSeBiaoZhun1": "234",
  "NaiShuiXiSeLaoDuBianSeBiaoZhun1": "32",
  "NaiShuiXiSeLaoDuBianSeBiaoZhun2": "234",
  "NaiShuiXiSeLaoDuZhanSeBiaoZhun2": "234",
  "NaiHanZiSeLaoDuBianSeBiaoZhun2": "234",
  "NaiHanZiSeLaoDuBianSeBiaoZhun1": "23",
  "NaiShuiXiSeLaoDuZhanSeBiaoZhun1": "4"
}
""")




