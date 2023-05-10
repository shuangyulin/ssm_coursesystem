$(function () {
	$.ajax({
		url : "Kejian/" + $("#kejian_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#kejian_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (kejian, response, status) {
			$.messager.progress("close");
			if (kejian) { 
				$("#kejian_id_edit").val(kejian.id);
				$("#kejian_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#kejian_title_edit").val(kejian.title);
				$("#kejian_title_edit").validatebox({
					required : true,
					missingMessage : "请输入课件标题",
				});
				$("#kejian_path_edit").val(kejian.path);
				$("#kejian_path_edit").validatebox({
					required : true,
					missingMessage : "请输入文件路径",
				});
				$("#kejian_addTime_edit").val(kejian.addTime);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#kejianModifyButton").click(function(){ 
		if ($("#kejianEditForm").form("validate")) {
			$("#kejianEditForm").form({
			    url:"Kejian/" +  $("#kejian_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#kejianEditForm").form("validate"))  {
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
			$("#kejianEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
