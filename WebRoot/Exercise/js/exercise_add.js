$(function () {
	$("#exercise_title").validatebox({
		required : true, 
		missingMessage : '请输入习题名称',
	});

	$("#exercise_chapterId_id").combobox({
	    url:'Chapter/listAll',
	    valueField: "id",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#exercise_chapterId_id").combobox("getData"); 
            if (data.length > 0) {
                $("#exercise_chapterId_id").combobox("select", data[0].id);
            }
        }
	});
	$("#exercise_content").validatebox({
		required : true, 
		missingMessage : '请输入练习内容',
	});

	$("#exercise_addTime").validatebox({
		required : true, 
		missingMessage : '请输入加入时间',
	});

	//单击添加按钮
	$("#exerciseAddButton").click(function () {
		//验证表单 
		if(!$("#exerciseAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#exerciseAddForm").form({
			    url:"Exercise/add",
			    onSubmit: function(){
					if($("#exerciseAddForm").form("validate"))  { 
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
                        $("#exerciseAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#exerciseAddForm").submit();
		}
	});

	//单击清空按钮
	$("#exerciseClearButton").click(function () { 
		$("#exerciseAddForm").form("clear"); 
	});
});
