<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Kejian" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Kejian kejian = (Kejian)request.getAttribute("kejian");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改课件信息信息</TITLE>
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
  		<li class="active">课件信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="kejianEditForm" id="kejianEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="kejian_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="kejian_id_edit" name="kejian.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="kejian_title_edit" class="col-md-3 text-right">课件标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="kejian_title_edit" name="kejian.title" class="form-control" placeholder="请输入课件标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="kejian_path_edit" class="col-md-3 text-right">文件路径:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="kejian_path_edit" name="kejian.path" class="form-control" placeholder="请输入文件路径">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="kejian_addTime_edit" class="col-md-3 text-right">添加时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="kejian_addTime_edit" name="kejian.addTime" class="form-control" placeholder="请输入添加时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxKejianModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#kejianEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改课件信息界面并初始化数据*/
function kejianEdit(id) {
	$.ajax({
		url :  basePath + "Kejian/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (kejian, response, status) {
			if (kejian) {
				$("#kejian_id_edit").val(kejian.id);
				$("#kejian_title_edit").val(kejian.title);
				$("#kejian_path_edit").val(kejian.path);
				$("#kejian_addTime_edit").val(kejian.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交课件信息信息表单给服务器端修改*/
function ajaxKejianModify() {
	$.ajax({
		url :  basePath + "Kejian/" + $("#kejian_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#kejianEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#kejianQueryForm").submit();
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
    kejianEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

