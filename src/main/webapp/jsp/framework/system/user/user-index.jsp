<!DOCTYPE html>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%@ taglib uri="/tld/base.tld" prefix="app"%>

<title><fmt:message key="ui.title" /></title>
</head>
<style>
/**设置页面 布局 */
.page-content {
    background-color: #fff;
    position: relative;
    margin: 0;
    padding:3px 3px 3px 3px;
}

.col-xs-6, .col-sm-10 {
    position: relative;
    min-height: 1px;
    padding-left: 2px;
    padding-right: 3px;
} 
</style>
<body class="no-skin">

		<div class="main-container rightBox_Content" id="main-container">
				<div class="page-content" id="inside">
					<div class="col-sm-12 fxgl" id="inside">
						<form class="form-inline"  id="queryForm" width="100%">
						<input id="PROJECT_UID" type="hidden" fieldname="u.PROJECT_UID" operation="=" fieldtype="text"/>
							<div class="rightBox_Content_QueryToAdd">
								<input type="text" placeholder="姓名" name="USER_NAME" fieldname="USER_NAME" operation="like" logic="and">
								<input type="text" placeholder="登录名" name="LOGON_NAME" fieldname="LOGON_NAME" operation="like" logic="and">
								<span id="search"  class="dark"><img src="${pageContext.request.contextPath }/assets/img/search_icon2.png" alt="">查询</span>
								<span class='addBtn' id="new" type="button"><b>+</b><s>添 加</s></span>
							</div>
								
						</form>
		
						<table  sortname="u.PROJECT_USER_UID" multiselect=false  rownum="50" sortorder="desc"  class="auto_startgrid"  id="grid_table" 
									action="${ctx}/project/buProjectUserController?queryList" >
							<tr>
								<th formatter="jqgridactions"  width="8" align="center" >操作</th>
								<th name="USER_NAME"  width="15" >姓名</th>
								<th name="LOGON_NAME"  width="5" align="center">登录名</th>
								<th name="ENABLED" width="5" align="center" formatter="formatSTATUS">用户状态</th>
								<th name="CREATED_DATE" width="5" align="center" >创建时间</th>
							 </tr>
						</table>
						<script type="text/javascript">
							var $path_base = "/";//this will be used in gritter alerts containing images
						</script>
							<!-- PAGE CONTENT ENDS -->
						</div>
					
				</div>
			</div>
				<div id="jldwUser-input" class="modal"></div>
				<div id="jldwUserAuth-input" class="modal"></div>
                <div id="sys_user-input" class="modal"></div>
<%@ include file="/jsp/framework/common/basic_scripts.jsp"%>
	<script
		src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script>
		
<script type="text/javascript">

var scripts =[null];
var controllernameUrl="${pageContext.request.contextPath}/";
controllernameUrl = controllernameUrl+"sys/SysUserController";
ace.load_ajax_scripts(scripts, function() {
	$("#PROJECT_UID").val($("#project_uid").val());
	init();
	var gridwidth=$(".page-content").width();
	
	//初始化jagrid大小 rownum..
    setHeight = $(window).height()-220;
    var rownum=10;//默认行数
    var rowHeight=50;//默认高度
	if(navigator.userAgent.indexOf("Firefox") > -1){
	   setHeight = setHeight+50;
	}
	$("#grid_table").attr('jqgridheight',setHeight);
	if( setHeight % rowHeight == '0'){
		rownum = setHeight / rowHeight;
	}else{
		rownum = ( setHeight - ( setHeight % rowHeight ) ) / rowHeight ;
	}
	$("#grid_table").attr('rownum',rownum);
	JqgridManage.initJqgrid(grid_table,queryForm,gridwidth);

	//改变浏览器大小自适应
	$(window).on(
			'resize.jqGrid',
			function() {
				$("#grid_table").jqGrid(    //jqGridtable 自适应width
						'setGridWidth',
						$(".page-content").width());
			});
	$(window).triggerHandler('resize.jqGrid');
});

function init(){
	
	$('#search').click(function() {
		jQuery("#grid_table").jqGrid().trigger("reloadGrid");
	});

	$("#Btnclean").click(function(){
		 $("#queryForm").clearFormResult();
	     $('#search').click();
	});
	
	
	$('#new').click(function() {
		$('#new').attr("data-target","jldwUser-input");
		$('#jldwUser-input').removeData("bs.modal");
		$("#jldwUser-input").empty();
		$('#jldwUser-input').modal({
			backdrop: 'static'
		});
	
		$.get("${ctx}/jsp/framework/system/user/sys_user_add.jsp",function(data) {
			$("#jldwUser-input").empty();
			$("#jldwUser-input").html("");
			$("#jldwUser-input").html(data);
		});
	});
    $('#yiyou_user').click(function() {
		$('#yiyou_user').attr("data-target","jldwUser-input");
		$('#jldwUser-input').removeData("bs.modal");
		$("#jldwUser-input").empty();
		$('#jldwUser-input').modal({
			backdrop: 'static'
		});
	
		$.get("${ctx}/jsp/framework/system/user/yiyou_user_add.jsp?project="+$("#project_uid").val(),function(data) {
			$("#jldwUser-input").empty();
			$("#jldwUser-input").html("");
			$("#jldwUser-input").html(data);
		});
	});
    
}

function _reload(){
	jQuery("#grid_table").jqGrid().trigger("reloadGrid");
}

function jqgridactions(cellvalue, opts, rowObject){
    var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var USER_UID = rowObject.USER_UID;
	var PROJECT_USER_UID = rowObject.PROJECT_USER_UID;
	var enabled = rowObject.ENABLED;
	
 
	var ryid = rowObject.PROJECT_USER_UID;
	var account = rowObject.LOGON_NAME;
	
	//var usey = rowObject.USE_Y;
	var showHtml ="<div class='hidden-sm hidden-xs action-buttons'>";	
	
		//showHtml +="<a class=\"blue\" title=\"查看\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		//showHtml +=	" onclick=\"eidtRy('"+ryid+"');\">";
		//showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
		//showHtml +="</a> &nbsp;";
	        	
		showHtml +="<a class=\"blue\" title=\"授予角色\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"awardRole('"+ryid+"','"+account+"');\">";
		showHtml +="<span class=\"ace-icon fa fa-user bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
		
		//showHtml +="<a class=\"blue\" title=\"权限配置\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		//showHtml +=	" onclick=\"awardMenu('"+ryid+"');\">";
		//showHtml +="<span class=\"ace-icon fa fa-cogs bigger-110\"></i>";
		//showHtml +="</a> &nbsp;";
		 
	 //if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"11010202")){
		showHtml +="<a class=\"blue\" title=\"修改用户信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"eidtLlog('"+USER_UID+"','"+PROJECT_UID+"');\">";
		showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
	// }
	//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"12090003")){
		showHtml +="<a class=\"blue\" title=\"重置密码\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"resetData('"+USER_UID+"','"+PROJECT_USER_UID+"');\">";
		showHtml +="<span class=\"glyphicon colorshow1 glyphicon-cog bigger-110\"></i>";
		showHtml +="</a>&nbsp;";
		
		//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"11010203")){	
			if(enabled==1){
				showHtml +="<a class=\"blue\" title=\"禁用\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
				showHtml +=	" onclick=\"forbiddenData('"+USER_UID+"','"+PROJECT_USER_UID+"');\">";
				showHtml +="<span class=\"glyphicon colorshow1  glyphicon-off bigger-110\"></i>";
				showHtml +="</a>&nbsp;";
			} 
		//}
		
		if(enabled==0){
			showHtml +="<a class=\"blue\" title=\"启用\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
			showHtml +=	" onclick=\"openData('"+USER_UID+"','"+PROJECT_USER_UID+"');\">";
			showHtml +="<span class=\"glyphicon colorshow1  glyphicon-time bigger-110\"></i>";
			showHtml +="</a>&nbsp;";
		} 
		
		showHtml +="</div>"
		
	return 	showHtml;	        	
}

function eidtRy(ryid){
	
	$('#new').attr("data-target","jldwUser-input");
	$('#jldwUser-input').removeData("bs.modal");
	$("#jldwUser-input").empty();
	$('#jldwUser-input').modal({
		backdrop: 'static'
	});

	$.get("${ctx}/jsp/framework/system/user/user-edit.jsp?ryid="+ryid,function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});
}

//授予角色
function awardRole(ryid,account){
	$('#new').attr("data-target","jldwUser-input");
	$('#jldwUser-input').removeData("bs.modal");
	$("#jldwUser-input").empty();
	$('#jldwUser-input').modal({
		backdrop: 'static'
	});

	$.get("${ctx}/jsp/framework/system/user/awardRole.jsp?ryid="+ryid+"&project_uid="+$("#project_uid").val(),function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});
	
}

//权限配置
function awardMenu(ryid){
	$('#new').attr("data-target","jldwUser-input");
	$('#jldwUser-input').removeData("bs.modal");
	$("#jldwUser-input").empty();
	$('#jldwUser-input').modal({
		backdrop: 'static'
	});

	$.get("${ctx}/jsp/framework/system/role/showMenu.jsp?ryid="+ryid+"&type=user",function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});	
}

function formatSTATUS(cellvalue, opts, rowObject){
	if(rowObject.ENABLED=="1"){
		return "有效";
	}else if(rowObject.ENABLED=="0"){
		return "无效";
	}
}


function doUpdate(cellvalue, opts, rowObject){
	var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var USER_UID = rowObject.USER_UID;
	var PROJECT_USER_UID = rowObject.PROJECT_USER_UID;
	var showHtml ="<div class='hidden-sm hidden-xs action-buttons' style='padding-top:15px;'>";	
   
/*	showHtml +="<a class=\"blue\" title=\"查看现场信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
	showHtml +="onclick=\"showFileList('"+USER_UID+"','"+PROJECT_UID+"');\">" ;
	showHtml +="<span class=\"glyphicon glyphicon-file bigger-110\"></span>" ;
	showHtml +="</a>&nbsp;"; 	*/
	
	//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"12090002")){
		showHtml +="<a class=\"blue\" title=\"修改用户信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"eidtLlog('"+USER_UID+"','"+PROJECT_UID+"');\">";
		showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
	//}
	//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"12090003")){
		showHtml +="<a class=\"red\" title=\"重置密码\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"resetData('"+USER_UID+"','"+PROJECT_USER_UID+"');\">";
		showHtml +="<span class=\"glyphicon colorshow1 glyphicon-cog bigger-110\"></i>";
		showHtml +="</a>&nbsp;";
	//}  
	return 	showHtml;
}

function eidtLlog(USER_UID,project_uid,yanshou_type){
	$('#newAdd').attr("data-target","sys_user-input");
	$('#sys_user-input').removeData("bs.modal");
	$("#sys_user-input").empty();
	$('#sys_user-input').modal({
		backdrop: 'static'
	});
	
	$.get("${ctx}/jsp/framework/system/user/sys_user_edit.jsp?USER_UID="+USER_UID+"&PROJECT_UID="+project_uid,function(data) {
		$("#sys_user-input").empty();
		$("#sys_user-input").html("");
		$("#sys_user-input").html(data);
	});
}

function resetData(USER_UID,PROJECT_USER_UID){
	bootbox.confirm("确认重置密码为[123456]吗？", function(result) {
	
	if (result) {
	 var data="{'response':{'data':[{'UID_UID':'"+USER_UID+"','PROJECT_USER_UID':'"+PROJECT_USER_UID+"'}]}}";						
		$.ajax({
			url :controllernameUrl+'?resetUserPassword',
			data : {"msg":data},
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
					xAlert("信息提示","密码重置成功",1);
				_reload(); 
		      }
		}); 	
	} else {
		return;
	}
});
}

function forbiddenData(USER_UID,PROJECT_USER_UID){
	 
	bootbox.confirm("确认禁用该用户吗？", function(result) {
	
	if (result) {
	 var data="{'response':{'data':[{'UID_UID':'"+USER_UID+"','PROJECT_USER_UID':'"+PROJECT_USER_UID+"','ENABLED':'0'}]}}";						
		$.ajax({
			url :controllernameUrl+'?forbiddenUser',
			data : {"msg":data},
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
					xAlert("信息提示","用户禁用成功",1);
				_reload(); 
		      }
		}); 	
	} else {
		return;
	}
   });
}


function openData(USER_UID,PROJECT_USER_UID){
	 
	bootbox.confirm("确认启用该用户吗？", function(result) {
	
	if (result) {
	 var data="{'response':{'data':[{'UID_UID':'"+USER_UID+"','PROJECT_USER_UID':'"+PROJECT_USER_UID+"','ENABLED':'1'}]}}";						
		$.ajax({
			url :controllernameUrl+'?forbiddenUser',
			data : {"msg":data},
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
					xAlert("信息提示","用户启用成功",1);
				_reload(); 
		      }
		}); 	
	} else {
		return;
	}
   });
}



</script>
</body>
</html>