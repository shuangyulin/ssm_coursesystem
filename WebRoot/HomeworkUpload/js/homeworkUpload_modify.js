$(function () {
	$.ajax({
		url : "HomeworkUpload/" + $("#homeworkUpload_uploadId_edit").val() + "/update",
		type : "get",
		data : {
			//uploadId : $("#homeworkUpload_uploadId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (homeworkUpload, response, status) {
			$.messager.progress("close");
			if (homeworkUpload) { 
				$("#homeworkUpload_uploadId_edit").val(homeworkUpload.uploadId);
				$("#homeworkUpload_uploadId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox({
					url:"HomeworkTask/listAll",
					valueField:"homeworkId",
					textField:"title",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("select", homeworkUpload.homeworkTaskObjPri);
						//var data = $("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("select", data[0].homeworkId);
						//}
					}
				});
				$("#homeworkUpload_studentObj_studentNumber_edit").combobox({
					url:"Student/listAll",
					valueField:"studentNumber",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#homeworkUpload_studentObj_studentNumber_edit").combobox("select", homeworkUpload.studentObjPri);
						//var data = $("#homeworkUpload_studentObj_studentNumber_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#homeworkUpload_studentObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						//}
					}
				});
				$("#homeworkUpload_homeworkFile").val(homeworkUpload.homeworkFile);
				$("#homeworkUpload_homeworkFileImg").attr("src", homeworkUpload.homeworkFile);
				$("#homeworkUpload_uploadTime_edit").val(homeworkUpload.uploadTime);
				$("#homeworkUpload_uploadTime_edit").validatebox({
					required : true,
					missingMessage : "请输入提交时间",
				});
				$("#homeworkUpload_resultFile").val(homeworkUpload.resultFile);
				$("#homeworkUpload_resultFileImg").attr("src", homeworkUpload.resultFile);
				$("#homeworkUpload_pigaiTime_edit").val(homeworkUpload.pigaiTime);
				$("#homeworkUpload_pigaiTime_edit").validatebox({
					required : true,
					missingMessage : "请输入批改时间",
				});
				$("#homeworkUpload_pigaiFlag_edit").val(homeworkUpload.pigaiFlag);
				$("#homeworkUpload_pigaiFlag_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入是否批改",
					invalidMessage : "是否批改输入不对",
				});
				$("#homeworkUpload_pingyu_edit").val(homeworkUpload.pingyu);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#homeworkUploadModifyButton").click(function(){ 
		if ($("#homeworkUploadEditForm").form("validate")) {
			$("#homeworkUploadEditForm").form({
			    url:"HomeworkUpload/" +  $("#homeworkUpload_uploadId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#homeworkUploadEditForm").form("validate"))  {
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
			$("#homeworkUploadEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
