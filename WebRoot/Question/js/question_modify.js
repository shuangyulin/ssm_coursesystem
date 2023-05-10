$(function () {
	$.ajax({
		url : "Question/" + $("#question_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#question_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (question, response, status) {
			$.messager.progress("close");
			if (question) { 
				$("#question_id_edit").val(question.id);
				$("#question_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#question_teacherId_id_edit").combobox({
					url:"Teacher/listAll",
					valueField:"id",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#question_teacherId_id_edit").combobox("select", question.teacherIdPri);
						//var data = $("#question_teacherId_id_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#question_teacherId_id_edit").combobox("select", data[0].id);
						//}
					}
				});
				$("#question_questioner_edit").val(question.questioner);
				$("#question_questioner_edit").validatebox({
					required : true,
					missingMessage : "请输入提问者",
				});
				$("#question_content_edit").val(question.content);
				$("#question_content_edit").validatebox({
					required : true,
					missingMessage : "请输入提问内容",
				});
				$("#question_reply_edit").val(question.reply);
				$("#question_reply_edit").validatebox({
					required : true,
					missingMessage : "请输入回复内容",
				});
				$("#question_addTime_edit").val(question.addTime);
				$("#question_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入提问时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#questionModifyButton").click(function(){ 
		if ($("#questionEditForm").form("validate")) {
			$("#questionEditForm").form({
			    url:"Question/" +  $("#question_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#questionEditForm").form("validate"))  {
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
			$("#questionEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
