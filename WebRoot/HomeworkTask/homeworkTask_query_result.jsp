<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkTask.css" /> 

<div id="homeworkTask_manage"></div>
<div id="homeworkTask_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="homeworkTask_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="homeworkTask_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="homeworkTask_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="homeworkTask_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="homeworkTask_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="homeworkTaskQueryForm" method="post">
			老师：<input class="textbox" type="text" id="teacherObj_id_query" name="teacherObj.id" style="width: auto"/>
			作业标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="homeworkTask_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="homeworkTaskEditDiv">
	<form id="homeworkTaskEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_homeworkId_edit" name="homeworkTask.homeworkId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="homeworkTask_teacherObj_id_edit" name="homeworkTask.teacherObj.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">作业标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_title_edit" name="homeworkTask.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作业内容:</span>
			<span class="inputControl">
				<textarea id="homeworkTask_content_edit" name="homeworkTask.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_addTime_edit" name="homeworkTask.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="HomeworkTask/js/homeworkTask_manage.js"></script> 
