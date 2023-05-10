var kejian_manage_tool = null; 
$(function () { 
	initKejianManageTool(); //建立Kejian管理对象
	kejian_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#kejian_manage").datagrid({
		url : 'Kejian/list',
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
		toolbar : "#kejian_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "title",
				title : "课件标题",
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

	$("#kejianEditDiv").dialog({
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
				if ($("#kejianEditForm").form("validate")) {
					//验证表单 
					if(!$("#kejianEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#kejianEditForm").form({
						    url:"Kejian/" + $("#kejian_id_edit").val() + "/update",
						    onSubmit: function(){
								if($("#kejianEditForm").form("validate"))  {
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
			                        $("#kejianEditDiv").dialog("close");
			                        kejian_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#kejianEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#kejianEditDiv").dialog("close");
				$("#kejianEditForm").form("reset"); 
			},
		}],
	});
});

function initKejianManageTool() {
	kejian_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#kejian_manage").datagrid("reload");
		},
		redo : function () {
			$("#kejian_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#kejian_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			$("#kejian_manage").datagrid("options").queryParams=queryParams; 
			$("#kejian_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#kejianQueryForm").form({
			    url:"Kejian/OutToExcel",
			});
			//提交表单
			$("#kejianQueryForm").submit();
		},
		remove : function () {
			var rows = $("#kejian_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "Kejian/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#kejian_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#kejian_manage").datagrid("loaded");
									$("#kejian_manage").datagrid("load");
									$("#kejian_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#kejian_manage").datagrid("loaded");
									$("#kejian_manage").datagrid("load");
									$("#kejian_manage").datagrid("unselectAll");
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
			var rows = $("#kejian_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Kejian/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (kejian, response, status) {
						$.messager.progress("close");
						if (kejian) { 
							$("#kejianEditDiv").dialog("open");
							$("#kejian_id_edit").val(kejian.id);
							$("#kejian_id_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#kejian_title_edit").val(kejian.title);
							$("#kejian_title_edit").validatebox({
								required : true,
								missingMessage : "请输入课件标题",
							});
							$("#kejian_path_edit").val(kejian.path);
							$("#kejian_path_edit").validatebox({
								required : true,
								missingMessage : "请输入文件路径",
							});
							$("#kejian_addTime_edit").val(kejian.addTime);
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
