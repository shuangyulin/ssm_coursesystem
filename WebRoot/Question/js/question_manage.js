var question_manage_tool = null; 
$(function () { 
	initQuestionManageTool(); //建立Question管理对象
	question_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#question_manage").datagrid({
		url : 'Question/list',
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
		toolbar : "#question_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "teacherId",
				title : "提问的老师",
				width : 140,
			},
			{
				field : "questioner",
				title : "提问者",
				width : 140,
			},
			{
				field : "content",
				title : "提问内容",
				width : 140,
			},
			{
				field : "reply",
				title : "回复内容",
				width : 140,
			},
			{
				field : "addTime",
				title : "提问时间",
				width : 140,
			},
		]],
	});

	$("#questionEditDiv").dialog({
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
				if ($("#questionEditForm").form("validate")) {
					//验证表单 
					if(!$("#questionEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#questionEditForm").form({
						    url:"Question/" + $("#question_id_edit").val() + "/update",
						    onSubmit: function(){
								if($("#questionEditForm").form("validate"))  {
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
			                        $("#questionEditDiv").dialog("close");
			                        question_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#questionEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#questionEditDiv").dialog("close");
				$("#questionEditForm").form("reset"); 
			},
		}],
	});
});

function initQuestionManageTool() {
	question_manage_tool = {
		init: function() {
			$.ajax({
				url : "Teacher/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#teacherId_id_query").combobox({ 
					    valueField:"id",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{id:0,name:"不限制"});
					$("#teacherId_id_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#question_manage").datagrid("reload");
		},
		redo : function () {
			$("#question_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#question_manage").datagrid("options").queryParams;
			queryParams["teacherId.id"] = $("#teacherId_id_query").combobox("getValue");
			queryParams["questioner"] = $("#questioner").val();
			$("#question_manage").datagrid("options").queryParams=queryParams; 
			$("#question_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#questionQueryForm").form({
			    url:"Question/OutToExcel",
			});
			//提交表单
			$("#questionQueryForm").submit();
		},
		remove : function () {
			var rows = $("#question_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "Question/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#question_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#question_manage").datagrid("loaded");
									$("#question_manage").datagrid("load");
									$("#question_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#question_manage").datagrid("loaded");
									$("#question_manage").datagrid("load");
									$("#question_manage").datagrid("unselectAll");
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
			var rows = $("#question_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Question/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (question, response, status) {
						$.messager.progress("close");
						if (question) { 
							$("#questionEditDiv").dialog("open");
							$("#question_id_edit").val(question.id);
							$("#question_id_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#question_teacherId_id_edit").combobox({
								url:"Teacher/listAll",
							    valueField:"id",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#question_teacherId_id_edit").combobox("select", question.teacherIdPri);
									//var data = $("#question_teacherId_id_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#question_teacherId_id_edit").combobox("select", data[0].id);
						            //}
								}
							});
							$("#question_questioner_edit").val(question.questioner);
							$("#question_questioner_edit").validatebox({
								required : true,
								missingMessage : "请输入提问者",
							});
							$("#question_content_edit").val(question.content);
							$("#question_content_edit").validatebox({
								required : true,
								missingMessage : "请输入提问内容",
							});
							$("#question_reply_edit").val(question.reply);
							$("#question_reply_edit").validatebox({
								required : true,
								missingMessage : "请输入回复内容",
							});
							$("#question_addTime_edit").val(question.addTime);
							$("#question_addTime_edit").validatebox({
								required : true,
								missingMessage : "请输入提问时间",
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
