<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HomeworkUpload" %>
<%@ page import="com.chengxusheji.po.HomeworkTask" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<HomeworkUpload> homeworkUploadList = (List<HomeworkUpload>)request.getAttribute("homeworkUploadList");
    //获取所有的homeworkTaskObj信息
    List<HomeworkTask> homeworkTaskList = (List<HomeworkTask>)request.getAttribute("homeworkTaskList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    HomeworkTask homeworkTaskObj = (HomeworkTask)request.getAttribute("homeworkTaskObj");
    Student studentObj = (Student)request.getAttribute("studentObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>上传的作业查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>HomeworkUpload/frontlist">上传的作业信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>HomeworkUpload/homeworkUpload_frontAdd.jsp" style="display:none;">添加上传的作业</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<homeworkUploadList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		HomeworkUpload homeworkUpload = homeworkUploadList.get(i); //获取到上传的作业对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>HomeworkUpload/<%=homeworkUpload.getUploadId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=homeworkUpload.getHomeworkFile()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		记录编号:<%=homeworkUpload.getUploadId() %>
			     	</div>
			     	<div class="field">
	            		作业标题:<%=homeworkUpload.getHomeworkTaskObj().getTitle() %>
			     	</div>
			     	<div class="field">
	            		提交的学生:<%=homeworkUpload.getStudentObj().getName() %>
			     	</div>
			     	<div class="field">
	            		提交时间:<%=homeworkUpload.getUploadTime() %>
			     	</div>
			     	<div class="field">
	            		批改时间:<%=homeworkUpload.getPigaiTime() %>
			     	</div>
			     	<div class="field">
	            		是否批改:<%=homeworkUpload.getPigaiFlag() %>
			     	</div>
			     	<div class="field">
	            		评语:<%=homeworkUpload.getPingyu() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>HomeworkUpload/<%=homeworkUpload.getUploadId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="homeworkUploadEdit('<%=homeworkUpload.getUploadId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="homeworkUploadDelete('<%=homeworkUpload.getUploadId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>上传的作业查询</h1>
		</div>
		<form name="homeworkUploadQueryForm" id="homeworkUploadQueryForm" action="<%=basePath %>HomeworkUpload/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="homeworkTaskObj_homeworkId">作业标题：</label>
                <select id="homeworkTaskObj_homeworkId" name="homeworkTaskObj.homeworkId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(HomeworkTask homeworkTaskTemp:homeworkTaskList) {
	 					String selected = "";
 					if(homeworkTaskObj!=null && homeworkTaskObj.getHomeworkId()!=null && homeworkTaskObj.getHomeworkId().intValue()==homeworkTaskTemp.getHomeworkId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=homeworkTaskTemp.getHomeworkId() %>" <%=selected %>><%=homeworkTaskTemp.getTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="studentObj_studentNumber">提交的学生：</label>
                <select id="studentObj_studentNumber" name="studentObj.studentNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentObj!=null && studentObj.getStudentNumber()!=null && studentObj.getStudentNumber().equals(studentTemp.getStudentNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getStudentNumber() %>" <%=selected %>><%=studentTemp.getName() %></option>
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
<div id="homeworkUploadEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;上传的作业信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="homeworkUploadEditForm" id="homeworkUploadEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="homeworkUpload_uploadId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="homeworkUpload_uploadId_edit" name="homeworkUpload.uploadId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="homeworkUpload_homeworkTaskObj_homeworkId_edit" class="col-md-3 text-right">作业标题:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkUpload_homeworkTaskObj_homeworkId_edit" name="homeworkUpload.homeworkTaskObj.homeworkId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_studentObj_studentNumber_edit" class="col-md-3 text-right">提交的学生:</label>
		  	 <div class="col-md-9">
			    <select id="homeworkUpload_studentObj_studentNumber_edit" name="homeworkUpload.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_homeworkFile_edit" class="col-md-3 text-right">作业文件:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="homeworkUpload_homeworkFileImg" border="0px"/><br/>
			    <input type="hidden" id="homeworkUpload_homeworkFile" name="homeworkUpload.homeworkFile"/>
			    <input id="homeworkFileFile" name="homeworkFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_uploadTime_edit" class="col-md-3 text-right">提交时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_uploadTime_edit" name="homeworkUpload.uploadTime" class="form-control" placeholder="请输入提交时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_resultFile_edit" class="col-md-3 text-right">批改结果文件:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="homeworkUpload_resultFileImg" border="0px"/><br/>
			    <input type="hidden" id="homeworkUpload_resultFile" name="homeworkUpload.resultFile"/>
			    <input id="resultFileFile" name="resultFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pigaiTime_edit" class="col-md-3 text-right">批改时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pigaiTime_edit" name="homeworkUpload.pigaiTime" class="form-control" placeholder="请输入批改时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pigaiFlag_edit" class="col-md-3 text-right">是否批改:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pigaiFlag_edit" name="homeworkUpload.pigaiFlag" class="form-control" placeholder="请输入是否批改">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="homeworkUpload_pingyu_edit" class="col-md-3 text-right">评语:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="homeworkUpload_pingyu_edit" name="homeworkUpload.pingyu" class="form-control" placeholder="请输入评语">
			 </div>
		  </div>
		</form> 
	    <style>#homeworkUploadEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxHomeworkUploadModify();">提交</button>
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
    document.homeworkUploadQueryForm.currentPage.value = currentPage;
    document.homeworkUploadQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.homeworkUploadQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.homeworkUploadQueryForm.currentPage.value = pageValue;
    documenthomeworkUploadQueryForm.submit();
}

/*弹出修改上传的作业界面并初始化数据*/
function homeworkUploadEdit(uploadId) {
	$.ajax({
		url :  basePath + "HomeworkUpload/" + uploadId + "/update",
		type : "get",
		dataType: "json",
		success : function (homeworkUpload, response, status) {
			if (homeworkUpload) {
				$("#homeworkUpload_uploadId_edit").val(homeworkUpload.uploadId);
				$.ajax({
					url: basePath + "HomeworkTask/listAll",
					type: "get",
					success: function(homeworkTasks,response,status) { 
						$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").empty();
						var html="";
		        		$(homeworkTasks).each(function(i,homeworkTask){
		        			html += "<option value='" + homeworkTask.homeworkId + "'>" + homeworkTask.title + "</option>";
		        		});
		        		$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").html(html);
		        		$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").val(homeworkUpload.homeworkTaskObjPri);
					}
				});
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#homeworkUpload_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.name + "</option>";
		        		});
		        		$("#homeworkUpload_studentObj_studentNumber_edit").html(html);
		        		$("#homeworkUpload_studentObj_studentNumber_edit").val(homeworkUpload.studentObjPri);
					}
				});
				$("#homeworkUpload_homeworkFile").val(homeworkUpload.homeworkFile);
				$("#homeworkUpload_homeworkFileImg").attr("src", basePath +　homeworkUpload.homeworkFile);
				$("#homeworkUpload_uploadTime_edit").val(homeworkUpload.uploadTime);
				$("#homeworkUpload_resultFile").val(homeworkUpload.resultFile);
				$("#homeworkUpload_resultFileImg").attr("src", basePath +　homeworkUpload.resultFile);
				$("#homeworkUpload_pigaiTime_edit").val(homeworkUpload.pigaiTime);
				$("#homeworkUpload_pigaiFlag_edit").val(homeworkUpload.pigaiFlag);
				$("#homeworkUpload_pingyu_edit").val(homeworkUpload.pingyu);
				$('#homeworkUploadEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除上传的作业信息*/
function homeworkUploadDelete(uploadId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "HomeworkUpload/deletes",
			data : {
				uploadIds : uploadId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#homeworkUploadQueryForm").submit();
					//location.href= basePath + "HomeworkUpload/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交上传的作业信息表单给服务器端修改*/
function ajaxHomeworkUploadModify() {
	$.ajax({
		url :  basePath + "HomeworkUpload/" + $("#homeworkUpload_uploadId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#homeworkUploadEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#homeworkUploadQueryForm").submit();
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

