<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkTask.css" />
<div id="homeworkTask_editDiv">
	<form id="homeworkTaskEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkTask_homeworkId_edit" name="homeworkTask.homeworkId" value="<%=request.getParameter("homeworkId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="homeworkTaskModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/HomeworkTask/js/homeworkTask_modify.js"></script> 
