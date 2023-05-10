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
<title>课程信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>CourseInfo/frontlist">课程信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#courseInfoAdd" aria-controls="courseInfoAdd" role="tab" data-toggle="tab">添加课程信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="courseInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="courseInfoAdd"> 
				      	<form class="form-horizontal" name="courseInfoAddForm" id="courseInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="courseInfo_jianjie" class="col-md-2 text-right">课程简介:</label>
						  	 <div class="col-md-8">
							    <textarea id="courseInfo_jianjie" name="courseInfo.jianjie" rows="8" class="form-control" placeholder="请输入课程简介"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="courseInfo_dagan" class="col-md-2 text-right">课程大纲:</label>
						  	 <div class="col-md-8">
							    <textarea id="courseInfo_dagan" name="courseInfo.dagan" rows="8" class="form-control" placeholder="请输入课程大纲"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCourseInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#courseInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加课程信息信息
	function ajaxCourseInfoAdd() { 
		//提交之前先验证表单
		$("#courseInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#courseInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "CourseInfo/add",
			dataType : "json" , 
			data: new FormData($("#courseInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#courseInfoAddForm").find("input").val("");
					$("#courseInfoAddForm").find("textarea").val("");
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
	//验证课程信息添加表单字段
	$('#courseInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"courseInfo.jianjie": {
				validators: {
					notEmpty: {
						message: "课程简介不能为空",
					}
				}
			},
			"courseInfo.dagan": {
				validators: {
					notEmpty: {
						message: "课程大纲不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
