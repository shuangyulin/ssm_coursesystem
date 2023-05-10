<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HomeworkTask" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>上传的作业添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>HomeworkUpload/frontlist">上传的作业管理</a></li>
  			<li class="active">添加上传的作业</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="homeworkUploadAddForm" id="homeworkUploadAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="homeworkUpload_homeworkTaskObj_homeworkId" class="col-md-2 text-right">作业标题:</label>
				  	 <div class="col-md-8">
					    <select id="homeworkUpload_homeworkTaskObj_homeworkId" name="homeworkUpload.homeworkTaskObj.homeworkId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_studentObj_studentNumber" class="col-md-2 text-right">提交的学生:</label>
				  	 <div class="col-md-8">
					    <select id="homeworkUpload_studentObj_studentNumber" name="homeworkUpload.studentObj.studentNumber" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_homeworkFile" class="col-md-2 text-right">作业文件:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="homeworkUpload_homeworkFileImg" border="0px"/><br/>
					    <input type="hidden" id="homeworkUpload_homeworkFile" name="homeworkUpload.homeworkFile"/>
					    <input id="homeworkFileFile" name="homeworkFileFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_uploadTime" class="col-md-2 text-right">提交时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="homeworkUpload_uploadTime" name="homeworkUpload.uploadTime" class="form-control" placeholder="请输入提交时间">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_resultFile" class="col-md-2 text-right">批改结果文件:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="homeworkUpload_resultFileImg" border="0px"/><br/>
					    <input type="hidden" id="homeworkUpload_resultFile" name="homeworkUpload.resultFile"/>
					    <input id="resultFileFile" name="resultFileFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_pigaiTime" class="col-md-2 text-right">批改时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="homeworkUpload_pigaiTime" name="homeworkUpload.pigaiTime" class="form-control" placeholder="请输入批改时间">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_pigaiFlag" class="col-md-2 text-right">是否批改:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="homeworkUpload_pigaiFlag" name="homeworkUpload.pigaiFlag" class="form-control" placeholder="请输入是否批改">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="homeworkUpload_pingyu" class="col-md-2 text-right">评语:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="homeworkUpload_pingyu" name="homeworkUpload.pingyu" class="form-control" placeholder="请输入评语">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxHomeworkUploadAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#homeworkUploadAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加上传的作业信息
	function ajaxHomeworkUploadAdd() { 
		//提交之前先验证表单
		$("#homeworkUploadAddForm").data('bootstrapValidator').validate();
		if(!$("#homeworkUploadAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "HomeworkUpload/add",
			dataType : "json" , 
			data: new FormData($("#homeworkUploadAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#homeworkUploadAddForm").find("input").val("");
					$("#homeworkUploadAddForm").find("textarea").val("");
				} else {
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
	//验证上传的作业添加表单字段
	$('#homeworkUploadAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"homeworkUpload.uploadTime": {
				validators: {
					notEmpty: {
						message: "提交时间不能为空",
					}
				}
			},
			"homeworkUpload.pigaiTime": {
				validators: {
					notEmpty: {
						message: "批改时间不能为空",
					}
				}
			},
			"homeworkUpload.pigaiFlag": {
				validators: {
					notEmpty: {
						message: "是否批改不能为空",
					},
					integer: {
						message: "是否批改不正确"
					}
				}
			},
		}
	}); 
	//初始化作业标题下拉框值 
	$.ajax({
		url: basePath + "HomeworkTask/listAll",
		type: "get",
		success: function(homeworkTasks,response,status) { 
			$("#homeworkUpload_homeworkTaskObj_homeworkId").empty();
			var html="";
    		$(homeworkTasks).each(function(i,homeworkTask){
    			html += "<option value='" + homeworkTask.homeworkId + "'>" + homeworkTask.title + "</option>";
    		});
    		$("#homeworkUpload_homeworkTaskObj_homeworkId").html(html);
    	}
	});
	//初始化提交的学生下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#homeworkUpload_studentObj_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.name + "</option>";
    		});
    		$("#homeworkUpload_studentObj_studentNumber").html(html);
    	}
	});
})
</script>
</body>
</html>
