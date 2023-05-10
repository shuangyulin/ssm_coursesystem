$(function () {
	$.ajax({
		url : "HomeworkTask/" + $("#homeworkTask_homeworkId_edit").val() + "/update",
		type : "get",
		data : {
			//homeworkId : $("#homeworkTask_homeworkId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (homeworkTask, response, status) {
			$.messager.progress("close");
			if (homeworkTask) { 
				$("#homeworkTask_homeworkId_edit").val(homeworkTask.homeworkId);
				$("#homeworkTask_homeworkId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#homeworkTask_teacherObj_id_edit").combobox({
					url:"Teacher/listAll",
					valueField:"id",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#homeworkTask_teacherObj_id_edit").combobox("select", homeworkTask.teacherObjPri);
						//var data = $("#homeworkTask_teacherObj_id_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#homeworkTask_teacherObj_id_edit").combobox("select", data[0].id);
						//}
					}
				});
				$("#homeworkTask_title_edit").val(homeworkTask.title);
				$("#homeworkTask_title_edit").validatebox({
					required : true,
					missingMessage : "请输入作业标题",
				});
				$("#homeworkTask_content_edit").val(homeworkTask.content);
				$("#homeworkTask_content_edit").validatebox({
					required : true,
					missingMessage : "请输入作业内容",
				});
				$("#homeworkTask_addTime_edit").val(homeworkTask.addTime);
				$("#homeworkTask_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入发布时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#homeworkTaskModifyButton").click(function(){ 
		if ($("#homeworkTaskEditForm").form("validate")) {
			$("#homeworkTaskEditForm").form({
			    url:"HomeworkTask/" +  $("#homeworkTask_homeworkId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#homeworkTaskEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#homeworkTaskEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
