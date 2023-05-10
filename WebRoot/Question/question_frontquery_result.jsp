<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Question" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Question> questionList = (List<Question>)request.getAttribute("questionList");
    //获取所有的teacherId信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Teacher teacherId = (Teacher)request.getAttribute("teacherId");
    String questioner = (String)request.getAttribute("questioner"); //提问者查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>在线问答查询</title>
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
			    	<li role="presentation" class="active"><a href="#questionListPanel" aria-controls="questionListPanel" role="tab" data-toggle="tab">在线问答列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Question/question_frontAdd.jsp" style="display:none;">添加在线问答</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="questionListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>提问的老师</td><td>提问者</td><td>提问内容</td><td>回复内容</td><td>提问时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<questionList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Question question = questionList.get(i); //获取到在线问答对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=question.getId() %></td>
 											<td><%=question.getTeacherId().getName() %></td>
 											<td><%=question.getQuestioner() %></td>
 											<td><%=question.getContent() %></td>
 											<td><%=question.getReply() %></td>
 											<td><%=question.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Question/<%=question.getId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="questionEdit('<%=question.getId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="questionDelete('<%=question.getId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>在线问答查询</h1>
		</div>
		<form name="questionQueryForm" id="questionQueryForm" action="<%=basePath %>Question/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="teacherId_id">提问的老师：</label>
                <select id="teacherId_id" name="teacherId.id" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(teacherId!=null && teacherId.getId()!=null && teacherId.getId().intValue()==teacherTemp.getId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getId() %>" <%=selected %>><%=teacherTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="questioner">提问者:</label>
				<input type="text" id="questioner" name="questioner" value="<%=questioner %>" class="form-control" placeholder="请输入提问者">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="questionEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;在线问答信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="questionEditForm" id="questionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="question_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="question_id_edit" name="question.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="question_teacherId_id_edit" class="col-md-3 text-right">提问的老师:</label>
		  	 <div class="col-md-9">
			    <select id="question_teacherId_id_edit" name="question.teacherId.id" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_questioner_edit" class="col-md-3 text-right">提问者:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_questioner_edit" name="question.questioner" class="form-control" placeholder="请输入提问者">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_content_edit" class="col-md-3 text-right">提问内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_content_edit" name="question.content" class="form-control" placeholder="请输入提问内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_reply_edit" class="col-md-3 text-right">回复内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_reply_edit" name="question.reply" class="form-control" placeholder="请输入回复内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="question_addTime_edit" class="col-md-3 text-right">提问时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="question_addTime_edit" name="question.addTime" class="form-control" placeholder="请输入提问时间">
			 </div>
		  </div>
		</form> 
	    <style>#questionEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxQuestionModify();">提交</button>
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
    document.questionQueryForm.currentPage.value = currentPage;
    document.questionQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.questionQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.questionQueryForm.currentPage.value = pageValue;
    documentquestionQueryForm.submit();
}

/*弹出修改在线问答界面并初始化数据*/
function questionEdit(id) {
	$.ajax({
		url :  basePath + "Question/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (question, response, status) {
			if (question) {
				$("#question_id_edit").val(question.id);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#question_teacherId_id_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.id + "'>" + teacher.name + "</option>";
		        		});
		        		$("#question_teacherId_id_edit").html(html);
		        		$("#question_teacherId_id_edit").val(question.teacherIdPri);
					}
				});
				$("#question_questioner_edit").val(question.questioner);
				$("#question_content_edit").val(question.content);
				$("#question_reply_edit").val(question.reply);
				$("#question_addTime_edit").val(question.addTime);
				$('#questionEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除在线问答信息*/
function questionDelete(id) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Question/deletes",
			data : {
				ids : id,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#questionQueryForm").submit();
					//location.href= basePath + "Question/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交在线问答信息表单给服务器端修改*/
function ajaxQuestionModify() {
	$.ajax({
		url :  basePath + "Question/" + $("#question_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#questionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#questionQueryForm").submit();
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

