<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exercise.css" />
<div id="exercise_editDiv">
	<form id="exerciseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_id_edit" name="exercise.id" value="<%=request.getParameter("id") %>" style="width:200px" />
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
		<div class="operation">
			<a id="exerciseModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Exercise/js/exercise_modify.js"></script> 
