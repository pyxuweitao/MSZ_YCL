# `MSZ_YCL` 原材料质检系统版本更新记录

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
	<td>2016-05-01<h4>v0.4.0.0501_alpha</h4>
	</td>
	<td>
	<ul>
	<li>检测结果更正为两格</li>
    <li>保存或提交后数据丢失或乱序问题修复</li>
    <li>页面上添加检验总数汇总数量</li>
    <li>主吊牌，检验数自动为实测值的10%，四舍五入</li>
    <li>实测数=检验数=合格数，合格数和检验数互换位置，合格数修改其他不自动修改</li>
    <li>辅料表右上角新增快速创建任务，可以加快录入时货号色号频繁切换导致的频繁创建任务的问题</li>
    <li>皮标单位新增克</li>
    <li>勾袢、胸花、胶骨、钢托 实现自动计算皮标1后的实测值</li>
    <li>辅料表添加「长/宽」自定义列，长宽2个标准值，各3个实测值，一共八个值</li>
    <li>辅料表根据最新表格新增若干列</li>
    <li>面料表去掉手揉和自然收缩率</li>
    <li>面料表增加渐变色差</li>
    <li>面料表部分输入中文格子太小不能显示多行的问题修复</li>
    <li>扭斜角、对称性写成小于等于的形式</li>
    <li>修复任务管理页面删除任务失败总是失败的问题</li>
    <li>修复了材料模糊查询时查不到已有材料的问题</li>
    <li>任务删除增加提醒确认</li>
    <li>增加主吊牌工时计算</li>
    <li>供应商配置界面可以不输入供应商代码</li>
    <li>实验室检测报告标准值两格改为一格</li>
    <li>新增净重、克重列</li>
    <li>添加克重单位</li>
    <li>疵点显示问题修复</li>
    <li>新增记分记点选择框</li>
    <li>添加任务提交的提醒</li>
    <li>管理员可退回检验员已提交任务</li>
    <li>增加到料总数单位配置界面</li>
    <li>供应商报表无数据的问题修复</li>
    </ul>
    </td>
    <td>
    <ul>
    </ul>
	</td>
</tr>

<tr>
	<td>2016-04-24<h4>v0.3.1.0424_alpha</h4>
	</td>
	<td>
	<ul>
	<li>材料工时修改到小类，新增材料工时对应数据发布测试</li>
	<li>实现任务协作功能，并且同步计算工时</li>
	<li>设计并实现检验工时汇总报表</li>
    </ul>
    </td>
    <td>
	</td>
</tr>

<tr>
	<td>2016-04-17<h4>v0.3.0.0417_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>新增试模压报表</li>
    <li>实现任务合格与否的判断并且生成供应商交货情况数据</li>
    <li>完成供应商交货情况分析报表</li>
    <li>完成创建任务数据自动拉取到表格录入界面</li>
    <li>实现和修复供应商配置界面</li>
    <li>实现材料名称配置界面</li>
    <li>实现材料相关配置以及与创建任务时相关信息联动</li>
    <li>根据检验员反馈修正相关输入操作和优化了数据存储更新逻辑</li>
    <li>简化首页界面，增加创建任务快捷方式</li>
    </ul>
    </td>
	<td>
	</td>
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
    <li>实现任务的到料总数和单位，材料名称，供应商名称数据插入、更新和查询</li>
    <li>创建供应商交货情况分析报表视图</li>
    <li>实现根据制定日期范围从视图中获取供应商交货情况分析报表的数据</li>
    </ul>
    </td>
	<td>
	</td>
</tr>


<tr>
	<td>2016-04-03<h4>v0.2.3.0403_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>新增供应商模糊匹配查询接口</li>
    <li>采用RESTFUL规范设计了供应商配置页面和增删查改相关功能</li>
    </ul>
    </td>
	<td>
	</td>
</tr>

<tr>
	<td>2016-03-27<h4>v0.2.2.0327_alpha</h4>
	</td>
	<td> 
	<ul>
	<li>增加主料（面料、花边）表并发布测试</li>
    </ul>
    </td>
	<td>
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
    </ul>
    </td>
	<td>
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
    </ul>
    </td>
	<td>
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
