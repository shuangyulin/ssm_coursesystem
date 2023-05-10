<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeworkUpload.css" /> 

<div id="homeworkUpload_manage"></div>
<div id="homeworkUpload_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="homeworkUpload_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="homeworkUpload_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="homeworkUpload_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="homeworkUpload_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="homeworkUpload_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="homeworkUploadQueryForm" method="post">
			作业标题：<input class="textbox" type="text" id="homeworkTaskObj_homeworkId_query" name="homeworkTaskObj.homeworkId" style="width: auto"/>
			提交的学生：<input class="textbox" type="text" id="studentObj_studentNumber_query" name="studentObj.studentNumber" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="homeworkUpload_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="homeworkUploadEditDiv">
	<form id="homeworkUploadEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="homeworkUpload_uploadId_edit" name="homeworkUpload.uploadId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="HomeworkUpload/js/homeworkUpload_manage.js"></script> 
