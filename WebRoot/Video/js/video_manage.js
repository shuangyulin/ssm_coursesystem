var video_manage_tool = null; 
$(function () { 
	initVideoManageTool(); //建立Video管理对象
	video_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#video_manage").datagrid({
		url : 'Video/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "id",
		sortOrder : "desc",
		toolbar : "#video_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "title",
				title : "视频资料标题",
				width : 140,
			},
			{
				field : "chapterId",
				title : "所属章",
				width : 140,
			},
			{
				field : "path",
				title : "文件路径",
				width : 140,
			},
			{
				field : "addTime",
				title : "添加时间",
				width : 140,
			},
		]],
	});

	$("#videoEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#videoEditForm").form("validate")) {
					//验证表单 
					if(!$("#videoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#videoEditForm").form({
						    url:"Video/" + $("#video_id_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#videoEditDiv").dialog("close");
			                        video_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#videoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#videoEditDiv").dialog("close");
				$("#videoEditForm").form("reset"); 
			},
		}],
	});
});

function initVideoManageTool() {
	video_manage_tool = {
		init: function() {
			$.ajax({
				url : "Chapter/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#chapterId_id_query").combobox({ 
					    valueField:"id",
					    textField:"title",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{id:0,title:"不限制"});
					$("#chapterId_id_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#video_manage").datagrid("reload");
		},
		redo : function () {
			$("#video_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#video_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["chapterId.id"] = $("#chapterId_id_query").combobox("getValue");
			$("#video_manage").datagrid("options").queryParams=queryParams; 
			$("#video_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#videoQueryForm").form({
			    url:"Video/OutToExcel",
			});
			//提交表单
			$("#videoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#video_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "Video/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#video_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#video_manage").datagrid("loaded");
									$("#video_manage").datagrid("load");
									$("#video_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#video_manage").datagrid("loaded");
									$("#video_manage").datagrid("load");
									$("#video_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#video_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Video/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (video, response, status) {
						$.messager.progress("close");
						if (video) { 
							$("#videoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
