<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>教师信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Teacher/frontlist">教师信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#teacherAdd" aria-controls="teacherAdd" role="tab" data-toggle="tab">添加教师信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="teacherList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="teacherAdd"> 
				      	<form class="form-horizontal" name="teacherAddForm" id="teacherAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="teacher_name" class="col-md-2 text-right">姓名:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="teacher_name" name="teacher.name" class="form-control" placeholder="请输入姓名">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="teacher_position" class="col-md-2 text-right">职称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="teacher_position" name="teacher.position" class="form-control" placeholder="请输入职称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="teacher_password" class="col-md-2 text-right">密码:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="teacher_password" name="teacher.password" class="form-control" placeholder="请输入密码">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="teacher_introduction" class="col-md-2 text-right">教师简介:</label>
						  	 <div class="col-md-8">
							    <textarea id="teacher_introduction" name="teacher.introduction" rows="8" class="form-control" placeholder="请输入教师简介"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxTeacherAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#teacherAddForm .form-group {margin:10px;}  </style>
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
	//提交添加教师信息信息
	function ajaxTeacherAdd() { 
		//提交之前先验证表单
		$("#teacherAddForm").data('bootstrapValidator').validate();
		if(!$("#teacherAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Teacher/add",
			dataType : "json" , 
			data: new FormData($("#teacherAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#teacherAddForm").find("input").val("");
					$("#teacherAddForm").find("textarea").val("");
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
	//验证教师信息添加表单字段
	$('#teacherAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"teacher.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"teacher.position": {
				validators: {
					notEmpty: {
						message: "职称不能为空",
					}
				}
			},
			"teacher.password": {
				validators: {
					notEmpty: {
						message: "密码不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
