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
