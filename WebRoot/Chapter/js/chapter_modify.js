$(function () {
	$.ajax({
		url : "Chapter/" + $("#chapter_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#chapter_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (chapter, response, status) {
			$.messager.progress("close");
			if (chapter) { 
				$("#chapter_id_edit").val(chapter.id);
				$("#chapter_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#chapter_title_edit").val(chapter.title);
				$("#chapter_title_edit").validatebox({
					required : true,
					missingMessage : "请输入章标题",
				});
				$("#chapter_addTime_edit").val(chapter.addTime);
				$("#chapter_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入添加时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#chapterModifyButton").click(function(){ 
		if ($("#chapterEditForm").form("validate")) {
			$("#chapterEditForm").form({
			    url:"Chapter/" +  $("#chapter_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#chapterEditForm").form("validate"))  {
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
			$("#chapterEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
