var homeworkUpload_manage_tool = null; 
$(function () { 
	initHomeworkUploadManageTool(); //建立HomeworkUpload管理对象
	homeworkUpload_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#homeworkUpload_manage").datagrid({
		url : 'HomeworkUpload/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "uploadId",
		sortOrder : "desc",
		toolbar : "#homeworkUpload_manage_tool",
		columns : [[
			{
				field : "uploadId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "homeworkTaskObj",
				title : "作业标题",
				width : 140,
			},
			{
				field : "studentObj",
				title : "提交的学生",
				width : 140,
			},
			{
				field : "homeworkFile",
				title : "作业文件",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "uploadTime",
				title : "提交时间",
				width : 140,
			},
			{
				field : "resultFile",
				title : "批改结果文件",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "pigaiTime",
				title : "批改时间",
				width : 140,
			},
			{
				field : "pigaiFlag",
				title : "是否批改",
				width : 70,
			},
			{
				field : "pingyu",
				title : "评语",
				width : 140,
			},
		]],
	});

	$("#homeworkUploadEditDiv").dialog({
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
				if ($("#homeworkUploadEditForm").form("validate")) {
					//验证表单 
					if(!$("#homeworkUploadEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#homeworkUploadEditForm").form({
						    url:"HomeworkUpload/" + $("#homeworkUpload_uploadId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#homeworkUploadEditForm").form("validate"))  {
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
			                        $("#homeworkUploadEditDiv").dialog("close");
			                        homeworkUpload_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#homeworkUploadEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#homeworkUploadEditDiv").dialog("close");
				$("#homeworkUploadEditForm").form("reset"); 
			},
		}],
	});
});

function initHomeworkUploadManageTool() {
	homeworkUpload_manage_tool = {
		init: function() {
			$.ajax({
				url : "HomeworkTask/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#homeworkTaskObj_homeworkId_query").combobox({ 
					    valueField:"homeworkId",
					    textField:"title",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{homeworkId:0,title:"不限制"});
					$("#homeworkTaskObj_homeworkId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Student/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studentObj_studentNumber_query").combobox({ 
					    valueField:"studentNumber",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{studentNumber:"",name:"不限制"});
					$("#studentObj_studentNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#homeworkUpload_manage").datagrid("reload");
		},
		redo : function () {
			$("#homeworkUpload_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#homeworkUpload_manage").datagrid("options").queryParams;
			queryParams["homeworkTaskObj.homeworkId"] = $("#homeworkTaskObj_homeworkId_query").combobox("getValue");
			queryParams["studentObj.studentNumber"] = $("#studentObj_studentNumber_query").combobox("getValue");
			$("#homeworkUpload_manage").datagrid("options").queryParams=queryParams; 
			$("#homeworkUpload_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#homeworkUploadQueryForm").form({
			    url:"HomeworkUpload/OutToExcel",
			});
			//提交表单
			$("#homeworkUploadQueryForm").submit();
		},
		remove : function () {
			var rows = $("#homeworkUpload_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var uploadIds = [];
						for (var i = 0; i < rows.length; i ++) {
							uploadIds.push(rows[i].uploadId);
						}
						$.ajax({
							type : "POST",
							url : "HomeworkUpload/deletes",
							data : {
								uploadIds : uploadIds.join(","),
							},
							beforeSend : function () {
								$("#homeworkUpload_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#homeworkUpload_manage").datagrid("loaded");
									$("#homeworkUpload_manage").datagrid("load");
									$("#homeworkUpload_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#homeworkUpload_manage").datagrid("loaded");
									$("#homeworkUpload_manage").datagrid("load");
									$("#homeworkUpload_manage").datagrid("unselectAll");
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
			var rows = $("#homeworkUpload_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "HomeworkUpload/" + rows[0].uploadId +  "/update",
					type : "get",
					data : {
						//uploadId : rows[0].uploadId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (homeworkUpload, response, status) {
						$.messager.progress("close");
						if (homeworkUpload) { 
							$("#homeworkUploadEditDiv").dialog("open");
							$("#homeworkUpload_uploadId_edit").val(homeworkUpload.uploadId);
							$("#homeworkUpload_uploadId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox({
								url:"HomeworkTask/listAll",
							    valueField:"homeworkId",
							    textField:"title",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("select", homeworkUpload.homeworkTaskObjPri);
									//var data = $("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#homeworkUpload_homeworkTaskObj_homeworkId_edit").combobox("select", data[0].homeworkId);
						            //}
								}
							});
							$("#homeworkUpload_studentObj_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#homeworkUpload_studentObj_studentNumber_edit").combobox("select", homeworkUpload.studentObjPri);
									//var data = $("#homeworkUpload_studentObj_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#homeworkUpload_studentObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#homeworkUpload_homeworkFile").val(homeworkUpload.homeworkFile);
							$("#homeworkUpload_homeworkFileImg").attr("src", homeworkUpload.homeworkFile);
							$("#homeworkUpload_uploadTime_edit").val(homeworkUpload.uploadTime);
							$("#homeworkUpload_uploadTime_edit").validatebox({
								required : true,
								missingMessage : "请输入提交时间",
							});
							$("#homeworkUpload_resultFile").val(homeworkUpload.resultFile);
							$("#homeworkUpload_resultFileImg").attr("src", homeworkUpload.resultFile);
							$("#homeworkUpload_pigaiTime_edit").val(homeworkUpload.pigaiTime);
							$("#homeworkUpload_pigaiTime_edit").validatebox({
								required : true,
								missingMessage : "请输入批改时间",
							});
							$("#homeworkUpload_pigaiFlag_edit").val(homeworkUpload.pigaiFlag);
							$("#homeworkUpload_pigaiFlag_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入是否批改",
								invalidMessage : "是否批改输入不对",
							});
							$("#homeworkUpload_pingyu_edit").val(homeworkUpload.pingyu);
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
