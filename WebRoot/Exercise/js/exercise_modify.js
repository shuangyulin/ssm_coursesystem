$(function () {
	$.ajax({
		url : "Exercise/" + $("#exercise_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#exercise_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (exercise, response, status) {
			$.messager.progress("close");
			if (exercise) { 
				$("#exercise_id_edit").val(exercise.id);
				$("#exercise_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#exercise_title_edit").val(exercise.title);
				$("#exercise_title_edit").validatebox({
					required : true,
					missingMessage : "请输入习题名称",
				});
				$("#exercise_chapterId_id_edit").combobox({
					url:"Chapter/listAll",
					valueField:"id",
					textField:"title",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#exercise_chapterId_id_edit").combobox("select", exercise.chapterIdPri);
						//var data = $("#exercise_chapterId_id_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#exercise_chapterId_id_edit").combobox("select", data[0].id);
						//}
					}
				});
				$("#exercise_content_edit").val(exercise.content);
				$("#exercise_content_edit").validatebox({
					required : true,
					missingMessage : "请输入练习内容",
				});
				$("#exercise_addTime_edit").val(exercise.addTime);
				$("#exercise_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入加入时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#exerciseModifyButton").click(function(){ 
		if ($("#exerciseEditForm").form("validate")) {
			$("#exerciseEditForm").form({
			    url:"Exercise/" +  $("#exercise_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#exerciseEditForm").form("validate"))  {
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
			$("#exerciseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
