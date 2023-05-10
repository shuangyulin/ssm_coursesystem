$(function () {
	$("#video_title").validatebox({
		required : true, 
		missingMessage : '请输入视频资料标题',
	});

	$("#video_chapterId_id").combobox({
	    url:'Chapter/listAll',
	    valueField: "id",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#video_chapterId_id").combobox("getData"); 
            if (data.length > 0) {
                $("#video_chapterId_id").combobox("select", data[0].id);
            }
        }
	});
	$("#video_path").validatebox({
		required : true, 
		missingMessage : '请输入文件路径',
	});

	$("#video_addTime").validatebox({
		required : true, 
		missingMessage : '请输入添加时间',
	});

	//单击添加按钮
	$("#videoAddButton").click(function () {
		//验证表单 
		if(!$("#videoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#videoAddForm").form({
			    url:"Video/add",
			    onSubmit: function(){
					if($("#videoAddForm").form("validate"))  { 
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
                        $("#videoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#videoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#videoClearButton").click(function () { 
		$("#videoAddForm").form("clear"); 
	});
});
