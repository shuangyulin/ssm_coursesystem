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
<title>视频信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Video/frontlist">视频信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#videoAdd" aria-controls="videoAdd" role="tab" data-toggle="tab">添加视频信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="videoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="videoAdd"> 
				      	<form class="form-horizontal" name="videoAddForm" id="videoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="video_title" class="col-md-2 text-right">视频资料标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="video_title" name="video.title" class="form-control" placeholder="请输入视频资料标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_chapterId_id" class="col-md-2 text-right">所属章:</label>
						  	 <div class="col-md-8">
							    <select id="video_chapterId_id" name="video.chapterId.id" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_path" class="col-md-2 text-right">文件路径:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="video_path" name="video.path" class="form-control" placeholder="请输入文件路径">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_addTime" class="col-md-2 text-right">添加时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="video_addTime" name="video.addTime" class="form-control" placeholder="请输入添加时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxVideoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#videoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加视频信息信息
	function ajaxVideoAdd() { 
		//提交之前先验证表单
		$("#videoAddForm").data('bootstrapValidator').validate();
		if(!$("#videoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Video/add",
			dataType : "json" , 
			data: new FormData($("#videoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#videoAddForm").find("input").val("");
					$("#videoAddForm").find("textarea").val("");
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
	//验证视频信息添加表单字段
	$('#videoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"video.title": {
				validators: {
					notEmpty: {
						message: "视频资料标题不能为空",
					}
				}
			},
			"video.path": {
				validators: {
					notEmpty: {
						message: "文件路径不能为空",
					}
				}
			},
			"video.addTime": {
				validators: {
					notEmpty: {
						message: "添加时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化所属章下拉框值 
	$.ajax({
		url: basePath + "Chapter/listAll",
		type: "get",
		success: function(chapters,response,status) { 
			$("#video_chapterId_id").empty();
			var html="";
    		$(chapters).each(function(i,chapter){
    			html += "<option value='" + chapter.id + "'>" + chapter.title + "</option>";
    		});
    		$("#video_chapterId_id").html(html);
    	}
	});
})
</script>
</body>
</html>
