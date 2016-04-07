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
	:return:
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT GongYingShangBianMa, dbo.getSupplierNameByID(GongYingShangBianMa) GongYingShangMingCheng,
				 SUM(GongHuoShuLiang) GongHuoShuLiang, SUM(TongJiQiNeiDaoHuoPiCi) TongJiQiNeiDaoHuoPiCi,
				 SUM(BuHeGePiCi) BuHeGePiCi, SUM(BuHeGeShuLiang) BuHeGeShuLiang,
				 CAST(CAST( 1 - CAST(SUM(BuHeGePiCi) AS DECIMAL(9,2)) / CAST(SUM(TongJiQiNeiDaoHuoPiCi) AS DECIMAL(9,2)) AS DECIMAL(9,2)) * 100 AS INT) J
  				 FROM dbo.SupplierInfoAnalysis
 				 WHERE RiQi >= '%s' AND RiQi <= '%s'inHuoJianYanHeGeLv
 				 GROUP BY GongYingShangBianMa, DaoHuoShuLiangDanWei"""%(start,end)
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(columns=cols, res=res)

if __name__=="__main__":
	getSuppliersAssessmentDataByDate('2015-01-01', '2016-10-10')