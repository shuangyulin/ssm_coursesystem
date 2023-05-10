<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/kejian.css" />
<div id="kejianAddDiv">
	<form id="kejianAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课件标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_title" name="kejian.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">文件路径:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_path" name="kejian.path" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="kejian_addTime" name="kejian.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="kejianAddButton" class="easyui-linkbutton">添加</a>
			<a id="kejianClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Kejian/js/kejian_add.js"></script> 
