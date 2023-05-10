<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkUpload.css" />
<div id="homeworkUploadAddDiv">
	<form id="homeworkUploadAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">作业标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_homeworkTaskObj_homeworkId" name="homeworkUpload.homeworkTaskObj.homeworkId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提交的学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_studentObj_studentNumber" name="homeworkUpload.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">作业文件:</span>
			<span class="inputControl">
				<input id="homeworkFileFile" name="homeworkFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">提交时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_uploadTime" name="homeworkUpload.uploadTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">批改结果文件:</span>
			<span class="inputControl">
				<input id="resultFileFile" name="resultFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">批改时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pigaiTime" name="homeworkUpload.pigaiTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">是否批改:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pigaiFlag" name="homeworkUpload.pigaiFlag" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">评语:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pingyu" name="homeworkUpload.pingyu" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="homeworkUploadAddButton" class="easyui-linkbutton">添加</a>
			<a id="homeworkUploadClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/HomeworkUpload/js/homeworkUpload_add.js"></script> 
