<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkUpload.css" />
<div id="homeworkUpload_editDiv">
	<form id="homeworkUploadEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_uploadId_edit" name="homeworkUpload.uploadId" value="<%=request.getParameter("uploadId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">作业标题:</span>
			<span class="inputControl">
				<input class="textbox"  id="homeworkUpload_homeworkTaskObj_homeworkId_edit" name="homeworkUpload.homeworkTaskObj.homeworkId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提交的学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="homeworkUpload_studentObj_studentNumber_edit" name="homeworkUpload.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">作业文件:</span>
			<span class="inputControl">
				<img id="homeworkUpload_homeworkFileImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="homeworkUpload_homeworkFile" name="homeworkUpload.homeworkFile"/>
				<input id="homeworkFileFile" name="homeworkFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">提交时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_uploadTime_edit" name="homeworkUpload.uploadTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">批改结果文件:</span>
			<span class="inputControl">
				<img id="homeworkUpload_resultFileImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="homeworkUpload_resultFile" name="homeworkUpload.resultFile"/>
				<input id="resultFileFile" name="resultFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">批改时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pigaiTime_edit" name="homeworkUpload.pigaiTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">是否批改:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pigaiFlag_edit" name="homeworkUpload.pigaiFlag" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">评语:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_pingyu_edit" name="homeworkUpload.pingyu" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="homeworkUploadModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/HomeworkUpload/js/homeworkUpload_modify.js"></script> 
