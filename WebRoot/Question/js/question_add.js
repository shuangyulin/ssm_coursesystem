$(function () {
	$("#question_teacherId_id").combobox({
	    url:'Teacher/listAll',
	    valueField: "id",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#question_teacherId_id").combobox("getData"); 
            if (data.length > 0) {
                $("#question_teacherId_id").combobox("select", data[0].id);
            }
        }
	});
	$("#question_questioner").validatebox({
		required : true, 
		missingMessage : '请输入提问者',
	});

	$("#question_content").validatebox({
		required : true, 
		missingMessage : '请输入提问内容',
	});

	$("#question_reply").validatebox({
		required : true, 
		missingMessage : '请输入回复内容',
	});

	$("#question_addTime").validatebox({
		required : true, 
		missingMessage : '请输入提问时间',
	});

	//单击添加按钮
	$("#questionAddButton").click(function () {
		//验证表单 
		if(!$("#questionAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#questionAddForm").form({
			    url:"Question/add",
			    onSubmit: function(){
					if($("#questionAddForm").form("validate"))  { 
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
                        $("#questionAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#questionAddForm").submit();
		}
	});

	//单击清空按钮
	$("#questionClearButton").click(function () { 
		$("#questionAddForm").form("clear"); 
	});
});
