<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseInfo.css" />
<div id="courseInfoAddDiv">
	<form id="courseInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程简介:</span>
			<span class="inputControl">
				<textarea id="courseInfo_jianjie" name="courseInfo.jianjie" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">课程大纲:</span>
			<span class="inputControl">
				<textarea id="courseInfo_dagan" name="courseInfo.dagan" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="courseInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="courseInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseInfo/js/courseInfo_add.js"></script> 
