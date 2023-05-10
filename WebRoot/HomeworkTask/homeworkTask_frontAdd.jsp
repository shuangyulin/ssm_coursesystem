<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Teacher" %>
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
<title>作业任务添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>HomeworkTask/frontlist">作业任务列表</a></li>
			    	<li role="presentation" class="active"><a href="#homeworkTaskAdd" aria-controls="homeworkTaskAdd" role="tab" data-toggle="tab">添加作业任务</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="homeworkTaskList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="homeworkTaskAdd"> 
				      	<form class="form-horizontal" name="homeworkTaskAddForm" id="homeworkTaskAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="homeworkTask_teacherObj_id" class="col-md-2 text-right">老师:</label>
						  	 <div class="col-md-8">
							    <select id="homeworkTask_teacherObj_id" name="homeworkTask.teacherObj.id" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="homeworkTask_title" class="col-md-2 text-right">作业标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="homeworkTask_title" name="homeworkTask.title" class="form-control" placeholder="请输入作业标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="homeworkTask_content" class="col-md-2 text-right">作业内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="homeworkTask_content" name="homeworkTask.content" rows="8" class="form-control" placeholder="请输入作业内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="homeworkTask_addTime" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="homeworkTask_addTime" name="homeworkTask.addTime" class="form-control" placeholder="请输入发布时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxHomeworkTaskAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#homeworkTaskAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加作业任务信息
	function ajaxHomeworkTaskAdd() { 
		//提交之前先验证表单
		$("#homeworkTaskAddForm").data('bootstrapValidator').validate();
		if(!$("#homeworkTaskAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "HomeworkTask/add",
			dataType : "json" , 
			data: new FormData($("#homeworkTaskAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#homeworkTaskAddForm").find("input").val("");
					$("#homeworkTaskAddForm").find("textarea").val("");
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
	//验证作业任务添加表单字段
	$('#homeworkTaskAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"homeworkTask.title": {
				validators: {
					notEmpty: {
						message: "作业标题不能为空",
					}
				}
			},
			"homeworkTask.content": {
				validators: {
					notEmpty: {
						message: "作业内容不能为空",
					}
				}
			},
			"homeworkTask.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化老师下拉框值 
	$.ajax({
		url: basePath + "Teacher/listAll",
		type: "get",
		success: function(teachers,response,status) { 
			$("#homeworkTask_teacherObj_id").empty();
			var html="";
    		$(teachers).each(function(i,teacher){
    			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
    		});
    		$("#homeworkTask_teacherObj_id").html(html);
    	}
	});
})
</script>
</body>
</html>
