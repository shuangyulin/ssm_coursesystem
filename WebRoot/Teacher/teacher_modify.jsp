<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" />
<div id="teacher_editDiv">
	<form id="teacherEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_id_edit" name="teacher.id" value="<%=request.getParameter("id") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_name_edit" name="teacher.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_position_edit" name="teacher.position" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_password_edit" name="teacher.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师简介:</span>
			<span class="inputControl">
				<textarea id="teacher_introduction_edit" name="teacher.introduction" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="teacherModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Teacher/js/teacher_modify.js"></script> 
