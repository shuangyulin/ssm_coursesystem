$(function () {
	$("#homeworkUpload_homeworkTaskObj_homeworkId").combobox({
	    url:'HomeworkTask/listAll',
	    valueField: "homeworkId",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#homeworkUpload_homeworkTaskObj_homeworkId").combobox("getData"); 
            if (data.length > 0) {
                $("#homeworkUpload_homeworkTaskObj_homeworkId").combobox("select", data[0].homeworkId);
            }
        }
	});
	$("#homeworkUpload_studentObj_studentNumber").combobox({
	    url:'Student/listAll',
	    valueField: "studentNumber",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#homeworkUpload_studentObj_studentNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#homeworkUpload_studentObj_studentNumber").combobox("select", data[0].studentNumber);
            }
        }
	});
	$("#homeworkUpload_uploadTime").validatebox({
		required : true, 
		missingMessage : '请输入提交时间',
	});

	$("#homeworkUpload_pigaiTime").validatebox({
		required : true, 
		missingMessage : '请输入批改时间',
	});

	$("#homeworkUpload_pigaiFlag").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入是否批改',
		invalidMessage : '是否批改输入不对',
	});

	//单击添加按钮
	$("#homeworkUploadAddButton").click(function () {
		//验证表单 
		if(!$("#homeworkUploadAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#homeworkUploadAddForm").form({
			    url:"HomeworkUpload/add",
			    onSubmit: function(){
					if($("#homeworkUploadAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#homeworkUploadAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#homeworkUploadAddForm").submit();
		}
	});

	//单击清空按钮
	$("#homeworkUploadClearButton").click(function () { 
		$("#homeworkUploadAddForm").form("clear"); 
	});
});
