<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    CourseInfo courseInfo = (CourseInfo)request.getAttribute("courseInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改课程信息信息</TITLE>
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
  		<li class="active">课程信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="courseInfoEditForm" id="courseInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="courseInfo_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="courseInfo_id_edit" name="courseInfo.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="courseInfo_jianjie_edit" class="col-md-3 text-right">课程简介:</label>
		  	 <div class="col-md-9">
			    <textarea id="courseInfo_jianjie_edit" name="courseInfo.jianjie" rows="8" class="form-control" placeholder="请输入课程简介"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_dagan_edit" class="col-md-3 text-right">课程大纲:</label>
		  	 <div class="col-md-9">
			    <textarea id="courseInfo_dagan_edit" name="courseInfo.dagan" rows="8" class="form-control" placeholder="请输入课程大纲"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCourseInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#courseInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改课程信息界面并初始化数据*/
function courseInfoEdit(id) {
	$.ajax({
		url :  basePath + "CourseInfo/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (courseInfo, response, status) {
			if (courseInfo) {
				$("#courseInfo_id_edit").val(courseInfo.id);
				$("#courseInfo_jianjie_edit").val(courseInfo.jianjie);
				$("#courseInfo_dagan_edit").val(courseInfo.dagan);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交课程信息信息表单给服务器端修改*/
function ajaxCourseInfoModify() {
	$.ajax({
		url :  basePath + "CourseInfo/" + $("#courseInfo_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "CourseInfo/frontlist";
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
    courseInfoEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

