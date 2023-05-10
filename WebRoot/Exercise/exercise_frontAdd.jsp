<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Chapter" %>
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
<title>习题信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Exercise/frontlist">习题信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#exerciseAdd" aria-controls="exerciseAdd" role="tab" data-toggle="tab">添加习题信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="exerciseList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="exerciseAdd"> 
				      	<form class="form-horizontal" name="exerciseAddForm" id="exerciseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="exercise_title" class="col-md-2 text-right">习题名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exercise_title" name="exercise.title" class="form-control" placeholder="请输入习题名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exercise_chapterId_id" class="col-md-2 text-right">所在章:</label>
						  	 <div class="col-md-8">
							    <select id="exercise_chapterId_id" name="exercise.chapterId.id" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exercise_content" class="col-md-2 text-right">练习内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="exercise_content" name="exercise.content" rows="8" class="form-control" placeholder="请输入练习内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exercise_addTime" class="col-md-2 text-right">加入时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exercise_addTime" name="exercise.addTime" class="form-control" placeholder="请输入加入时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxExerciseAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#exerciseAddForm .form-group {margin:10px;}  </style>
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
	//提交添加习题信息信息
	function ajaxExerciseAdd() { 
		//提交之前先验证表单
		$("#exerciseAddForm").data('bootstrapValidator').validate();
		if(!$("#exerciseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Exercise/add",
			dataType : "json" , 
			data: new FormData($("#exerciseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#exerciseAddForm").find("input").val("");
					$("#exerciseAddForm").find("textarea").val("");
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
	//验证习题信息添加表单字段
	$('#exerciseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"exercise.title": {
				validators: {
					notEmpty: {
						message: "习题名称不能为空",
					}
				}
			},
			"exercise.content": {
				validators: {
					notEmpty: {
						message: "练习内容不能为空",
					}
				}
			},
			"exercise.addTime": {
				validators: {
					notEmpty: {
						message: "加入时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在章下拉框值 
	$.ajax({
		url: basePath + "Chapter/listAll",
		type: "get",
		success: function(chapters,response,status) { 
			$("#exercise_chapterId_id").empty();
			var html="";
    		$(chapters).each(function(i,chapter){
    			html += "<option value='" + chapter.id + "'>" + chapter.title + "</option>";
    		});
    		$("#exercise_chapterId_id").html(html);
    	}
	});
})
</script>
</body>
</html>
