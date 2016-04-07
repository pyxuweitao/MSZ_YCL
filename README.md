# `MSZ_YCL` 原材料质检系统版本更新记录

[![Build Status](https://travis-ci.org/tufu9441/maupassant-hexo.svg?branch=master)](https://travis-ci.org/tufu9441/maupassant-hexo) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/pyxuweitao/MSZ_YCL/blob/master/LICENSE)

------------
>[@xuweitao](https://github.com/pyxuweitao/MSZ_YCL"code on github")
><strong>2016年2月20日正式开始开发工作</strong>
>**以下是更新记录：**
></br>

<table>

<tr>
<td style="width:150px"><strong>Date&Tags</strong></td><td style="width:100px"><strong>Features</strong></td><td style = "width:80px"><strong>Note</strong></td>
</tr>

<tr>
	<td>2016-04-10<h4>v0.2.4.0410_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>F01新增主吊牌默认填写列</li>
    <li>数据库F01表新增isZhuDiaoPai字段用来区分主吊牌和普通行</li>
    <li>为方便后期统计数据，在新建任务时新增填写到料总数和单位，材料名称，供应商名称</li>
    <li>实现到料总数和单位，材料名称，供应商名称的模糊查询</li>
    </td>
	<td>
	<ul>
	
	</ul>
	</td>
</tr>


<tr>
	<td>2016-04-03<h4>v0.2.3.0403_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>新增供应商模糊匹配查询接口</li>
    <li>采用RESTFUL规范设计了供应商配置页面和增删查改相关功能</li>
    </td>
	<td>
	<ul>
	
	</ul>
	</td>
</tr>

<tr>
	<td>2016-03-27<h4>v0.2.2.0327_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>增加主料（面料、花边）表并发布测试</li>
	</td>
	<td>
	<ul>
	
	</ul>
	</td>
</tr>





<tr>
	<td>2016-03-20<h4>v0.2.1.0320_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>增加实验室检测报告并发布测试</li>
	<li>增加模杯水洗报告并发布测试</li>
	<li>增加成品洗涤测试报告并发布测试</li>
	<li>增加疲劳拉伸测试报告并发布测试</li>
	<li>增加海绵检验记录并发布测试</li>
	<li>增加白油检验报告并发布测试</li>
	<li>F01检验号非3实现醒目提醒</li>
	<li>任务增加提交功能，检验任务列表对已提交任务实现过滤</li>
	<li>F01实测数和合格数默认相等</li>
	<li>F01外观扫描结果默认OK</li>
	<li>F01选商标默认艾利，选种类默认尼欧，纸卡默认星汉</li>
	<li>表格列表按照完成情况进行排序，进度低靠前</li>
	</td>
	<td>
	<ul>
	
	</ul>
	</td>
</tr>



<tr>
	<td>2016-03-13<h4>v0.2.0.0313_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>设计辅料表界面</li>
	<li>实现辅料表的录入和提交功能，与数据库联动</li>
	<li>实现辅料表的数据读取和显示</li>
	<li>实现辅料表审批和检验员录入汇总功能</li>
	<li>简化表的填写、实现自定义录入</li>
	<li>实现辅料表的输入验证和超出合格范围的提示</li>
	<li>部署和发布辅料表提供测试</li>
	</td>
	<td>
	<ul>
	
	</ul>
	</td>
</tr>

<tr>
<td>2016-02-28<h4>v0.0.1.0228_alpha</h4>
</td>
<td> 
<ul>
<li>更正项目名称:MSZ_YCL</li>
<li>优化了用户管理界面和交互</li>
<li>实现了删除用户的功能，优化了用户管理增删改查的业务逻辑和性能</li>
<li>简化、优化了工作流程，实现了“任务流”的工作流程设计，检验操作界面重新设计</li>
<li>实现了对任务的增删查改功能，数据库建立相应数据表与前台联动</li>
<li>数据库表存储结构重新设计，实现细化到表单填写各步骤完成状态、自动创建对应流程表单的数据存储应用</li>
<li>重新设计了任务列表，实现分页和搜索功能</li>
<li>设计和实现了任务明细页面表单的显示和修改</li>
<li>实现F01表格录入和提交功能，与数据库联动</li>

</td>
<td>
<ul>
<li>收货报告部分功能经过沟通暂缓开发，如进度富余增添收获报告直接导入检验报告的功能。</li>
<li>TODO:任务明细表录入、状态转换、状态确认等相关功能实现</li>
</ul>
</td>
</tr>

<tr>
<td>2016-02-20<h4>v0.0.0.0220_alpha</h4>
</td>
<td> 
<ul>
<li>实现django静态资源server</li>
<li>实现添加新用户和编辑用户信息的功能</li>
</td>
<td>
<ul>
<li>TODO：检验流程相关功能的实现</li>
</ul>
</td>
</tr>

</table>
