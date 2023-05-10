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
<title>学生信息添加</title>
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
  			<li><a href="<%=basePath %>Student/frontlist">学生信息管理</a></li>
  			<li class="active">添加学生信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="studentAddForm" id="studentAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="student_studentNumber" class="col-md-2 text-right">学号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="student_studentNumber" name="student.studentNumber" class="form-control" placeholder="请输入学号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="student_password" class="col-md-2 text-right">登陆密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_password" name="student.password" class="form-control" placeholder="请输入登陆密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_name" name="student.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_sex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_sex" name="student.sex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_birthdayDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="student_birthdayDiv" class="input-group date student_birthday col-md-12" data-link-field="student_birthday" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="student_birthday" name="student.birthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_zzmm" class="col-md-2 text-right">政治面貌:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_zzmm" name="student.zzmm" class="form-control" placeholder="请输入政治面貌">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_className" class="col-md-2 text-right">所在班级:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_className" name="student.className" class="form-control" placeholder="请输入所在班级">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_telephone" name="student.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_photo" class="col-md-2 text-right">个人照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="student_photoImg" border="0px"/><br/>
					    <input type="hidden" id="student_photo" name="student.photo"/>
					    <input id="photoFile" name="photoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_address" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_address" name="student.address" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxStudentAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#studentAddForm .form-group {margin:5px;}  </style>  
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
	//提交添加学生信息信息
	function ajaxStudentAdd() { 
		//提交之前先验证表单
		$("#studentAddForm").data('bootstrapValidator').validate();
		if(!$("#studentAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Student/add",
			dataType : "json" , 
			data: new FormData($("#studentAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#studentAddForm").find("input").val("");
					$("#studentAddForm").find("textarea").val("");
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
	//验证学生信息添加表单字段
	$('#studentAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"student.studentNumber": {
				validators: {
					notEmpty: {
						message: "学号不能为空",
					}
				}
			},
			"student.password": {
				validators: {
					notEmpty: {
						message: "登陆密码不能为空",
					}
				}
			},
			"student.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"student.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"student.birthday": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"student.zzmm": {
				validators: {
					notEmpty: {
						message: "政治面貌不能为空",
					}
				}
			},
			"student.className": {
				validators: {
					notEmpty: {
						message: "所在班级不能为空",
					}
				}
			},
		}
	}); 
	//出生日期组件
	$('#student_birthdayDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#studentAddForm').data('bootstrapValidator').updateStatus('student.birthday', 'NOT_VALIDATED',null).validateField('student.birthday');
	});
})
</script>
</body>
</html>
