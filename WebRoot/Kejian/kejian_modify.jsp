<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/kejian.css" />
<div id="kejian_editDiv">
	<form id="kejianEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_id_edit" name="kejian.id" value="<%=request.getParameter("id") %>" style="width:200px" />
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
		<div class="operation">
			<a id="kejianModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Kejian/js/kejian_modify.js"></script> 
