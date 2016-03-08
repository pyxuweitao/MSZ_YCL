 `MSZ_YCL` 原材料质检系统版本更新记录
========================

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
<td>2016-03-06<h4>v0.1.0.0306_alpha</h4>
</td>
<td> 
<ul>

<li>优化表单验证，实现自动跳转填写和自动求和等方便录入的功能</li>
<li>实现表单填写步骤状态更新</li>
<li>实现单用户互斥的表单填写和多用户数据归并功能</li>
<li>实现了检验任务填写和查看汇总功能</li>
<li>实现了报表审批功能</li>
<li>实现了删除任务以及相关数据的功能</li>
<li>实现了最近一次修改记录功能</li>
<li>实现了更为精确的步骤确认和保存、提交表单功能</li>
<li>实现了任务搜索功能</li>
<li>修复了刷新需要重新登录的BUG</li>
</td>
<td>
<ul>

</ul>
</td>
</tr>

<tr>
<td>2016-03-13<h4>v0.1.1.0313_alpha</h4>
</td>
<td> 
<ul>
<li>设计辅料表界面</li>
<li>实现辅料表的录入和提交功能，与数据库联动</li>
</td>
<td>
<ul>

</ul>
</td>
</tr>

</table>