----连接远程数据库
EXEC sp_addlinkedserver 'WINDOWS-1CKSQL1', '', 'SQLOLEDB', '192.168.1.223'
EXEC sp_addlinkedsrvlogin 'WINDOWS-1CKSQL1', 'false', null, 'msz_qc', 'qc_msz123'


DELETE FROM RMI_MATERIAL_name
DELETE from RMI_MATERIAL_TYPE
DELETE from RMI_MATERIAL_TYPE_NAME

SELECT * FROM [WINDOWS-1CKSQL1].UFDATA_101_2016.DBO.V_MSZ_STOCK


INSERT INTO RMI_MATERIAL_TYPE(MaterialTypeNAME, MaterialTypeID)
SELECT DISTINCT 大类名称, 大类编码 from [WINDOWS-1CKSQL1].UFDATA_101_2016.DBO.V_MSZ_STOCK




insert into RMI_MATERIAL_NAME(MaterialID, MaterialName)
SELECT DISTINCT 存货编码, 存货名称 from [WINDOWS-1CKSQL1].UFDATA_101_2016.DBO.V_MSZ_STOCK




INSERT INTO RMI_MATERIAL_TYPE_NAME(materialID, MaterialTypeID)
select distinct 存货编码, 大类编码 from [WINDOWS-1CKSQL1].UFDATA_101_2016.DBO.V_MSZ_STOCK
