-----��Ӧ�̽��������������
DROP VIEW SupplierInfoAnalysis
CREATE VIEW SupplierInfoAnalysis /*������ͼ*/
  AS
    SELECT GongYingShangBianMa=dbo.getSupplierCodeByID(SupplierID),
		   GongYingShangMingCheng=dbo.getSupplierNameByID(SupplierID),
		   GongHuoShuLiang = SUM(DaoLiaoZongShu),  TongJiQiNeiDaoHuoPiCi=COUNT(*),
           BuHeGePiCi=(SELECT COUNT(*) FROM RMI_TASK A
						WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						AND dbo.taskJudgement(SerialNo) = 0 AND A.SupplierID = B.SupplierID AND A.UnitID = B.UnitID),
		   BuHeGeShuLiang=(SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
						   WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						   AND dbo.taskJudgement(SerialNo) = 0
						   AND C.SupplierID = B.SupplierID AND C.UnitID = B.UnitID),
			RiQi=CONVERT(varchar(10), Createtime , 21),
			DaoHuoShuLiangDanWei=(SELECT dbo.getUnitNameByID(B.UnitID))
			FROM RMI_TASK B
			WHERE dbo.getSupplierCodeByID(SupplierID) != ''
            GROUP BY SupplierID, UnitID, CONVERT(varchar(10), Createtime , 21)
GO




DROP VIEW RMI_TASK_DIVIDE_INSPECTOR
---- ����һ������Inspectors��ֽ����Ϊ������ͬ���ݣ���ͬInspector��RMI_TASK�������master..spt_values�����ֵ��Inspector��
create view RMI_TASK_DIVIDE_INSPECTOR
as
SELECT SerialNo, CONVERT(VARCHAR(16), a.CreateTime, 20) CreateTime, CONVERT(VARCHAR(16), a.LastModifiedTime, 20) LastModifiedTime,
	           ProductNo, ColorNo, CONVERT(VARCHAR(10), a.ArriveTime, 20) ArriveTime, dbo.getUserNameByUserID(UserID) Name, dbo.getSupplierCodeByID(SupplierID) SupplierCode,
	           dbo.getSupplierNameByID(SupplierID) SupplierName, MaterialID, dbo.getMaterialNameByID(MaterialID) MaterialName,
	           dbo.getMaterialTypeNameByID(dbo.getMaterialTypeIDByMaterialID(MaterialID)) MaterialTypeName, DaoLiaoZongShu, UnitID,
	           dbo.getUnitNameByID(UnitID) UnitName, DaoLiaoZongShu2, UnitID2, dbo.getUnitNameByID(UnitID2) AS DanWei2, UserID, InspectTotalNumber,
	           Inspectors=substring(a.Inspectors,b.number,charindex('@',a.Inspectors+'@',b.number)-b.number)
	           FROM RMI_TASK a WITH(NOLOCK) JOIN master..spt_values b WITH(NOLOCK) ON b.type = 'P'
	           WHERE charindex('@','@'+a.Inspectors,b.number)=b.number