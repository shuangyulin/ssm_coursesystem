var courseInfo_manage_tool = null; 
$(function () { 
	initCourseInfoManageTool(); //建立CourseInfo管理对象
	courseInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#courseInfo_manage").datagrid({
		url : 'CourseInfo/list',
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
		toolbar : "#courseInfo_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "jianjie",
				title : "课程简介",
				width : 140,
			},
			{
				field : "dagan",
				title : "课程大纲",
				width : 140,
			},
		]],
	});

	$("#courseInfoEditDiv").dialog({
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
				if ($("#courseInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#courseInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#courseInfoEditForm").form({
						    url:"CourseInfo/" + $("#courseInfo_id_edit").val() + "/update",
						    onSubmit: function(){
								if($("#courseInfoEditForm").form("validate"))  {
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
			                        $("#courseInfoEditDiv").dialog("close");
			                        courseInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#courseInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#courseInfoEditDiv").dialog("close");
				$("#courseInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initCourseInfoManageTool() {
	courseInfo_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#courseInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#courseInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#courseInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#courseInfoQueryForm").form({
			    url:"CourseInfo/OutToExcel",
			});
			//提交表单
			$("#courseInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#courseInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "CourseInfo/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#courseInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#courseInfo_manage").datagrid("loaded");
									$("#courseInfo_manage").datagrid("load");
									$("#courseInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#courseInfo_manage").datagrid("loaded");
									$("#courseInfo_manage").datagrid("load");
									$("#courseInfo_manage").datagrid("unselectAll");
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
			var rows = $("#courseInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "CourseInfo/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (courseInfo, response, status) {
						$.messager.progress("close");
						if (courseInfo) { 
							$("#courseInfoEditDiv").dialog("open");
							$("#courseInfo_id_edit").val(courseInfo.id);
							$("#courseInfo_id_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#courseInfo_jianjie_edit").val(courseInfo.jianjie);
							$("#courseInfo_jianjie_edit").validatebox({
								required : true,
								missingMessage : "请输入课程简介",
							});
							$("#courseInfo_dagan_edit").val(courseInfo.dagan);
							$("#courseInfo_dagan_edit").validatebox({
								required : true,
								missingMessage : "请输入课程大纲",
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
