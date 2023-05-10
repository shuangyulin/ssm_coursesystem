<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/kejian.css" /> 

<div id="kejian_manage"></div>
<div id="kejian_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="kejian_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="kejian_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="kejian_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="kejian_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="kejian_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="kejianQueryForm" method="post">
			课件标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="kejian_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="kejianEditDiv">
	<form id="kejianEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_id_edit" name="kejian.id" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">课件标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_title_edit" name="kejian.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">文件路径:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_path_edit" name="kejian.path" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_addTime_edit" name="kejian.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Kejian/js/kejian_manage.js"></script> 
