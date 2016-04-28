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
	raw     = rawSql.Raw_sql()
	start   = "-".join([number.rjust(2,'0') if len(number) < 2 else number for number in start.split('-')])
	end     = "-".join([number.rjust(2,'0') if len(number) < 2 else number for number in end.split('-')])
	raw.sql = """SELECT GongYingShangBianMa, GongYingShangMingCheng,
				 CAST(SUM(GongHuoShuLiang) as varchar(50)) + DaoHuoShuLiangDanWei GongHuoShuLiang, SUM(TongJiQiNeiDaoHuoPiCi) TongJiQiNeiDaoHuoPiCi,
				 SUM(BuHeGePiCi) BuHeGePiCi, SUM(BuHeGeShuLiang) BuHeGeShuLiang,
				 CAST(CAST( 1 - CAST(SUM(BuHeGePiCi) AS DECIMAL(9,2)) / CAST(SUM(TongJiQiNeiDaoHuoPiCi) AS DECIMAL(9,2)) AS DECIMAL(9,2)) * 100 AS INT) JinHuoJianYanHeGeLv
  				 FROM dbo.SupplierInfoAnalysis
 				 WHERE RiQi >= '%s' AND RiQi <= '%s'
 				 GROUP BY GongYingShangBianMa, GongYingShangMingCheng, DaoHuoShuLiangDanWei"""%(start,end)
	res, cols = raw.query_all(needColumnName=True)
	return CommonUtilities.translateQueryResIntoDict(columns=cols, res=res)


def getInspectorWorkTimeGroupByMaterial(year, month):
	"""
	根据查询的年份和月份产生当月检验员工时汇总
	:param year:年份
	:param month:月份，不规范
	:return:[{no:"123432",name:"陈美华",
            listData:[
           {name:"name1",count:234,time:3232},
           {name:"name2",count:2234,time:32232}]}]
	"""
	raw = rawSql.Raw_sql()
	raw.sql = """SELECT Inspectors, dbo.getUserNameByUserID(Inspectors) InspectorName, MaterialID, dbo.getMaterialNameByID(MaterialID) MaterialName,
 				 dbo.getMaterialWorkTime(MaterialID) WorkTime, SUM(InspectTotalNumber) InspectTotalNumber
 				 FROM RMI_TASK_DIVIDE_INSPECTOR
				 WHERE InspectTotalNumber is not null AND convert(varchar(7),CreateTime,120) = '%s'
			     GROUP BY Inspectors, MaterialID"""%(unicode(year)+'-'+unicode(month).rjust(2,'0'))
	data     = list()
	dataTemp = dict()
	res  = raw.query_all()
	if not res:
		res = list()

	#工时增加主吊牌计算
	raw.sql = """SELECT InspectorNo,  dbo.getUserNameByUserID(InspectorNo) InspectorName, '04de803d-6570-4547-8dc0-1eda8470baf6',
				 dbo.getMaterialNameByID('04de803d-6570-4547-8dc0-1eda8470baf6') MaterialName,
				 dbo.getMaterialWorkTime('04de803d-6570-4547-8dc0-1eda8470baf6') WorkTime, SUM(JianYanShu) InspectTotalNumber
 				 FROM RMI_F01_DATA
 				 WHERE SerialNo in (
 				 SELECT SerialNo FROM RMI_TASK WHERE convert(varchar(7),CreateTime,120) = '%s')
 				 AND isZhuDiaoPai = 1 AND JianYanShu is not null
 				 GROUP BY InspectorNo"""%(unicode(year)+'-'+unicode(month).rjust(2,'0'))
	res2 = raw.query_all()

	if res2:
		res += res2

	if res:
		for row in res:
			if row[0] not in dataTemp:
				dataTemp[row[0]] = {"name":row[1],"listData":dict()}
			dataTemp[row[0]]['listData'][row[2]] = {"name":row[3], "time":row[4], "count":row[5]}
	for inspectorNo, inspectorData in dataTemp.items():
		inspectorData['listData'] = inspectorData['listData'].values()
		inspectorData['no']       = inspectorNo
		data.append(inspectorData)
	return data