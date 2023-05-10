<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" />
<div id="videoAddDiv">
	<form id="videoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">视频资料标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_title" name="video.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属章:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_chapterId_id" name="video.chapterId.id" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">文件路径:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_path" name="video.path" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_addTime" name="video.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="videoAddButton" class="easyui-linkbutton">添加</a>
			<a id="videoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Video/js/video_add.js"></script> 
