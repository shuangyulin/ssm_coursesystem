$(function () {
	$.ajax({
		url : "Video/" + $("#video_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#video_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (video, response, status) {
			$.messager.progress("close");
			if (video) { 
				$("#video_id_edit").val(video.id);
				$("#video_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#video_title_edit").val(video.title);
				$("#video_title_edit").validatebox({
					required : true,
					missingMessage : "请输入视频资料标题",
				});
				$("#video_chapterId_id_edit").combobox({
					url:"Chapter/listAll",
					valueField:"id",
					textField:"title",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#video_chapterId_id_edit").combobox("select", video.chapterIdPri);
						//var data = $("#video_chapterId_id_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#video_chapterId_id_edit").combobox("select", data[0].id);
						//}
					}
				});
				$("#video_path_edit").val(video.path);
				$("#video_path_edit").validatebox({
					required : true,
					missingMessage : "请输入文件路径",
				});
				$("#video_addTime_edit").val(video.addTime);
				$("#video_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入添加时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#videoModifyButton").click(function(){ 
		if ($("#videoEditForm").form("validate")) {
			$("#videoEditForm").form({
			    url:"Video/" +  $("#video_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#videoEditForm").form("validate"))  {
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
			$("#videoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
