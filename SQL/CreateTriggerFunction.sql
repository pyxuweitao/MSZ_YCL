
----RMI_TASK表插入后更新RMI_TASK_PROCESS
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


----rmi_task_process表插入后更新RMI_TASK_PROCESS_STEP
CREATE TRIGGER update_rmi_task_process_step_when_rmi_task_process_insert
ON rmi_task_process
FOR INSERT
AS
DECLARE @step uniqueidentifier, @serial uniqueidentifier, @process varchar(50);
DECLARE CUR_INS_RMI_TASK_PROCESS CURSOR SCROLL FOR SELECT ProcessID, Serialno FROM INSERTED;
OPEN CUR_INS_RMI_TASK_PROCESS;
FETCH FIRST FROM CUR_INS_RMI_TASK_PROCESS INTO @process, @serial;
WHILE( @@fetch_status=0 ) 
BEGIN 
	DECLARE CUR_SEL_RMI_PROCESS_STEP CURSOR SCROLL FOR SELECT StepID FROM RMI_PROCESS_STEP;
	OPEN CUR_SEL_RMI_PROCESS_STEP;
	FETCH FIRST FROM CUR_SEL_RMI_PROCESS_STEP INTO @step;
	WHILE( @@fetch_status=0 ) 
	BEGIN 
		INSERT INTO RMI_TASK_PROCESS_STEP(Serialno, ProcessID, StepID, Finished, LastModifiedTime)
		 VALUES(@serial, @process, @step, 0, GETDATE());
		FETCH NEXT FROM CUR_SEL_RMI_PROCESS_STEP INTO @step;
	END
	CLOSE CUR_SEL_RMI_PROCESS_STEP;
	DEALLOCATE CUR_SEL_RMI_PROCESS_STEP;
	FETCH NEXT FROM CUR_INS_RMI_TASK_PROCESS INTO @process, @serial;
END
CLOSE CUR_INS_RMI_TASK_PROCESS;
DEALLOCATE CUR_INS_RMI_TASK_PROCESS;

