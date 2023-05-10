<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exercise.css" /> 

<div id="exercise_manage"></div>
<div id="exercise_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="exercise_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="exercise_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="exercise_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="exercise_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="exercise_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="exerciseQueryForm" method="post">
			习题名称：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			所在章：<input class="textbox" type="text" id="chapterId_id_query" name="chapterId.id" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="exercise_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="exerciseEditDiv">
	<form id="exerciseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_id_edit" name="exercise.id" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">习题名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_title_edit" name="exercise.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在章:</span>
			<span class="inputControl">
				<input class="textbox"  id="exercise_chapterId_id_edit" name="exercise.chapterId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">练习内容:</span>
			<span class="inputControl">
				<textarea id="exercise_content_edit" name="exercise.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">加入时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_addTime_edit" name="exercise.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Exercise/js/exercise_manage.js"></script> 
