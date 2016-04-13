if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sys_Page_v2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sys_Page_v2]
GO

CREATE PROCEDURE [dbo].[sys_Page_v2]
@PCount int output,    --��ҳ�����
@RCount int output,    --�ܼ�¼�����
@sys_Table nvarchar(100),    --��ѯ����
@sys_Key varchar(50),        --����
@sys_Fields nvarchar(500),    --��ѯ�ֶ�
@sys_Where nvarchar(3000),    --��ѯ����
@sys_Order nvarchar(100),    --�����ֶ�
@sys_Begin int,        --��ʼλ��
@sys_PageIndex int,        --��ǰҳ��
@sys_PageSize int        --ҳ��С
AS

SET NOCOUNT ON
SET ANSI_WARNINGS ON

IF @sys_PageSize < 0 OR @sys_PageIndex < 0
BEGIN        
RETURN
END

DECLARE @new_where1 NVARCHAR(3000)
DECLARE @new_order1 NVARCHAR(100)
DECLARE @new_order2 NVARCHAR(100)
DECLARE @Sql NVARCHAR(4000)
DECLARE @SqlCount NVARCHAR(4000)

DECLARE @Top int

if(@sys_Begin <=0)
    set @sys_Begin=0
else
    set @sys_Begin=@sys_Begin-1

IF ISNULL(@sys_Where,'') = ''
    SET @new_where1 = ' '
ELSE
    SET @new_where1 = ' WHERE ' + @sys_Where 

IF ISNULL(@sys_Order,'') <> '' 
BEGIN
    SET @new_order1 = ' ORDER BY ' + Replace(@sys_Order,'desc','')
    SET @new_order1 = Replace(@new_order1,'asc','desc')

    SET @new_order2 = ' ORDER BY ' + @sys_Order
END
ELSE
BEGIN
-----�˴�������
    SET @new_order1 = ' ORDER BY ID DESC'
    SET @new_order2 = ' ORDER BY ID ASC'
END

----�ⶫ��ò�Ʋ�û������
SET @SqlCount = 'SELECT @RCount=COUNT(1),@PCount=CEILING((COUNT(1)+0.0)/'
            + CAST(@sys_PageSize AS NVARCHAR)+') FROM ' + @sys_Table + @new_where1

EXEC SP_EXECUTESQL @SqlCount,N'@RCount INT OUTPUT,@PCount INT OUTPUT',
               @RCount OUTPUT,@PCount OUTPUT

IF @sys_PageIndex > CEILING((@RCount+0.0)/@sys_PageSize)    --�������ĵ�ǰҳ������ʵ����ҳ��,���ʵ����ҳ����ֵ����ǰҳ��
BEGIN
    SET @sys_PageIndex =  CEILING((@RCount+0.0)/@sys_PageSize)
END

set @sql = 'select '+ @sys_fields +' from ' + @sys_Table + ' w1 '
    + ' where '+ @sys_Key +' in ('
        +'select top '+ ltrim(str(@sys_PageSize)) +' ' + @sys_Key + ' from '
        +'('
            +'select top ' + ltrim(STR(@sys_PageSize * @sys_PageIndex + @sys_Begin)) + ' ' + @sys_Key + ' FROM ' 
        + @sys_Table + @new_where1 + @new_order2 
        +') w ' + @new_order1
    +') ' + @new_order2

print(@sql)

Exec(@sql)

GO


EXEC sys_Page_v2 1,10, 'RMI_MATERIAL_TYPE', 'MATERIALTYPEID', 'MATERIALTYPEID, MATERIALTYPENAME', '', 'LastModifiedTime desc, MaterialTypeID asc', 0, 1, 50

SELECT MaterialTypeID AS id,MaterialTypeName AS name,WorkTime AS time FROM RMI_MATERIAL_TYPE t1
						  WHERE MaterialTypeID IN (
						  	SELECT TOP 10 MaterialTypeID FROM (
						  	  SELECT TOP 10 MaterialTypeID FROM RMI_MATERIAL_TYPE  ORDER BY LASTMODIFIEDTIME DESC, MATERIALTYPEID 
						  	) t2 ORDER BY LASTMODIFIEDTIME , MATERIALTYPEID DESC
						  ) ORDER BY LASTMODIFIEDTIME DESC, MATERIALTYPEID 
						  SELECT COUNT(*) FROM RMI_MATERIAL_TYPE WHERE 
