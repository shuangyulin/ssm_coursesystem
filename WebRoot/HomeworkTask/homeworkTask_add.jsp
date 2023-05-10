<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkTask.css" />
<div id="homeworkTaskAddDiv">
	<form id="homeworkTaskAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_teacherObj_id" name="homeworkTask.teacherObj.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">作业标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_title" name="homeworkTask.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作业内容:</span>
			<span class="inputControl">
				<textarea id="homeworkTask_content" name="homeworkTask.content" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_addTime" name="homeworkTask.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="homeworkTaskAddButton" class="easyui-linkbutton">添加</a>
			<a id="homeworkTaskClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/HomeworkTask/js/homeworkTask_add.js"></script> 
