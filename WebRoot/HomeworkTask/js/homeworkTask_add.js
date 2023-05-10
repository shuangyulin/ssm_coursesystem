$(function () {
	$("#homeworkTask_teacherObj_id").combobox({
	    url:'Teacher/listAll',
	    valueField: "id",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#homeworkTask_teacherObj_id").combobox("getData"); 
            if (data.length > 0) {
                $("#homeworkTask_teacherObj_id").combobox("select", data[0].id);
            }
        }
	});
	$("#homeworkTask_title").validatebox({
		required : true, 
		missingMessage : '请输入作业标题',
	});

	$("#homeworkTask_content").validatebox({
		required : true, 
		missingMessage : '请输入作业内容',
	});

	$("#homeworkTask_addTime").validatebox({
		required : true, 
		missingMessage : '请输入发布时间',
	});

	//单击添加按钮
	$("#homeworkTaskAddButton").click(function () {
		//验证表单 
		if(!$("#homeworkTaskAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#homeworkTaskAddForm").form({
			    url:"HomeworkTask/add",
			    onSubmit: function(){
					if($("#homeworkTaskAddForm").form("validate"))  { 
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
                        $("#homeworkTaskAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#homeworkTaskAddForm").submit();
		}
	});

	//单击清空按钮
	$("#homeworkTaskClearButton").click(function () { 
		$("#homeworkTaskAddForm").form("clear"); 
	});
});
