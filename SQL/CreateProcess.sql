Drop PROC createNewProcess
-----创建新的表格时在对应的表格插入数据
CREATE PROC createNewProcess
@processID varchar(50),
 @processName varchar(50), 
 @processClass varchar(50),
  @processDescription varchar(50)
AS
BEGIN
DECLARE @flowID uniqueidentifier;
INSERT INTO RMI_PROCESS_TYPE(ID, NAME, CLASS, DESCRIPTION) VALUES( @processID, @processName, @processClass, @processDescription );
SELECT @flowID = flowID FROM RMI_WORK_FLOW WHERE FlowName = '所有表单';
INSERT INTO RMI_FLOW_PROCESS(FLOWID, PROCESSID) VALUES(@flowID, @processID);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'4b652f7e-846e-419c-818e-544e1d00e6a5', 1);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'36929b8a-8c15-4068-8c0a-6da2060aa172', 0);
END


exec dbo.createNewProcess 'F08', '白油检验记录', '辅料', '辅料检验'

