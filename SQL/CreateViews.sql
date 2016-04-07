-----��Ӧ�̽��������������
DROP VIEW SupplierInfoAnalysis
CREATE VIEW SupplierInfoAnalysis /*������ͼ*/
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

----��ӦSQL
SELECT SupplierCode ��Ӧ�̴���, dbo.getSupplierNameByID(SupplierCode) ��Ӧ������,
 SUM(DaoLiaoZongShu) ��������, COUNT(*) ��������,
CONVERT(varchar(10), Createtime , 21) ���� ,
(SELECT COUNT(*) FROM RMI_TASK A
 WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
  AND dbo.taskJudgement(SerialNo) = 0
   AND A.SupplierCode = B.SupplierCode AND A.UnitID = B.UnitID) ���ϸ�����,
  (SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
 WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
  AND dbo.taskJudgement(SerialNo) = 0
   AND C.SupplierCode = B.SupplierCode AND C.UnitID = B.UnitID) ���ϸ�����
 FROM RMI_TASK B
GROUP BY SupplierCode, unitid, CONVERT(varchar(10), Createtime , 21)
