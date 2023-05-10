<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HomeworkTask" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    HomeworkTask homeworkTask = (HomeworkTask)request.getAttribute("homeworkTask");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改作业任务信息</TITLE>
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
  		<li class="active">作业任务信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="homeworkTaskEditForm" id="homeworkTaskEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="homeworkTask_homeworkId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="homeworkTask_homeworkId_edit" name="homeworkTask.homeworkId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="homeworkTask_teacherObj_id_edit" class="col-md-3 text-right">老师:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkTask_teacherObj_id_edit" name="homeworkTask.teacherObj.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_title_edit" class="col-md-3 text-right">作业标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkTask_title_edit" name="homeworkTask.title" class="form-control" placeholder="请输入作业标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_content_edit" class="col-md-3 text-right">作业内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="homeworkTask_content_edit" name="homeworkTask.content" rows="8" class="form-control" placeholder="请输入作业内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkTask_addTime_edit" name="homeworkTask.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxHomeworkTaskModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#homeworkTaskEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改作业任务界面并初始化数据*/
function homeworkTaskEdit(homeworkId) {
	$.ajax({
		url :  basePath + "HomeworkTask/" + homeworkId + "/update",
		type : "get",
		dataType: "json",
		success : function (homeworkTask, response, status) {
			if (homeworkTask) {
				$("#homeworkTask_homeworkId_edit").val(homeworkTask.homeworkId);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#homeworkTask_teacherObj_id_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
		        		});
		        		$("#homeworkTask_teacherObj_id_edit").html(html);
		        		$("#homeworkTask_teacherObj_id_edit").val(homeworkTask.teacherObjPri);
					}
				});
				$("#homeworkTask_title_edit").val(homeworkTask.title);
				$("#homeworkTask_content_edit").val(homeworkTask.content);
				$("#homeworkTask_addTime_edit").val(homeworkTask.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交作业任务信息表单给服务器端修改*/
function ajaxHomeworkTaskModify() {
	$.ajax({
		url :  basePath + "HomeworkTask/" + $("#homeworkTask_homeworkId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#homeworkTaskEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#homeworkTaskQueryForm").submit();
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
    homeworkTaskEdit("<%=request.getParameter("homeworkId")%>");
 })
 </script> 
</body>
</html>

