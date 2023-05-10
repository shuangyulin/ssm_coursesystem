<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" />
<div id="video_editDiv">
	<form id="videoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_id_edit" name="video.id" value="<%=request.getParameter("id") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">视频资料标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_title_edit" name="video.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属章:</span>
			<span class="inputControl">
				<input class="textbox"  id="video_chapterId_id_edit" name="video.chapterId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">文件路径:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_path_edit" name="video.path" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_addTime_edit" name="video.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="videoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Video/js/video_modify.js"></script> 
