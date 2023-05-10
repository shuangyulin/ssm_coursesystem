<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Exercise" %>
<%@ page import="com.chengxusheji.po.Chapter" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的chapterId信息
    List<Chapter> chapterList = (List<Chapter>)request.getAttribute("chapterList");
    Exercise exercise = (Exercise)request.getAttribute("exercise");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改习题信息信息</TITLE>
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
  		<li class="active">习题信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="exerciseEditForm" id="exerciseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="exercise_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="exercise_id_edit" name="exercise.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="exercise_title_edit" class="col-md-3 text-right">习题名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_title_edit" name="exercise.title" class="form-control" placeholder="请输入习题名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_chapterId_id_edit" class="col-md-3 text-right">所在章:</label>
		  	 <div class="col-md-9">
			    <select id="exercise_chapterId_id_edit" name="exercise.chapterId.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_content_edit" class="col-md-3 text-right">练习内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="exercise_content_edit" name="exercise.content" rows="8" class="form-control" placeholder="请输入练习内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_addTime_edit" class="col-md-3 text-right">加入时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_addTime_edit" name="exercise.addTime" class="form-control" placeholder="请输入加入时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxExerciseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#exerciseEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改习题信息界面并初始化数据*/
function exerciseEdit(id) {
	$.ajax({
		url :  basePath + "Exercise/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (exercise, response, status) {
			if (exercise) {
				$("#exercise_id_edit").val(exercise.id);
				$("#exercise_title_edit").val(exercise.title);
				$.ajax({
					url: basePath + "Chapter/listAll",
					type: "get",
					success: function(chapters,response,status) { 
						$("#exercise_chapterId_id_edit").empty();
						var html="";
		        		$(chapters).each(function(i,chapter){
		        			html += "<option value='" + chapter.id + "'>" + chapter.title + "</option>";
		        		});
		        		$("#exercise_chapterId_id_edit").html(html);
		        		$("#exercise_chapterId_id_edit").val(exercise.chapterIdPri);
					}
				});
				$("#exercise_content_edit").val(exercise.content);
				$("#exercise_addTime_edit").val(exercise.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交习题信息信息表单给服务器端修改*/
function ajaxExerciseModify() {
	$.ajax({
		url :  basePath + "Exercise/" + $("#exercise_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#exerciseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#exerciseQueryForm").submit();
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
    exerciseEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

