<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HomeworkTask" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<HomeworkTask> homeworkTaskList = (List<HomeworkTask>)request.getAttribute("homeworkTaskList");
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Teacher teacherObj = (Teacher)request.getAttribute("teacherObj");
    String title = (String)request.getAttribute("title"); //作业标题查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>作业任务查询</title>
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
			    	<li role="presentation" class="active"><a href="#homeworkTaskListPanel" aria-controls="homeworkTaskListPanel" role="tab" data-toggle="tab">作业任务列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>HomeworkTask/homeworkTask_frontAdd.jsp" style="display:none;">添加作业任务</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="homeworkTaskListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>老师</td><td>作业标题</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<homeworkTaskList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		HomeworkTask homeworkTask = homeworkTaskList.get(i); //获取到作业任务对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=homeworkTask.getHomeworkId() %></td>
 											<td><%=homeworkTask.getTeacherObj().getName() %></td>
 											<td><%=homeworkTask.getTitle() %></td>
 											<td><%=homeworkTask.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>HomeworkTask/<%=homeworkTask.getHomeworkId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="homeworkTaskEdit('<%=homeworkTask.getHomeworkId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="homeworkTaskDelete('<%=homeworkTask.getHomeworkId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>作业任务查询</h1>
		</div>
		<form name="homeworkTaskQueryForm" id="homeworkTaskQueryForm" action="<%=basePath %>HomeworkTask/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="teacherObj_id">老师：</label>
                <select id="teacherObj_id" name="teacherObj.id" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(teacherObj!=null && teacherObj.getId()!=null && teacherObj.getId().intValue()==teacherTemp.getId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getId() %>" <%=selected %>><%=teacherTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">作业标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入作业标题">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="homeworkTaskEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;作业任务信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="homeworkTaskEditForm" id="homeworkTaskEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="homeworkTask_homeworkId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="homeworkTask_homeworkId_edit" name="homeworkTask.homeworkId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="homeworkTask_teacherObj_id_edit" class="col-md-3 text-right">老师:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkTask_teacherObj_id_edit" name="homeworkTask.teacherObj.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_title_edit" class="col-md-3 text-right">作业标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkTask_title_edit" name="homeworkTask.title" class="form-control" placeholder="请输入作业标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_content_edit" class="col-md-3 text-right">作业内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="homeworkTask_content_edit" name="homeworkTask.content" rows="8" class="form-control" placeholder="请输入作业内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkTask_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkTask_addTime_edit" name="homeworkTask.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
		</form> 
	    <style>#homeworkTaskEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxHomeworkTaskModify();">提交</button>
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
    document.homeworkTaskQueryForm.currentPage.value = currentPage;
    document.homeworkTaskQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.homeworkTaskQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.homeworkTaskQueryForm.currentPage.value = pageValue;
    documenthomeworkTaskQueryForm.submit();
}

/*弹出修改作业任务界面并初始化数据*/
function homeworkTaskEdit(homeworkId) {
	$.ajax({
		url :  basePath + "HomeworkTask/" + homeworkId + "/update",
		type : "get",
		dataType: "json",
		success : function (homeworkTask, response, status) {
			if (homeworkTask) {
				$("#homeworkTask_homeworkId_edit").val(homeworkTask.homeworkId);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#homeworkTask_teacherObj_id_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
		        		});
		        		$("#homeworkTask_teacherObj_id_edit").html(html);
		        		$("#homeworkTask_teacherObj_id_edit").val(homeworkTask.teacherObjPri);
					}
				});
				$("#homeworkTask_title_edit").val(homeworkTask.title);
				$("#homeworkTask_content_edit").val(homeworkTask.content);
				$("#homeworkTask_addTime_edit").val(homeworkTask.addTime);
				$('#homeworkTaskEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除作业任务信息*/
function homeworkTaskDelete(homeworkId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "HomeworkTask/deletes",
			data : {
				homeworkIds : homeworkId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#homeworkTaskQueryForm").submit();
					//location.href= basePath + "HomeworkTask/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交作业任务信息表单给服务器端修改*/
function ajaxHomeworkTaskModify() {
	$.ajax({
		url :  basePath + "HomeworkTask/" + $("#homeworkTask_homeworkId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#homeworkTaskEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#homeworkTaskQueryForm").submit();
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

