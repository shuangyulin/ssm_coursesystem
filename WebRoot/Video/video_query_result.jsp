<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" /> 

<div id="video_manage"></div>
<div id="video_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="video_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="video_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="video_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="video_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="video_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="videoQueryForm" method="post">
			视频资料标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			所属章：<input class="textbox" type="text" id="chapterId_id_query" name="chapterId.id" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="video_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="videoEditDiv">
	<form id="videoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_id_edit" name="video.id" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Video/js/video_manage.js"></script> 
