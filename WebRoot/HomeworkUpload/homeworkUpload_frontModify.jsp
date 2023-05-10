<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HomeworkUpload" %>
<%@ page import="com.chengxusheji.po.HomeworkTask" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的homeworkTaskObj信息
    List<HomeworkTask> homeworkTaskList = (List<HomeworkTask>)request.getAttribute("homeworkTaskList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    HomeworkUpload homeworkUpload = (HomeworkUpload)request.getAttribute("homeworkUpload");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改上传的作业信息</TITLE>
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
  		<li class="active">上传的作业信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="homeworkUploadEditForm" id="homeworkUploadEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="homeworkUpload_uploadId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="homeworkUpload_uploadId_edit" name="homeworkUpload.uploadId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="homeworkUpload_homeworkTaskObj_homeworkId_edit" class="col-md-3 text-right">作业标题:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkUpload_homeworkTaskObj_homeworkId_edit" name="homeworkUpload.homeworkTaskObj.homeworkId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_studentObj_studentNumber_edit" class="col-md-3 text-right">提交的学生:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkUpload_studentObj_studentNumber_edit" name="homeworkUpload.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_homeworkFile_edit" class="col-md-3 text-right">作业文件:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="homeworkUpload_homeworkFileImg" border="0px"/><br/>
			    <input type="hidden" id="homeworkUpload_homeworkFile" name="homeworkUpload.homeworkFile"/>
			    <input id="homeworkFileFile" name="homeworkFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_uploadTime_edit" class="col-md-3 text-right">提交时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_uploadTime_edit" name="homeworkUpload.uploadTime" class="form-control" placeholder="请输入提交时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_resultFile_edit" class="col-md-3 text-right">批改结果文件:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="homeworkUpload_resultFileImg" border="0px"/><br/>
			    <input type="hidden" id="homeworkUpload_resultFile" name="homeworkUpload.resultFile"/>
			    <input id="resultFileFile" name="resultFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pigaiTime_edit" class="col-md-3 text-right">批改时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pigaiTime_edit" name="homeworkUpload.pigaiTime" class="form-control" placeholder="请输入批改时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pigaiFlag_edit" class="col-md-3 text-right">是否批改:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pigaiFlag_edit" name="homeworkUpload.pigaiFlag" class="form-control" placeholder="请输入是否批改">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pingyu_edit" class="col-md-3 text-right">评语:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pingyu_edit" name="homeworkUpload.pingyu" class="form-control" placeholder="请输入评语">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxHomeworkUploadModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#homeworkUploadEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改上传的作业界面并初始化数据*/
function homeworkUploadEdit(uploadId) {
	$.ajax({
		url :  basePath + "HomeworkUpload/" + uploadId + "/update",
		type : "get",
		dataType: "json",
		success : function (homeworkUpload, response, status) {
			if (homeworkUpload) {
				$("#homeworkUpload_uploadId_edit").val(homeworkUpload.uploadId);
				$.ajax({
					url: basePath + "HomeworkTask/listAll",
					type: "get",
					success: function(homeworkTasks,response,status) { 
						$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").empty();
						var html="";
		        		$(homeworkTasks).each(function(i,homeworkTask){
		        			html += "<option value='" + homeworkTask.homeworkId + "'>" + homeworkTask.title + "</option>";
		        		});
		        		$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").html(html);
		        		$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").val(homeworkUpload.homeworkTaskObjPri);
					}
				});
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#homeworkUpload_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.name + "</option>";
		        		});
		        		$("#homeworkUpload_studentObj_studentNumber_edit").html(html);
		        		$("#homeworkUpload_studentObj_studentNumber_edit").val(homeworkUpload.studentObjPri);
					}
				});
				$("#homeworkUpload_homeworkFile").val(homeworkUpload.homeworkFile);
				$("#homeworkUpload_homeworkFileImg").attr("src", basePath +　homeworkUpload.homeworkFile);
				$("#homeworkUpload_uploadTime_edit").val(homeworkUpload.uploadTime);
				$("#homeworkUpload_resultFile").val(homeworkUpload.resultFile);
				$("#homeworkUpload_resultFileImg").attr("src", basePath +　homeworkUpload.resultFile);
				$("#homeworkUpload_pigaiTime_edit").val(homeworkUpload.pigaiTime);
				$("#homeworkUpload_pigaiFlag_edit").val(homeworkUpload.pigaiFlag);
				$("#homeworkUpload_pingyu_edit").val(homeworkUpload.pingyu);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交上传的作业信息表单给服务器端修改*/
function ajaxHomeworkUploadModify() {
	$.ajax({
		url :  basePath + "HomeworkUpload/" + $("#homeworkUpload_uploadId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#homeworkUploadEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#homeworkUploadQueryForm").submit();
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
    homeworkUploadEdit("<%=request.getParameter("uploadId")%>");
 })
 </script> 
</body>
</html>

