<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Video" %>
<%@ page import="com.chengxusheji.po.Chapter" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的chapterId信息
    List<Chapter> chapterList = (List<Chapter>)request.getAttribute("chapterList");
    Video video = (Video)request.getAttribute("video");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改视频信息信息</TITLE>
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
  		<li class="active">视频信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="videoEditForm" id="videoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="video_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="video_id_edit" name="video.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="video_title_edit" class="col-md-3 text-right">视频资料标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_title_edit" name="video.title" class="form-control" placeholder="请输入视频资料标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_chapterId_id_edit" class="col-md-3 text-right">所属章:</label>
		  	 <div class="col-md-9">
			    <select id="video_chapterId_id_edit" name="video.chapterId.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_path_edit" class="col-md-3 text-right">文件路径:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_path_edit" name="video.path" class="form-control" placeholder="请输入文件路径">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_addTime_edit" class="col-md-3 text-right">添加时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_addTime_edit" name="video.addTime" class="form-control" placeholder="请输入添加时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxVideoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#videoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改视频信息界面并初始化数据*/
function videoEdit(id) {
	$.ajax({
		url :  basePath + "Video/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (video, response, status) {
			if (video) {
				$("#video_id_edit").val(video.id);
				$("#video_title_edit").val(video.title);
				$.ajax({
					url: basePath + "Chapter/listAll",
					type: "get",
					success: function(chapters,response,status) { 
						$("#video_chapterId_id_edit").empty();
						var html="";
		        		$(chapters).each(function(i,chapter){
		        			html += "<option value='" + chapter.id + "'>" + chapter.title + "</option>";
		        		});
		        		$("#video_chapterId_id_edit").html(html);
		        		$("#video_chapterId_id_edit").val(video.chapterIdPri);
					}
				});
				$("#video_path_edit").val(video.path);
				$("#video_addTime_edit").val(video.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交视频信息信息表单给服务器端修改*/
function ajaxVideoModify() {
	$.ajax({
		url :  basePath + "Video/" + $("#video_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#videoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#videoQueryForm").submit();
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
    videoEdit("<%=request.getParameter("id")%>");
 })
 </script> 
</body>
</html>

