$(function () {
	$.ajax({
		url : "Student/" + $("#student_studentNumber_edit").val() + "/update",
		type : "get",
		data : {
			//studentNumber : $("#student_studentNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (student, response, status) {
			$.messager.progress("close");
			if (student) { 
				$("#student_studentNumber_edit").val(student.studentNumber);
				$("#student_studentNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入学号",
					editable: false
				});
				$("#student_password_edit").val(student.password);
				$("#student_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登陆密码",
				});
				$("#student_name_edit").val(student.name);
				$("#student_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#student_sex_edit").val(student.sex);
				$("#student_sex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#student_birthday_edit").datebox({
					value: student.birthday,
					required: true,
					showSeconds: true,
				});
				$("#student_zzmm_edit").val(student.zzmm);
				$("#student_zzmm_edit").validatebox({
					required : true,
					missingMessage : "请输入政治面貌",
				});
				$("#student_className_edit").val(student.className);
				$("#student_className_edit").validatebox({
					required : true,
					missingMessage : "请输入所在班级",
				});
				$("#student_telephone_edit").val(student.telephone);
				$("#student_photo").val(student.photo);
				$("#student_photoImg").attr("src", student.photo);
				$("#student_address_edit").val(student.address);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#studentModifyButton").click(function(){ 
		if ($("#studentEditForm").form("validate")) {
			$("#studentEditForm").form({
			    url:"Student/" +  $("#student_studentNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#studentEditForm").form("validate"))  {
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
			$("#studentEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
