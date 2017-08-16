<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%
 String USERS_UID = request.getParameter("ryid");
%>
<!-- Modal -->
<div class="modal-dialog width-70 height-auto">
  <div class="modal-content" >
   		<div class="widget-header widget-header-large">
   		<div class="widget-toolbar">
			<a href="#" data-action="close" data-dismiss="modal">
				<i class="ace-icon fa fa-times"></i>
				</a>
		</div>
    	<h3 id="myModalLabel" class="blue bigger">用户信息修改</h3>
  </div>
  <div class="modal-body">

 	  <form method="post" role="form" class="form-horizontal"  id="executeFrm" >      	
      		<INPUT type="hidden"  kind="text" id="USERS_UID"  fieldname="USERS_UID" value="<%=USERS_UID %>" operation="="/>
	  		<div class="form-group" >
		  		<label class="col-sm-2 control-label no-padding-right" for="USER_CODE">
					登录名：<span class="required-indicator">*</span>
				</label>
				<div class="col-sm-4">
					 <input datatype="n|s,*5-20"  nullmsg="请输入登录名！"type="text" name="LOGON_NAME" id="LOGON_NAME" fieldname="LOGON_NAME" class="col-xs-11 col-sm-11"  ajaxurl="${ctx}/xtgl/usersController?check&PERSON_UID=<%=USERS_UID %>"/>
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
					
				</div>
	  		<label class="col-sm-2 control-label no-padding-right" for="USER_NAME">
				用户姓名：<span class="required-indicator">*</span>
			</label>
				<div class="col-sm-4">
					 <input style="display:none;"><!-- for disable autocomplete on chrome -->
					 <input datatype="*"  nullmsg="请输入用户姓名！" errormsg=""  placeholder="请输入用户姓名" type="text" name="USER_NAME" id="USER_NAME" fieldname="USER_NAME" autocomplete="off" class="col-xs-11 col-sm-11" />
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
				</div>
			</div>
	  		<div class="form-group" >
	  		<label class="col-sm-2 control-label no-padding-right" for="MIMA">
				登录密码：<span class="required-indicator">*</span>
			</label>
			<div class="col-sm-4">
			   	 <input style="display:none;"><!-- for disable autocomplete on chrome -->
				 <input datatype="*6-100"  nullmsg="请输入登录密码！" errormsg=""  placeholder="请输入登录密码" type="text" name="MIMA" id="MIMA" fieldname="MIMA" class="col-xs-11 col-sm-11"  autocomplete="off" />
				 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
			</div>
	  		<label class="col-sm-2 control-label no-padding-right">
				用户状态：
			</label>
			<div class="col-sm-4">
				 <input  type="hidden" name="USE_Y" id="USE_Y" fieldname="USE_Y"/>
				 <input nullmsg="请输入登录密码！" errormsg=""  type="text"  id="USE_Y_VIEW"  class="col-xs-11 col-sm-11" readonly="readonly"/>
				 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
			</div>
			</div>	
			
			<input type="hidden" id="ORGTYPE" name="ORGTYPE" fieldname="ORGTYPE" />
	  		<div class="form-group" >
	  		<label class="col-sm-2 control-label no-padding-right">
				个人用户：<input id="person_radio" type="radio" name="usergroup"/>
			</label>
			
	  		<label class="col-sm-2 control-label no-padding-right">
				单位用户：<input id="company_radio" type="radio" name="usergroup"/>
			</label>						
			</div>	
			
			<div class="form-group" id="person-group">
				<label class="col-sm-2 control-label no-padding-right">
					人员名称
				</label>
				<div class="col-sm-9">
					<input type="hidden" id="person_uid"  fieldname="person_uid" name="person_uid" class="col-xs-10 col-sm-10" />
					<input type="text" id="person_name"  class="col-xs-10 col-sm-10" readonly="readonly"/>
					<i class="ace-icon glyphicon glyphicon-list bigger-110" onclick="selectBUMENREN();"></i>&nbsp;&nbsp;
					<i class="ace-icon glyphicon glyphicon-remove red bigger-110" onclick="doclear(this);"></i>
				</div>
			</div>
			
			<div class="form-group" id="company-group">
				<label class="col-sm-2 control-label no-padding-right">
					单位名称
				</label>
				<div class="col-sm-9">
					<input type="hidden" id="company_uid"  fieldname="company_uid" name="company_uid" class="col-xs-10 col-sm-10" />
					<input type="text" id="company_name"  class="col-xs-10 col-sm-10" readonly="readonly"/>
					<i class="ace-icon glyphicon glyphicon-list bigger-110" onclick="selectCompany();"></i>&nbsp;&nbsp;
					<i class="ace-icon glyphicon glyphicon-remove red bigger-110" onclick="doclear(this);"></i>
				</div>
			</div>
	  		
	  		<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">
					备注：&nbsp;
				</label>
				<div class="col-sm-10">
					<textarea style="width: 97%;"  rows="3" id="DESCRIPTION" fieldname="DESCRIPTION"></textarea>
				</div>
			</div>
	  		
	  		<div class="form-group" >
	  		<label class="col-sm-2 control-label no-padding-right">
				更新人：
			</label>
			<div class="col-sm-4">
				 <input type="text" name="UPDATED_BY" id="UPDATED_BY" fieldname="UPDATED_BY" class="col-xs-11 col-sm-11" readonly="readonly" />
				 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
			</div>
	  		<label class="col-sm-2 control-label no-padding-right">
				更新时间：
			</label>
			<div class="col-sm-4">
				 <input type="text" name="UPDATED_DATE" id="UPDATED_DATE" fieldname="UPDATED_DATE"  class="col-xs-11 col-sm-11" readonly="readonly"/>
				 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
			</div>
			</div>	
     </form>
     
	</div>

  <div class="modal_footer">
    <button class="btn btn-success btn-sm" id="addsaveUserInfo">保存</button>
    <button type="button" class="btn btn-danger btn-sm " id="btnChange11">禁用</button>
    <button type="button" class="btn btn-success btn-sm " id="btnChange22">启用</button>
    <button class="btn btn-danger btn-sm pull-right" id="btnClose" data-dismiss="modal" aria-hidden="true">关闭</button>
  </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/combineQuery.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/bootstrap-validation.js"> </script>
<script type="text/javascript">
var USERS_UID = "<%=USERS_UID%>";
var validform;
//点击保存按钮
$(function() {
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	init();
	
	$('#btnChange11').click(function(){
		$("#USE_Y_VIEW").val("不可用");
		$("#USE_Y").val("N");
		$("#btnChange11").hide();
		$("#btnChange22").show();
	});
	
	$('#btnChange22').click(function(){
		$("#USE_Y_VIEW").val("可用");
		$("#USE_Y").val("Y");
		$("#btnChange11").show();
		$("#btnChange22").hide();
	});
	
	validform=FormValid.validbyformid(executeFrm);
	$("#addsaveUserInfo").click(function() {
	  if(validform.check()){
		if($("#executeFrm").validationButton()) {
			updateUser();		
		 }
	   }else {
		   return;
	   }
	});
	
	 
	
	$("#person_radio").change(function(){	
		if($("#person_radio").is(":checked")){
			$("#ORGTYPE").val("Y");
			$("#person-group").show();
			$("#company-group").hide();
		}		
	}); 
	
	$("#company_radio").change(function(){	
		if($("#company_radio").is(":checked")){
			$("#ORGTYPE").val("N");
			$("#person-group").hide();
			$("#company-group").show();
		}		
	}); 
	
});

function init(){
	setFormValues();
}

function setFormValues(){
	var data = combineQuery.getQueryCombineData(queryFormById,null,null);
	var data1 = {
		msg : data
	};
	$.ajax({
		url : '${ctx}/xtgl/usersController?detail',
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			var resultobj = defaultJson.dealResultJson(response.msg);
			$("#executeFrm").setFormValues(resultobj);	
			
			if(resultobj.USE_Y=="Y"){
				$("#btnChange22").hide();
				$("#USE_Y_VIEW").val("可用");
			}else {
				$("#btnChange11").hide();
				$("#USE_Y_VIEW").val("不可用");
			}
			
			var NODE_TYPE = resultobj.NODE_TYPE;
			var ORG_NAME = resultobj.ORG_NAME;
			var ORGANIZE_UID = resultobj.ORGANIZE_UID;
			if(NODE_TYPE=="U"){
				$("#ORGTYPE").val("Y");
				$("#person_uid").val(ORGANIZE_UID);
				$("#person_name").val(ORG_NAME);
				document.getElementById("person_radio").checked=true;
				$("#company-group").hide();
			}else if(NODE_TYPE=="C"){
				$("#ORGTYPE").val("N");
				$("#company_uid").val(ORGANIZE_UID);
				$("#company_name").val(ORG_NAME);
				document.getElementById("company_radio").checked=true; 
				$("#person-group").hide();
			}
		}
	});
}

function updateUser(){
	//生成json串
	var data = Form2Json.formToJSON(executeFrm);
	//组成保存json串格式
	var data1 = defaultJson.packSaveJson(data);
	$.ajax({
		url :'${ctx}/xtgl/usersController?update',
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
				xAlert("信息提示","更新成功",1);
				var a =window.parent;
				a.location.reload();
				window.close();			
	      }
	});
	
}

function selectCompany(){
	var cuid = $("#company_uid").val();
	window.open("${pageContext.request.contextPath }/jsp/business/xtgl/company-select.jsp?cuid="+cuid);
}

function selectBUMENREN(){
	var ids = $("#person_uid").val();
	window.open("${pageContext.request.contextPath }/jsp/business/xtgl/person-select.jsp?ids="+ids);	
}

function doclear(icon){
	var iconPre = icon.previousElementSibling.previousElementSibling;
	var iconPrePre = icon.previousElementSibling.previousElementSibling.previousElementSibling;
	$(iconPre).val("");
	$(iconPrePre).val("");
}

</script>
<form method="post" id="queryFormById"  >
   <table class="B-table" width="100%">
   <!--可以再此处加入hidden域作为过滤条件 -->
   	<TR  style="display:none;">
     	<TD class="right-border bottom-border">
      	<INPUT type="text"  kind="text" id="USERS_UID"  fieldname="USERS_UID" value="<%=USERS_UID %>" operation="="/>
      	</TD>
		<TD class="right-border bottom-border">
		</TD>
     </TR>
   </table>
</form>		