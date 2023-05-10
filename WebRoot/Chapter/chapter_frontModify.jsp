<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Chapter" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Chapter chapter = (Chapter)request.getAttribute("chapter");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改章信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">章信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="chapterEditForm" id="chapterEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="chapter_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="chapter_id_edit" name="chapter.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="chapter_title_edit" class="col-md-3 text-right">章标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="chapter_title_edit" name="chapter.title" class="form-control" placeholder="请输入章标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chapter_addTime_edit" class="col-md-3 text-right">添加时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="chapter_addTime_edit" name="chapter.addTime" class="form-control" placeholder="请输入添加时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxChapterModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#chapterEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改章信息界面并初始化数据*/
function chapterEdit(id) {
	$.ajax({
		url :  basePath + "Chapter/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (chapter, response, status) {
			if (chapter) {
				$("#chapter_id_edit").val(chapter.id);
				$("#chapter_title_edit").val(chapter.title);
				$("#chapter_addTime_edit").val(chapter.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交章信息信息表单给服务器端修改*/
function ajaxChapterModify() {
	$.ajax({
		url :  basePath + "Chapter/" + $("#chapter_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#chapterEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "Chapter/frontlist";
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    chapterEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

