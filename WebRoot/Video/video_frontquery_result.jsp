<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Video" %>
<%@ page import="com.chengxusheji.po.Chapter" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Video> videoList = (List<Video>)request.getAttribute("videoList");
    //获取所有的chapterId信息
    List<Chapter> chapterList = (List<Chapter>)request.getAttribute("chapterList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String title = (String)request.getAttribute("title"); //视频资料标题查询关键字
    Chapter chapterId = (Chapter)request.getAttribute("chapterId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>视频信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#videoListPanel" aria-controls="videoListPanel" role="tab" data-toggle="tab">视频信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Video/video_frontAdd.jsp" style="display:none;">添加视频信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="videoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>视频资料标题</td><td>所属章</td><td>文件路径</td><td>添加时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<videoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Video video = videoList.get(i); //获取到视频信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=video.getId() %></td>
 											<td><%=video.getTitle() %></td>
 											<td><%=video.getChapterId().getTitle() %></td>
 											<td><%=video.getPath() %></td>
 											<td><%=video.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Video/<%=video.getId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="videoEdit('<%=video.getId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="videoDelete('<%=video.getId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>视频信息查询</h1>
		</div>
		<form name="videoQueryForm" id="videoQueryForm" action="<%=basePath %>Video/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="title">视频资料标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入视频资料标题">
			</div>






            <div class="form-group">
            	<label for="chapterId_id">所属章：</label>
                <select id="chapterId_id" name="chapterId.id" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Chapter chapterTemp:chapterList) {
	 					String selected = "";
 					if(chapterId!=null && chapterId.getId()!=null && chapterId.getId().intValue()==chapterTemp.getId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=chapterTemp.getId() %>" <%=selected %>><%=chapterTemp.getTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="videoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;视频信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#videoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxVideoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.videoQueryForm.currentPage.value = currentPage;
    document.videoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.videoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.videoQueryForm.currentPage.value = pageValue;
    documentvideoQueryForm.submit();
}

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
				$('#videoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除视频信息信息*/
function videoDelete(id) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Video/deletes",
			data : {
				ids : id,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#videoQueryForm").submit();
					//location.href= basePath + "Video/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

