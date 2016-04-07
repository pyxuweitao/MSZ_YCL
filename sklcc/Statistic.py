# -*- coding: utf-8 -*-
"""
所有有关数据统计的功能函数
"""
__author__ = 'XuWeitao'
import rawSql
import CommonUtilities

def getSuppliersAssessmentDataByDate(start, end):
	"""
	根据时间跨度范围来获取供应商评审数据
	:param start:开始时间 e.g. 2016-01-01
	:param end:结束时间 e.g. 2016-02-02
	:return:[{"GongYingShangMingCheng": 供应商名称, "BuHeGeShuLiang": 统计期内不合格批次数量,
	"TongJiQiNeiDaoHuoPiCi": 统计期内到货批次, "GongHuoShuLiang": 供货数量, "GongYingShangBianMa": 供应商编码,
	"JinHuoJianYanHeGeLv": 进货检验合格率, "BuHeGePiCi": 不合格批次数量},...]
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT GongYingShangBianMa, dbo.getSupplierNameByID(GongYingShangBianMa) GongYingShangMingCheng,
				 SUM(GongHuoShuLiang) GongHuoShuLiang, SUM(TongJiQiNeiDaoHuoPiCi) TongJiQiNeiDaoHuoPiCi,
				 SUM(BuHeGePiCi) BuHeGePiCi, SUM(BuHeGeShuLiang) BuHeGeShuLiang,
				 CAST(CAST( 1 - CAST(SUM(BuHeGePiCi) AS DECIMAL(9,2)) / CAST(SUM(TongJiQiNeiDaoHuoPiCi) AS DECIMAL(9,2)) AS DECIMAL(9,2)) * 100 AS INT) JinHuoJianYanHeGeLv
  				 FROM dbo.SupplierInfoAnalysis
 				 WHERE RiQi >= '%s' AND RiQi <= '%s'
 				 GROUP BY GongYingShangBianMa, DaoHuoShuLiangDanWei"""%(start,end)
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(columns=cols, res=res)

