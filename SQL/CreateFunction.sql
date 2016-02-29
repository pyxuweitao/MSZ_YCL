
----获取当前表单最新执行步骤的函数
CREATE FUNCTION getCurrentFinishedStep(@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @step varchar(50),@finish int;
SELECT TOP 1 @step = StepName, @finish = Finished FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_STEP b WITH(NOLOCK)
ON a.StepID = b.StepID WHERE SerialNo = @serialno
ORDER BY a.Finished DESC , b.StepSeq;
IF @finish != 1
	SELECT TOP 1 @step = StepName FROM RMI_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
	 ON a.StepID = b.StepID
	 WHERE ProcessID = @process
	 ORDER BY StepSeq DESC

RETURN @step;
END

SELECT dbo.getCurrentFinishedStep( '00EB8DAB-9BB3-4F2A-B2CF-55E01F57EFCC', 'F01' )


