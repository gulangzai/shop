<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%
String ROLE_ID = request.getParameter("ryid");
%>
<!-- Modal -->
<div class="modal-dialog width-40 height-auto" style="min-width: 500px;">
  <div class="modal-content" >
   		<p class="pop_title">添加角色<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png' ></span></p>
  
	<div id="information"> 

 	  <form method="post" role="form" class="form-horizontal"  id="executeFrm" >      	
      	<input type="hidden" id="PROJECT_ROLE_UID" fieldname="PROJECT_ROLE_UID">
      	<input type="hidden" id="P_UID" fieldname="PROJECT_UID">
      	
      	 
      	  <div class="rowbox row">
							<span class="col-xs-3"><b>*</b>角色名称</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input  nullmsg="请输入角色名称！"type="text" name="NAME" id="LOGON_NAME" fieldname="ROLE_NAME" class="col-xs-12"  ajaxurl="${ctx}/xtgl/usersController?check"/>
									<i class="ace-icon fa fa-user" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3">显示序号</span>

							<div class="col-sm-8">
								<input type="text" check-type="n" name="XUHAO" id="XUHAO" fieldname="XUHAO" class="col-xs-12"  />
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3">汉字描述</span>

							<div class="col-sm-8">
								<input type="text"  fieldname="DESCRIPTION" name="S_MEMO" id="S_MEMO"  class="col-xs-12">
							</div>
			</div>
			
     </form>
     
	</div>

  <div class="modal_footer">
    <span data-dismiss="modal" class="closeBtn" id="btnClose">关闭</span> 
	<span  class="saveBtn" id="saveRoleInfo">保存</span>
  </div>
</div>
</div>
<form method="post" id="queryFormById"  >
   <table class="B-table" width="100%">
   <!--可以再此处加入hidden域作为过滤条件 -->
   	<TR  style="display:none;">
     	<TD class="right-border bottom-border">
      	<INPUT type="text"  kind="text" id="QROLE_ID"  fieldname="ROLE_ID" value="<%=ROLE_ID %>" operation="="/>
      	</TD>
		<TD class="right-border bottom-border">
		</TD>
     </TR>
   </table>
</form>	
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/combineQuery.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/bootstrap-validation.js"> </script>
<script src="${ctx}/assets/sys_resources/js/common/loadFields.js?version=20131206"></script>
<script type="text/javascript">
var controllername= "${pageContext.request.contextPath }/roleController";
var validform;
//点击保存按钮
$(function() {	
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	validform=FormValid.validbyformid(executeFrm);
	
	$("#saveRoleInfo").click(function() {
	  if(validform.check()){
		if($("#executeFrm").validationButton()) {
			$("#P_UID").val($("#project_uid").val());
			//生成json串
			var data = Form2Json.formToJSON(executeFrm);
			//组成保存json串格式
			var data1 = defaultJson.packSaveJson(data);
			
			var ROLE_ID = $('#PROJECT_ROLE_UID').val();
			
			if(ROLE_ID==""){
				defaultJson.doInsertJson(controllername + "?executeRole&operatorSign=1", data1);
			}else{
				defaultJson.doInsertJson(controllername + "?executeRole&operatorSign=2", data1);
			}
			jQuery("#grid_table").jqGrid().trigger("reloadGrid");
			$('#btnClose').click();
			//var a =window.parent;
			//a.location.reload();
			//window.close();
		 }
	   }else {
		   return;
	   }
	});
	init();
});


function init(){
	var ROLE_ID = $('#QROLE_ID').val();
	if(ROLE_ID!=""){
		setFormValues();
	}
}

function setFormValues(){
	var data = combineQuery.getQueryCombineData(queryFormById,null,null);
	var data1 = {
		msg : data
	};
	$.ajax({
		url : '${pageContext.request.contextPath }/roleController?queryRole',
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			var resultobj = defaultJson.dealResultJson(response.msg);
			$("#executeFrm").setFormValues(resultobj);	
		}
	});
}

</script>

		