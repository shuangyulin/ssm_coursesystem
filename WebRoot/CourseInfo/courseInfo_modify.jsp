<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseInfo.css" />
<div id="courseInfo_editDiv">
	<form id="courseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_id_edit" name="courseInfo.id" value="<%=request.getParameter("id") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">课程简介:</span>
			<span class="inputControl">
				<textarea id="courseInfo_jianjie_edit" name="courseInfo.jianjie" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">课程大纲:</span>
			<span class="inputControl">
				<textarea id="courseInfo_dagan_edit" name="courseInfo.dagan" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="courseInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseInfo/js/courseInfo_modify.js"></script> 
