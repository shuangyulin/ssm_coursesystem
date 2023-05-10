<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Question" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的teacherId信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    Question question = (Question)request.getAttribute("question");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改在线问答信息</TITLE>
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
  		<li class="active">在线问答信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="questionEditForm" id="questionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="question_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="question_id_edit" name="question.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="question_teacherId_id_edit" class="col-md-3 text-right">提问的老师:</label>
		  	 <div class="col-md-9">
			    <select id="question_teacherId_id_edit" name="question.teacherId.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_questioner_edit" class="col-md-3 text-right">提问者:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_questioner_edit" name="question.questioner" class="form-control" placeholder="请输入提问者">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_content_edit" class="col-md-3 text-right">提问内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_content_edit" name="question.content" class="form-control" placeholder="请输入提问内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_reply_edit" class="col-md-3 text-right">回复内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_reply_edit" name="question.reply" class="form-control" placeholder="请输入回复内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_addTime_edit" class="col-md-3 text-right">提问时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_addTime_edit" name="question.addTime" class="form-control" placeholder="请输入提问时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxQuestionModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#questionEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改在线问答界面并初始化数据*/
function questionEdit(id) {
	$.ajax({
		url :  basePath + "Question/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (question, response, status) {
			if (question) {
				$("#question_id_edit").val(question.id);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#question_teacherId_id_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
		        		});
		        		$("#question_teacherId_id_edit").html(html);
		        		$("#question_teacherId_id_edit").val(question.teacherIdPri);
					}
				});
				$("#question_questioner_edit").val(question.questioner);
				$("#question_content_edit").val(question.content);
				$("#question_reply_edit").val(question.reply);
				$("#question_addTime_edit").val(question.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交在线问答信息表单给服务器端修改*/
function ajaxQuestionModify() {
	$.ajax({
		url :  basePath + "Question/" + $("#question_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#questionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#questionQueryForm").submit();
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
    questionEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

