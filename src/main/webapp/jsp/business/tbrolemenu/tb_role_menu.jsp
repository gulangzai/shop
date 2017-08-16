<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%> 
<%@ include file="/jsp/commons/edit.jspf"%> 
 <%
String rootFile = request.getScheme()+"://"+request.getServerName()+":8088/file";
String rootFileApp = request.getScheme()+"://"+request.getServerName()+":8088/app"; 
    String type = request.getParameter("type");
	String id = request.getParameter("uid");
 %>  
<link rel="stylesheet" href="${ctxStatic}/plugin/zTree/3.5/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctxStatic}/plugin/zTree/3.5/js/jquery.ztree.core-3.5.js"></script> 
<script type="text/javascript" src="${ctxStatic}/plugin/zTree/3.5/js/jquery.ztree.excheck-3.5.js"></script> 
<div class="container">
<div class="modal-dialog width-40  height-auto">
	<div class="modal-content">
		<div class="widget-header widget-header-small">
			<div class="widget-toolbar">
				<a href="#" data-action="close" data-dismiss="modal">
					<i class="ace-icon fa fa-times"></i>
				</a>
			</div>
			<h4 id="myModalLabel" class="blue bigger" style="margin-top: 5px;">菜单信息<span id="title_sp"></span></h4>
		</div>
		<div class="modal-body" style="overflow: scroll;overflow-x:hidden;">
		  <div class="zTreeDemoBackground left" style="height: 100%;margin-right:100px;">
		    <ul id="menuTree" class="ztree" style="height: 400px;width: 350px;">
		    	<img alt="请稍后，正在加载数据……" src="${pageContext.request.contextPath }/assets/sys_resources/plugins/zTree/css/zTreeStyle/img/loading.gif" />
		    </ul>
		  </div>


		</div>

		<div class="modal-footer">
			<button class="btn btn-success btn-sm" id="saveRoleInfo">保存</button>
			<button class="btn btn-danger btn-sm pull-right" id="btnClose" data-dismiss="modal" aria-hidden="true">关闭</button>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
var controllername= "${pageContext.request.contextPath}/tbmenu/tbMenuController";
var type = "role"; 
var F_ROLE_ID = "${pd.F_ROLE_ID}";
//设置角色权限
var setting = {
	check: {
		enable: true,
		chkStyle : "checkbox",
		chkboxType : {"Y":"ps","N":"s"}
	},
	async: {
		enable: true,
		url: controllername + "?loadAllMenu&type="+type+"&F_ROLE_ID="+F_ROLE_ID,
		autoParam: ["id"]
	},
	view: {
		dblClickExpand: true
	},
	data: {
		simpleData: {
			enable: true,
			idKey: "id",
			pIdKey: "parentId"
		}
	}
};

	
//点击保存按钮
$(function() {
	var saveUserInfoBtn = $("#saveRoleInfo");
	saveUserInfoBtn.click(function() {
		var zTree = $.fn.zTree.getZTreeObj("menuTree");
		// 获取输入框被勾选的节点集合
		var nodes = zTree.getCheckedNodes(true);
		//var val = "";
		var codes = "";
		//alert(nodes);
		for(var i = 0; i < nodes.length; i++) {
			//val += nodes[i].id + ",";
			codes += nodes[i].code +",";
		}

	
		if(type=="role"){
			var data = "{\"roleId\":\""+F_ROLE_ID+"\",\"codes\":\""+codes+"\"}";
			awardMenuToRole(F_ROLE_ID,codes);
			//组成保存json串格式frmPost9
			//var data1 = defaultJson.packSaveJson(data);
			//保存角色分配的权限
			//defaultJson.doInsertJson(controllername + "?awardMenuToRole", data1);
		}else if(type=="user"){
			var data = "{\"userId\":\""+id+"\",\"project_uid\":\""+$("#project_uid").val()+"\",\"codes\":\""+codes+"\"}";
			//组成保存json串格式frmPost9
			var data1 = defaultJson.packSaveJson(data);
			//保存用户分配的权限
			defaultJson.doInsertJson(controllername+"?awardMenuToUser", data1);
		}
		jQuery("#grid_table").jqGrid().trigger("reloadGrid");
		$('#btnClose').click();
	});
	
	$("#btnCancel").click(function(){
		parent.$(window).manhuaDialog.close();
	});
});

function awardMenuToRole(f_role_id,codes){
	$.ajax({
		url : ctx+"/tbmenu/tbMenuController?awardMenuToRole",
		data : {
          F_ROLE_ID:f_role_id,
          codes:codes
		},
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			 console.info(typeof response);
			 if(!response.iserror){
				xAlert("信息提示","保存成功",1);
				jQuery("#grid_table").jqGrid().trigger("reloadGrid");
				$('#btnClose').click();
			 } 
		}
	});  
}

$(document).ready(function() {
	$.fn.zTree.init($("#menuTree"),setting)
});
</script>