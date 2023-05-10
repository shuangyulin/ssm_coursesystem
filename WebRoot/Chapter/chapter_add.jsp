<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chapter.css" />
<div id="chapterAddDiv">
	<form id="chapterAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">章标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chapter_title" name="chapter.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chapter_addTime" name="chapter.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="chapterAddButton" class="easyui-linkbutton">添加</a>
			<a id="chapterClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Chapter/js/chapter_add.js"></script> 
