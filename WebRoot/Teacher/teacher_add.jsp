<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" />
<div id="teacherAddDiv">
	<form id="teacherAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_name" name="teacher.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_position" name="teacher.position" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_password" name="teacher.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师简介:</span>
			<span class="inputControl">
				<textarea id="teacher_introduction" name="teacher.introduction" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="teacherAddButton" class="easyui-linkbutton">添加</a>
			<a id="teacherClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Teacher/js/teacher_add.js"></script> 
