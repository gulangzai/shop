<!DOCTYPE html>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%@ taglib uri="/tld/base.tld" prefix="app"%>

<title><fmt:message key="ui.title" /></title>
<style type="text/css">
/**设置页面 布局 */
.page-content {
    background-color: #fff;
    position: relative;
    margin: 0;
    padding:3px 0px 0px 3px;
}

</style>
</head>
<body class="no-skin">
		<div class="main-container rightBox_Content" id="main-container">
				<div class="page-content fxgl" id="inside">
					<div class="col-sm-12 " >
						<form class="form-inline"  id="queryForm" width="100%">
							<input id="PROJECT_UID" type="hidden" fieldname="r.PROJECT_UID" operation="=" fieldtype="text"/>	
							<div class="rightBox_Content_QueryToAdd">
								<input type="text" placeholder="角色名称" name="ROLE_NAME" fieldname="ROLE_NAME" operation="like" logic="and">

								<span id="search"  class="dark"><img src="${pageContext.request.contextPath }/assets/img/search_icon2.png" alt="">查询</span>
	                            <span class='addBtn' id="new" type="button"><b>+</b><s>添 加</s></span>
							</div>
						</form>

		
						<table  sortname="ROLE_UID" multiselect=false  rownum="50" sortorder="desc"  class="auto_startgrid"  id="grid_table" 
									action="${ctx}/roleController?queryRole" >
							<tr>
								<th formatter="jqgridactions"   align="center" width="5">操作</th>
								<th name="ROLE_NAME" align="left" width="15" >角色名称</th>
								<th name="DESCRIPTION" align="left" width="15" >汉字描述</th>
								<th name="CREATED_DATE"  align="center" width="10">录入时间</th>
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

<%@ include file="/jsp/framework/common/basic_scripts.jsp"%>
	<script
		src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery-form.js"></script>		
		
<script type="text/javascript">

var scripts =[null];
ace.load_ajax_scripts(scripts, function() {
	$("#PROJECT_UID").val($("#project_uid").val());
	init();
	gridwidth = $("#inside").width();
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
							$("#inside").width());
				});
		$(window).triggerHandler('resize.jqGrid');
});

function init(){
	
	$('#search').click(function() {
		jQuery("#grid_table").jqGrid().trigger("reloadGrid");
	});
	
	$("#Btnclean").click(function(){ 
		 $("#queryForm").resetForm();
	     $('#search').click();
   }); 
	
	
	$('#new').click(function() {
		$('#new').attr("data-target","jldwUser-input");
		$('#jldwUser-input').removeData("bs.modal");
		$("#jldwUser-input").empty();
		$('#jldwUser-input').modal({
			backdrop: 'static'
		});
	
		$.get("${ctx}/jsp/framework/system/role/role-add.jsp?ryid=",function(data) {
			$("#jldwUser-input").empty();
			$("#jldwUser-input").html("");
			$("#jldwUser-input").html(data);
		});
	});

}


function jqgridactions(cellvalue, opts, rowObject){
	var role_uid = rowObject.PROJECT_ROLE_UID;
	var name = rowObject.ROLE_NAME;
	//var usey = rowObject.USE_Y;
	var showHtml ="<div class='hidden-sm hidden-xs action-buttons'>";			        	
		//showHtml +="<a class=\"blue\" title=\"查看\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		//showHtml +=	" onclick=\"eidtRy('"+ryid+"');\">";
		//showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
		//showHtml +="</a> &nbsp;";
	        	
		showHtml +="<a class=\"blue\" title=\"授予人员角色\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"awardRole('"+role_uid+"','"+name+"');\">";
		showHtml +="<span class=\"ace-icon fa fa-users bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
		
		showHtml +="<a class=\"blue\" title=\"权限配置\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"awardMenu('"+role_uid+"');\">";
		showHtml +="<span class=\"ace-icon fa fa-cogs bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
		
		//showHtml +="<a class=\"red\" title=\"删除角色\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		//showHtml +=	" onclick=\"DeleteRole('"+role_uid+"');\">";
		//showHtml +="<span class=\"glyphicon  glyphicon-trash bigger-110\"></i>";
		//showHtml +="</a> &nbsp;";
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

	$.get("${ctx}/jsp/framework/system/role/role-add.jsp?ryid="+ryid,function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});
}

//授予角色
function awardRole(role_uid,name){
	$('#new').attr("data-target","jldwUser-input");
	$('#jldwUser-input').removeData("bs.modal");
	$("#jldwUser-input").empty();
	$('#jldwUser-input').modal({
		backdrop: 'static'
	});
	
	var project_uid = $("#project_uid").val();

	$.get("${ctx}/jsp/framework/system/role/awardPerson.jsp?role_uid="+role_uid+"&project_uid="+project_uid,function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});
	
}

//权限配置
function awardMenu(role_uid){
	$('#new').attr("data-target","jldwUser-input");
	$('#jldwUser-input').removeData("bs.modal");
	$("#jldwUser-input").empty();
	$('#jldwUser-input').modal({
		backdrop: 'static'
	});

	$.get("${ctx}/jsp/framework/system/role/showMenu.jsp?uid="+role_uid+"&type=role",function(data) {
		$("#jldwUser-input").empty();
		$("#jldwUser-input").html("");
		$("#jldwUser-input").html(data);
	});	
}

function DeleteRole(role_uid){
	bootbox.confirm("确认删除吗？", function(result) {
		if(result){
			$.ajax({
				url : "${pageContext.request.contextPath }/roleController?delete",
				cache : false,
				async :	false,
				data : {"role_uid":role_uid},
				dataType : "json",  
				type : 'post',
				success : function(response) {
					if(response.success){
						xAlert("信息提示","删除成功！");
						jQuery("#grid_table").jqGrid().trigger("reloadGrid");
					}else{
						xAlert("信息提示","更新失败，请联系管理员！");
					}
				}
			});
			
		}else{
			return;
		}
	});	
}

function formatSTATUS(cellvalue, opts, rowObject){
	if(rowObject.ENABLED=="1"){
		return "有效";
	}else if(rowObject.ENABLED=="0"){
		return "无效";
	}
}


</script>
</body>
</html>