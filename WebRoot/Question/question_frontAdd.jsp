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
<title>在线问答添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Question/frontlist">在线问答列表</a></li>
			    	<li role="presentation" class="active"><a href="#questionAdd" aria-controls="questionAdd" role="tab" data-toggle="tab">添加在线问答</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="questionList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="questionAdd"> 
				      	<form class="form-horizontal" name="questionAddForm" id="questionAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="question_teacherId_id" class="col-md-2 text-right">提问的老师:</label>
						  	 <div class="col-md-8">
							    <select id="question_teacherId_id" name="question.teacherId.id" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="question_questioner" class="col-md-2 text-right">提问者:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="question_questioner" name="question.questioner" class="form-control" placeholder="请输入提问者">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="question_content" class="col-md-2 text-right">提问内容:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="question_content" name="question.content" class="form-control" placeholder="请输入提问内容">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="question_reply" class="col-md-2 text-right">回复内容:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="question_reply" name="question.reply" class="form-control" placeholder="请输入回复内容">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="question_addTime" class="col-md-2 text-right">提问时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="question_addTime" name="question.addTime" class="form-control" placeholder="请输入提问时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxQuestionAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#questionAddForm .form-group {margin:10px;}  </style>
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
	//提交添加在线问答信息
	function ajaxQuestionAdd() { 
		//提交之前先验证表单
		$("#questionAddForm").data('bootstrapValidator').validate();
		if(!$("#questionAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Question/add",
			dataType : "json" , 
			data: new FormData($("#questionAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#questionAddForm").find("input").val("");
					$("#questionAddForm").find("textarea").val("");
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
	//验证在线问答添加表单字段
	$('#questionAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"question.questioner": {
				validators: {
					notEmpty: {
						message: "提问者不能为空",
					}
				}
			},
			"question.content": {
				validators: {
					notEmpty: {
						message: "提问内容不能为空",
					}
				}
			},
			"question.reply": {
				validators: {
					notEmpty: {
						message: "回复内容不能为空",
					}
				}
			},
			"question.addTime": {
				validators: {
					notEmpty: {
						message: "提问时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化提问的老师下拉框值 
	$.ajax({
		url: basePath + "Teacher/listAll",
		type: "get",
		success: function(teachers,response,status) { 
			$("#question_teacherId_id").empty();
			var html="";
    		$(teachers).each(function(i,teacher){
    			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
    		});
    		$("#question_teacherId_id").html(html);
    	}
	});
})
</script>
</body>
</html>
