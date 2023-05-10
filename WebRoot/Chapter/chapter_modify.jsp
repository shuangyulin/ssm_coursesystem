<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chapter.css" />
<div id="chapter_editDiv">
	<form id="chapterEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chapter_id_edit" name="chapter.id" value="<%=request.getParameter("id") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">章标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chapter_title_edit" name="chapter.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chapter_addTime_edit" name="chapter.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="chapterModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Chapter/js/chapter_modify.js"></script> 
