CREATE VIEW SuppliersAssessment
   AS
    <select���>
IF EXISTS (SELECT * FROM sysobjects WHERE /*����Ƿ����*/
                         name = 'view_stuInfo_stuMarks')
     DROP VIEW view_stuInfo_stuMarks /*ɾ����ͼ*/
GO
CREATE VIEW view_stuInfo_stuMarks /*������ͼ*/
  AS
    SELECT ����=stuName,ѧ��=stuInfo.stuNo,
      ���Գɼ� =writtenExam,  ���Գɼ�=labExam,
            ƽ����=(writtenExam+labExam)/2
               FROM stuInfo LEFT JOIN stuMarks
                     ON stuInfo.stuNo=stuMarks.stuNo
GO
SELECT * FROM view_stuInfo_stuMarks /*ʹ����ͼ*/


-----����ʱ�䷶Χ��ȡͳ�����ڵ�������
SELECT COUNT(*) AS TongJiQiNeiDaoHuoPiCi FROM RMI_TASK
 WHERE CreateTime BETWEEN '20160101' AND '20160601'
 
 
------���ݹ�Ӧ�����ƻ�ȡ���������������ࣩ
---�������������ı���У�F01�̱�ֽ����������F02����,F07������飬F08���ͣ�F09���ϻ���

