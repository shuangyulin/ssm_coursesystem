$(function () {
	$.ajax({
		url : "CourseInfo/" + $("#courseInfo_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#courseInfo_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (courseInfo, response, status) {
			$.messager.progress("close");
			if (courseInfo) { 
				$("#courseInfo_id_edit").val(courseInfo.id);
				$("#courseInfo_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#courseInfo_jianjie_edit").val(courseInfo.jianjie);
				$("#courseInfo_jianjie_edit").validatebox({
					required : true,
					missingMessage : "请输入课程简介",
				});
				$("#courseInfo_dagan_edit").val(courseInfo.dagan);
				$("#courseInfo_dagan_edit").validatebox({
					required : true,
					missingMessage : "请输入课程大纲",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#courseInfoModifyButton").click(function(){ 
		if ($("#courseInfoEditForm").form("validate")) {
			$("#courseInfoEditForm").form({
			    url:"CourseInfo/" +  $("#courseInfo_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#courseInfoEditForm").form("validate"))  {
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
			$("#courseInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
