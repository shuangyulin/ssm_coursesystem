<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exercise.css" />
<div id="exerciseAddDiv">
	<form id="exerciseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">习题名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_title" name="exercise.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在章:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_chapterId_id" name="exercise.chapterId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">练习内容:</span>
			<span class="inputControl">
				<textarea id="exercise_content" name="exercise.content" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">加入时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_addTime" name="exercise.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="exerciseAddButton" class="easyui-linkbutton">添加</a>
			<a id="exerciseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Exercise/js/exercise_add.js"></script> 
