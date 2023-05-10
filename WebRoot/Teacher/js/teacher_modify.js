$(function () {
	$.ajax({
		url : "Teacher/" + $("#teacher_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#teacher_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (teacher, response, status) {
			$.messager.progress("close");
			if (teacher) { 
				$("#teacher_id_edit").val(teacher.id);
				$("#teacher_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#teacher_name_edit").val(teacher.name);
				$("#teacher_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#teacher_position_edit").val(teacher.position);
				$("#teacher_position_edit").validatebox({
					required : true,
					missingMessage : "请输入职称",
				});
				$("#teacher_password_edit").val(teacher.password);
				$("#teacher_password_edit").validatebox({
					required : true,
					missingMessage : "请输入密码",
				});
				$("#teacher_introduction_edit").val(teacher.introduction);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#teacherModifyButton").click(function(){ 
		if ($("#teacherEditForm").form("validate")) {
			$("#teacherEditForm").form({
			    url:"Teacher/" +  $("#teacher_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#teacherEditForm").form("validate"))  {
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
			$("#teacherEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
