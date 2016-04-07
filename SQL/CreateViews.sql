CREATE VIEW SuppliersAssessment
   AS
    <select语句>
IF EXISTS (SELECT * FROM sysobjects WHERE /*检测是否存在*/
                         name = 'view_stuInfo_stuMarks')
     DROP VIEW view_stuInfo_stuMarks /*删除视图*/
GO
CREATE VIEW view_stuInfo_stuMarks /*创建视图*/
  AS
    SELECT 姓名=stuName,学号=stuInfo.stuNo,
      笔试成绩 =writtenExam,  机试成绩=labExam,
            平均分=(writtenExam+labExam)/2
               FROM stuInfo LEFT JOIN stuMarks
                     ON stuInfo.stuNo=stuMarks.stuNo
GO
SELECT * FROM view_stuInfo_stuMarks /*使用视图*/


-----根据时间范围获取统计期内到货批次
SELECT COUNT(*) AS TongJiQiNeiDaoHuoPiCi FROM RMI_TASK
 WHERE CreateTime BETWEEN '20160101' AND '20160601'
 
 
------根据供应商名称获取供货数量（分种类）
---包含到料总数的表格有：F01商标纸卡不干贴，F02辅料,F07海绵检验，F08白油，F09面料花边

