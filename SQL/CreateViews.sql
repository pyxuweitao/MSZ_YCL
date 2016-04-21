-----供应商交货情况分析报表
DROP VIEW SupplierInfoAnalysis
CREATE VIEW SupplierInfoAnalysis /*创建视图*/
  AS
    SELECT GongYingShangBianMa=SupplierCode,
		   GongYingShangMingCheng=dbo.getSupplierNameByID(SupplierCode),
		   GongHuoShuLiang = SUM(DaoLiaoZongShu),  TongJiQiNeiDaoHuoPiCi=COUNT(*),
           BuHeGePiCi=(SELECT COUNT(*) FROM RMI_TASK A
						WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						AND dbo.taskJudgement(SerialNo) = 0 AND A.SupplierCode = B.SupplierCode AND A.UnitID = B.UnitID),
		   BuHeGeShuLiang=(SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
						   WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						   AND dbo.taskJudgement(SerialNo) = 0
						   AND C.SupplierCode = B.SupplierCode AND C.UnitID = B.UnitID),
			RiQi=CONVERT(varchar(10), Createtime , 21),
			DaoHuoShuLiangDanWei=(SELECT dbo.getUnitNameByID(B.UnitID))
			FROM RMI_TASK B 
            GROUP BY SupplierCode, UnitID, CONVERT(varchar(10), Createtime , 21)
GO

----对应SQL
SELECT SupplierCode 供应商代码, dbo.getSupplierNameByID(SupplierCode) 供应商名称,
 SUM(DaoLiaoZongShu) 供货数量, COUNT(*) 到货批次,
CONVERT(varchar(10), Createtime , 21) 日期 ,
(SELECT COUNT(*) FROM RMI_TASK A
 WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
  AND dbo.taskJudgement(SerialNo) = 0
   AND A.SupplierCode = B.SupplierCode AND A.UnitID = B.UnitID) 不合格批次,
  (SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
 WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
  AND dbo.taskJudgement(SerialNo) = 0
   AND C.SupplierCode = B.SupplierCode AND C.UnitID = B.UnitID) 不合格数量
 FROM RMI_TASK B
GROUP BY SupplierCode, unitid, CONVERT(varchar(10), Createtime , 21)




---- 创建一个根据Inspectors拆分将其分为多行相同数据，不同Inspector的RMI_TASK，最多拆分master..spt_values里最大值个Inspector行
create view RMI_TASK_DIVIDE_INSPECTOR
as
SELECT SerialNo, CONVERT(VARCHAR(16), a.CreateTime, 20) CreateTime, CONVERT(VARCHAR(16), a.LastModifiedTime, 20) LastModifiedTime,
	           ProductNo, ColorNo, CONVERT(VARCHAR(10), a.ArriveTime, 20) ArriveTime, dbo.getUserNameByUserID(UserID) Name, SupplierCode,
	           dbo.getSupplierNameByID(SupplierCode) SupplierName, MaterialID, dbo.getMaterialNameByID(MaterialID) MaterialName,
	           dbo.getMaterialTypeNameByID(dbo.getMaterialTypeIDByMaterialID(MaterialID)) MaterialTypeName, DaoLiaoZongShu, UnitID,
	           dbo.getUnitNameByID(UnitID) UnitName, DaoLiaoZongShu2, UnitID2, dbo.getUnitNameByID(UnitID2) AS DanWei2,
	           Inspectors=substring(a.Inspectors,b.number,charindex('@',a.Inspectors+'@',b.number)-b.number)
	           FROM RMI_TASK a WITH(NOLOCK) JOIN master..spt_values b WITH(NOLOCK) ON b.type = 'P'
	           WHERE charindex('@','@'+a.Inspectors,b.number)=b.number