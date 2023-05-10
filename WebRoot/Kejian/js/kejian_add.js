$(function () {
	$("#kejian_title").validatebox({
		required : true, 
		missingMessage : '请输入课件标题',
	});

	$("#kejian_path").validatebox({
		required : true, 
		missingMessage : '请输入文件路径',
	});

	//单击添加按钮
	$("#kejianAddButton").click(function () {
		//验证表单 
		if(!$("#kejianAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#kejianAddForm").form({
			    url:"Kejian/add",
			    onSubmit: function(){
					if($("#kejianAddForm").form("validate"))  { 
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
                        $("#kejianAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#kejianAddForm").submit();
		}
	});

	//单击清空按钮
	$("#kejianClearButton").click(function () { 
		$("#kejianAddForm").form("clear"); 
	});
});
