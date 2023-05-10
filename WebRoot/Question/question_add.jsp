<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/question.css" />
<div id="questionAddDiv">
	<form id="questionAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">提问的老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_teacherId_id" name="question.teacherId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提问者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_questioner" name="question.questioner" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">提问内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_content" name="question.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">回复内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_reply" name="question.reply" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">提问时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="question_addTime" name="question.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="questionAddButton" class="easyui-linkbutton">添加</a>
			<a id="questionClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Question/js/question_add.js"></script> 
