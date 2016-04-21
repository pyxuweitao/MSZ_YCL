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




---- ����һ������Inspectors��ֽ����Ϊ������ͬ���ݣ���ͬInspector��RMI_TASK�������master..spt_values�����ֵ��Inspector��
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