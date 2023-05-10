var chapter_manage_tool = null; 
$(function () { 
	initChapterManageTool(); //建立Chapter管理对象
	chapter_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#chapter_manage").datagrid({
		url : 'Chapter/list',
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
		toolbar : "#chapter_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "title",
				title : "章标题",
				width : 140,
			},
			{
				field : "addTime",
				title : "添加时间",
				width : 140,
			},
		]],
	});

	$("#chapterEditDiv").dialog({
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
				if ($("#chapterEditForm").form("validate")) {
					//验证表单 
					if(!$("#chapterEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#chapterEditForm").form({
						    url:"Chapter/" + $("#chapter_id_edit").val() + "/update",
						    onSubmit: function(){
								if($("#chapterEditForm").form("validate"))  {
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
			                        $("#chapterEditDiv").dialog("close");
			                        chapter_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#chapterEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#chapterEditDiv").dialog("close");
				$("#chapterEditForm").form("reset"); 
			},
		}],
	});
});

function initChapterManageTool() {
	chapter_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#chapter_manage").datagrid("reload");
		},
		redo : function () {
			$("#chapter_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#chapter_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#chapterQueryForm").form({
			    url:"Chapter/OutToExcel",
			});
			//提交表单
			$("#chapterQueryForm").submit();
		},
		remove : function () {
			var rows = $("#chapter_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "Chapter/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#chapter_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#chapter_manage").datagrid("loaded");
									$("#chapter_manage").datagrid("load");
									$("#chapter_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#chapter_manage").datagrid("loaded");
									$("#chapter_manage").datagrid("load");
									$("#chapter_manage").datagrid("unselectAll");
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
			var rows = $("#chapter_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Chapter/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (chapter, response, status) {
						$.messager.progress("close");
						if (chapter) { 
							$("#chapterEditDiv").dialog("open");
							$("#chapter_id_edit").val(chapter.id);
							$("#chapter_id_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#chapter_title_edit").val(chapter.title);
							$("#chapter_title_edit").validatebox({
								required : true,
								missingMessage : "请输入章标题",
							});
							$("#chapter_addTime_edit").val(chapter.addTime);
							$("#chapter_addTime_edit").validatebox({
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
