var homeworkTask_manage_tool = null; 
$(function () { 
	initHomeworkTaskManageTool(); //建立HomeworkTask管理对象
	homeworkTask_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#homeworkTask_manage").datagrid({
		url : 'HomeworkTask/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "homeworkId",
		sortOrder : "desc",
		toolbar : "#homeworkTask_manage_tool",
		columns : [[
			{
				field : "homeworkId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "teacherObj",
				title : "老师",
				width : 140,
			},
			{
				field : "title",
				title : "作业标题",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#homeworkTaskEditDiv").dialog({
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
				if ($("#homeworkTaskEditForm").form("validate")) {
					//验证表单 
					if(!$("#homeworkTaskEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#homeworkTaskEditForm").form({
						    url:"HomeworkTask/" + $("#homeworkTask_homeworkId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#homeworkTaskEditForm").form("validate"))  {
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
			                        $("#homeworkTaskEditDiv").dialog("close");
			                        homeworkTask_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#homeworkTaskEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#homeworkTaskEditDiv").dialog("close");
				$("#homeworkTaskEditForm").form("reset"); 
			},
		}],
	});
});

function initHomeworkTaskManageTool() {
	homeworkTask_manage_tool = {
		init: function() {
			$.ajax({
				url : "Teacher/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#teacherObj_id_query").combobox({ 
					    valueField:"id",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{id:0,name:"不限制"});
					$("#teacherObj_id_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#homeworkTask_manage").datagrid("reload");
		},
		redo : function () {
			$("#homeworkTask_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#homeworkTask_manage").datagrid("options").queryParams;
			queryParams["teacherObj.id"] = $("#teacherObj_id_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			$("#homeworkTask_manage").datagrid("options").queryParams=queryParams; 
			$("#homeworkTask_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#homeworkTaskQueryForm").form({
			    url:"HomeworkTask/OutToExcel",
			});
			//提交表单
			$("#homeworkTaskQueryForm").submit();
		},
		remove : function () {
			var rows = $("#homeworkTask_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var homeworkIds = [];
						for (var i = 0; i < rows.length; i ++) {
							homeworkIds.push(rows[i].homeworkId);
						}
						$.ajax({
							type : "POST",
							url : "HomeworkTask/deletes",
							data : {
								homeworkIds : homeworkIds.join(","),
							},
							beforeSend : function () {
								$("#homeworkTask_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#homeworkTask_manage").datagrid("loaded");
									$("#homeworkTask_manage").datagrid("load");
									$("#homeworkTask_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#homeworkTask_manage").datagrid("loaded");
									$("#homeworkTask_manage").datagrid("load");
									$("#homeworkTask_manage").datagrid("unselectAll");
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
			var rows = $("#homeworkTask_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "HomeworkTask/" + rows[0].homeworkId +  "/update",
					type : "get",
					data : {
						//homeworkId : rows[0].homeworkId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (homeworkTask, response, status) {
						$.messager.progress("close");
						if (homeworkTask) { 
							$("#homeworkTaskEditDiv").dialog("open");
							$("#homeworkTask_homeworkId_edit").val(homeworkTask.homeworkId);
							$("#homeworkTask_homeworkId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#homeworkTask_teacherObj_id_edit").combobox({
								url:"Teacher/listAll",
							    valueField:"id",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#homeworkTask_teacherObj_id_edit").combobox("select", homeworkTask.teacherObjPri);
									//var data = $("#homeworkTask_teacherObj_id_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#homeworkTask_teacherObj_id_edit").combobox("select", data[0].id);
						            //}
								}
							});
							$("#homeworkTask_title_edit").val(homeworkTask.title);
							$("#homeworkTask_title_edit").validatebox({
								required : true,
								missingMessage : "请输入作业标题",
							});
							$("#homeworkTask_content_edit").val(homeworkTask.content);
							$("#homeworkTask_content_edit").validatebox({
								required : true,
								missingMessage : "请输入作业内容",
							});
							$("#homeworkTask_addTime_edit").val(homeworkTask.addTime);
							$("#homeworkTask_addTime_edit").validatebox({
								required : true,
								missingMessage : "请输入发布时间",
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
