<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/question.css" />
<div id="question_editDiv">
	<form id="questionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_id_edit" name="question.id" value="<%=request.getParameter("id") %>" style="width:200px" />
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
		<div class="operation">
			<a id="questionModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Question/js/question_modify.js"></script> 
