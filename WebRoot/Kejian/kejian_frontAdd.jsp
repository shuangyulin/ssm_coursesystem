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
<title>课件信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Kejian/frontlist">课件信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#kejianAdd" aria-controls="kejianAdd" role="tab" data-toggle="tab">添加课件信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="kejianList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="kejianAdd"> 
				      	<form class="form-horizontal" name="kejianAddForm" id="kejianAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="kejian_title" class="col-md-2 text-right">课件标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="kejian_title" name="kejian.title" class="form-control" placeholder="请输入课件标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="kejian_path" class="col-md-2 text-right">文件路径:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="kejian_path" name="kejian.path" class="form-control" placeholder="请输入文件路径">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="kejian_addTime" class="col-md-2 text-right">添加时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="kejian_addTime" name="kejian.addTime" class="form-control" placeholder="请输入添加时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxKejianAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#kejianAddForm .form-group {margin:10px;}  </style>
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
	//提交添加课件信息信息
	function ajaxKejianAdd() { 
		//提交之前先验证表单
		$("#kejianAddForm").data('bootstrapValidator').validate();
		if(!$("#kejianAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Kejian/add",
			dataType : "json" , 
			data: new FormData($("#kejianAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#kejianAddForm").find("input").val("");
					$("#kejianAddForm").find("textarea").val("");
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
	//验证课件信息添加表单字段
	$('#kejianAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"kejian.title": {
				validators: {
					notEmpty: {
						message: "课件标题不能为空",
					}
				}
			},
			"kejian.path": {
				validators: {
					notEmpty: {
						message: "文件路径不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
