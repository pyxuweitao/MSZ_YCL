
----RMI_TASK表插入后更新RMI_TASK_PROCESS
use RMI


CREATE TRIGGER update_rmi_task_process_when_rmi_task_insert
ON rmi_task
FOR INSERT
AS
DECLARE @flow uniqueidentifier, @serial uniqueidentifier, @process varchar(50);
DECLARE CUR_INS CURSOR SCROLL FOR SELECT FlowID, Serialno FROM INSERTED;
OPEN CUR_INS;
FETCH FIRST FROM CUR_INS INTO @flow, @serial;
WHILE( @@fetch_status=0 ) 
BEGIN 
	DECLARE CUR_SEL CURSOR SCROLL FOR SELECT ProcessID FROM RMI_FLOW_PROCESS WHERE FlowID = @flow;
	OPEN CUR_SEL;
	FETCH FIRST FROM CUR_SEL INTO @process;
	WHILE( @@fetch_status=0 ) 
	BEGIN 
		INSERT INTO RMI_TASK_PROCESS(Serialno, ProcessID) VALUES(@serial, @process)
		FETCH NEXT FROM CUR_SEL INTO @process;
	END
	CLOSE CUR_SEL;
	DEALLOCATE CUR_SEL;
	FETCH NEXT FROM CUR_INS INTO @flow, @serial;
END
CLOSE CUR_INS;
DEALLOCATE CUR_INS;

