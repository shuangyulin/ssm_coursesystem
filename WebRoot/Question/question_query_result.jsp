<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/question.css" /> 

<div id="question_manage"></div>
<div id="question_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="question_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="question_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="question_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="question_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="question_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="questionQueryForm" method="post">
			提问的老师：<input class="textbox" type="text" id="teacherId_id_query" name="teacherId.id" style="width: auto"/>
			提问者：<input type="text" class="textbox" id="questioner" name="questioner" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="question_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="questionEditDiv">
	<form id="questionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_id_edit" name="question.id" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">提问的老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="question_teacherId_id_edit" name="question.teacherId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提问者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_questioner_edit" name="question.questioner" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">提问内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_content_edit" name="question.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">回复内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_reply_edit" name="question.reply" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">提问时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_addTime_edit" name="question.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Question/js/question_manage.js"></script> 
