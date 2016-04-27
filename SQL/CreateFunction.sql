huse RMI
----获取当前表单最新执行步骤的函数
CREATE FUNCTION getCurrentFinishedStep(@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @step uniqueidentifier,@finish int, @stepName varchar(50);
SELECT TOP 1 @step = a.StepID, @finish = Finished FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
ON a.StepID = b.StepID AND a.ProcessID = b.ProcessID WHERE SerialNo = @serialno AND a.ProcessID = @process
ORDER BY a.Finished DESC , b.StepSeq;
IF @finish != 1
	SELECT TOP 1 @stepName = StepName FROM RMI_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
	 ON a.StepID = b.StepID
	 WHERE ProcessID = @process
	 ORDER BY StepSeq DESC;
ELSE
	SELECT @stepName = StepName FROM RMI_STEP WITH(NOLOCK) WHERE StepID = @step;
RETURN @stepName;
END


----获取当前ProcessID对应最晚一次修改的时间
CREATE FUNCTION getLastModifiedTimeByProcessID(@serialno uniqueidentifier, @process varchar(50))
RETURNS datetime
AS
BEGIN
DECLARE @lastModifiedTime datetime;
SELECT TOP 1 @lastModifiedTime = lastModifiedTime FROM RMI_TASK_PROCESS WITH(NOLOCK)WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @lastModifiedTime;
END

----获取当前ProcessID对应最晚一次修改的用户名，不是用户ID
CREATE FUNCTION getLastModifiedUserNameByProcessID(@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_TASK_PROCESS a WITH(NOLOCK)JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)
ON a.LastModifiedUser = b.ID WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @name;
END


----根据USERID获取用户名称
CREATE FUNCTION getUserNameByUserID(@UserID varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE ID = @UserID;
RETURN @name;
END

DROP FUNCTION getMaterialTypeNameByID
----根据材料类型ID获取材料类型名称
CREATE FUNCTION getMaterialTypeNameByID(@materialTypeID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialTypeName FROM RMI_MATERIAL_TYPE WHERE MaterialTypeID = @materialTypeID;
RETURN @name;
END

DROP FUNCTION getMaterialNameByID
----根据材料ID获取材料名称
CREATE FUNCTION getMaterialNameByID(@materialID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialName FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @name;
END

DROP FUNCTION getMaterialTypeIDByMaterialID
----根据材料名称ID获取材料类别名称ID
CREATE FUNCTION getMaterialTypeIDByMaterialID(@materialID uniqueidentifier)
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @ID uniqueidentifier;
SELECT TOP 1 @ID = MaterialTypeID FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @ID;
END



DROP FUNCTION getUnitNameByID
----根据单位ID获取单位名称
CREATE FUNCTION getUnitNameByID(@UnitID uniqueidentifier)
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(MAX);
IF @UnitID IS NOT NULL
	SELECT TOP 1 @name = UnitName FROM RMI_UNIT WHERE UnitID = @UnitID;
RETURN @name;
END
SELECT dbo.getUnitNameByID(NULL)

drop FUNCTION getSupplierNameByID
---根据供应商代码获取供应商名称
CREATE FUNCTION getSupplierNameByID(@SupplierCode varchar(50))
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = SupplierName FROM RMI_SUPPLIER WHERE SupplierCode = @SupplierCode;
RETURN @name;
END


----判断指定流水号的任务是否合格
CREATE FUNCTION taskJudgement(@serialNo uniqueidentifier)
-------0：不合格 1：合格 2：不做判定
RETURNS INT
AS
BEGIN
DECLARE @judgeResult INT, @F09Res varchar(50), @F10Res varchar(50), @F03Res varchar(50);
SELECT @F09Res = JieLun FROM RMI_F09_DATA WHERE SerialNo = @serialNo;
SELECT @F10Res = JieLun FROM RMI_F10_DATA WHERE SerialNo = @serialNo;
SELECT @F03Res = PingDing FROM RMI_F03_DATA WHERE SerialNo = @serialNo;
IF ( @F09Res = 'BuHeGe' ) OR ( @F10Res = 'BuHeGe' ) OR ( @F03Res = 'BuHeGe' )
BEGIN
	SET @judgeResult = 0;
END
ELSE
BEGIN
	IF ( @F09Res = 'HeGe' ) OR ( @F10Res = 'HeGe' ) OR ( @F03Res = 'HeGe' )
	BEGIN
		SET @judgeResult = 1;
	END
	ELSE
	BEGIN
		SET @judgeResult = 2;
	END
END
RETURN @judgeResult;
END

DROP FUNCTION getDaoLiaoZongShuAndUnit;

----获取到了总数加上对应单位的字符串，如果有两个到了总数就以/分隔
CREATE FUNCTION getDaoLiaoZongShuAndUnit(@SerialNo uniqueidentifier)
RETURNS varchar(100)
AS
BEGIN
DECLARE @DaoLiaoZongShuAndUnit VARCHAR(100),@DaoLiaoZongShu varchar(100), @DaoLiaoZongShu2 varchar(100);
SELECT @DaoLiaoZongShu = CONVERT(VARCHAR(20),DaoLiaoZongShu)+dbo.getUnitNameByID(UnitID),
	   @DaoLiaoZongShu2 = CONVERT(VARCHAR(20),ISNULL(DaoLiaoZongShu2, ''))+ISNULL(dbo.getUnitNameByID(UnitID2),'')
	   FROM RMI_TASK WHERE SerialNo = @SerialNo;
IF @DaoLiaoZongShu2 <> '0'
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu + '/' + @DaoLiaoZongShu2;
ELSE
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu;
RETURN @DaoLiaoZongShuAndUnit;
END

DROP FUNCTION getMaterialTypeIDByMaterialTypeName
------根据材料种类名称获取材料种类ID
CREATE FUNCTION getMaterialTypeIDByMaterialTypeName(@MaterialTypeName varchar(50))
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @MaterialTypeID uniqueidentifier;
SELECT TOP 1 @MaterialTypeID = MaterialTypeID FROM RMI_MATERIAL_TYPE WHERE MaterialTypeName = @MaterialTypeName;
RETURN @MaterialTypeID;
END; 
 
DROP FUNCTION getMaterialWorkTime
----根据材料ID获取材料对应工时
CREATE FUNCTION getMaterialWorkTime(@MaterialID uniqueidentifier)
RETURNS float
AS
BEGIN
DECLARE @WorkTime float;
SELECT TOP 1 @WorkTime = WorkTime FROM RMI_MATERIAL_NAME WHERE MaterialID = @MaterialID;
IF @WorkTime IS NULL
	SET @WorkTime = 0;
RETURN @WorkTime;
END


 
DROP FUNCTION getConfigByProcessIDAndMaterialID
----根据表格ID和材料小类ID获取前端配置代码
CREATE FUNCTION getConfigByProcessIDAndMaterialTypeID(@MaterialID uniqueidentifier, @ProcessID varchar(50))
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @config varchar(MAX);
SELECT TOP 1 @config = JavaScriptConfig FROM RMI_TABLE_CONFIG WHERE MaterialID = @MaterialID AND ProcessID = @ProcessID;
IF @config IS NULL
	SET @config = '';
RETURN @config;
END


