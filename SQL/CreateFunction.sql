use RMI
----��ȡ��ǰ������ִ�в���ĺ���
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


----��ȡ��ǰProcessID��Ӧ����һ���޸ĵ�ʱ��
CREATE FUNCTION getLastModifiedTimeByProcessID(@serialno uniqueidentifier, @process varchar(50))
RETURNS datetime
AS
BEGIN
DECLARE @lastModifiedTime datetime;
SELECT TOP 1 @lastModifiedTime = lastModifiedTime FROM RMI_TASK_PROCESS WITH(NOLOCK)WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @lastModifiedTime;
END

----��ȡ��ǰProcessID��Ӧ����һ���޸ĵ��û����������û�ID
CREATE FUNCTION getLastModifiedUserNameByProcessID(@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_TASK_PROCESS a WITH(NOLOCK)JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)
ON a.LastModifiedUser = b.ID WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @name;
END


----����USERID��ȡ�û�����
CREATE FUNCTION getUserNameByUserID(@UserID varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE ID = @UserID;
RETURN @name;
END


----���ݲ�������ID��ȡ������������
CREATE FUNCTION getMaterialTypeNameByID(@materialTypeID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialTypeName FROM RMI_MATERIAL_TYPE WHERE MaterialTypeID = @materialTypeID;
RETURN @name;
END

----���ݲ���ID��ȡ��������
CREATE FUNCTION getMaterialNameByID(@materialID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialName FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @name;
END

----���ݲ�������ID��ȡ�����������ID
CREATE FUNCTION getMaterialTypeIDByMaterialID(@materialID uniqueidentifier)
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @ID uniqueidentifier;
SELECT TOP 1 @ID = MaterialTypeID FROM RMI_MATERIAL_TYPE_NAME WHERE MaterialID = @materialID;
RETURN @ID;
END

----���ݵ�λID��ȡ��λ����
CREATE FUNCTION getUnitNameByID(@UnitID uniqueidentifier)
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = UnitName FROM RMI_UNIT WHERE UnitID = @UnitID;
RETURN @name;
END


---���ݹ�Ӧ�̴����ȡ��Ӧ������
CREATE FUNCTION getSupplierNameByID(@SupplierCode varchar(50))
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = SupplierName FROM RMI_SUPPLIER WHERE SupplierCode = @SupplierCode;
RETURN @name;
END