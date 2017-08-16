<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<!-- Modal -->
<div class="modal-dialog width-50 height-auto">
  <div class="modal-content" >
   		<div class="widget-header widget-header-large">
   		<div class="widget-toolbar">
			<a href="#" data-action="close" data-dismiss="modal">
				<i class="ace-icon fa fa-times"></i>
				</a>
		</div>
    	<h3 id="myModalLabel" class="blue bigger">角色信息<span id="title_sp"></span></h3>
  </div>
  <div class="modal-body">

 	  <form method="post" role="form" class="form-horizontal"  id="executeFrm" >      	
      	<input type="hidden" id="ROLE_UID">
	  		<div class="form-group" >
		  		<label class="col-sm-4 control-label no-padding-right">
					角色名称：<span class="required-indicator">*</span>
				</label>
				<div class="col-sm-6">
					 <input  nullmsg="请输入角色名称！"type="text" name="NAME" id="LOGON_NAME" fieldname="NAME" class="col-xs-11 col-sm-11"  ajaxurl="${ctx}/xtgl/usersController?check"/>
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
					
				</div>

			</div>
	  		<div class="form-group" >
			 <label class="col-sm-4 control-label no-padding-right" >
				角色类别：<span class="required-indicator">*</span>
			 </label>
				<div class="col-sm-6">
					<select name="ROLETYPE" fieldname="ROLETYPE" id="ROLETYPE" check-type="required" kind="dic" src="JSLB" defaultmemo="请选择"  class="col-xs-11 col-sm-11">

          			</select>
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
				</div>
			</div>
	  		<div class="form-group">
				<label class="col-sm-4 control-label no-padding-right" for="form-field-1">
					汉字描述：&nbsp;
				</label>
				<div class="col-sm-6">
					<input type="text"  fieldname="S_MEMO" name="S_MEMO" id="S_MEMO"  class="col-xs-11 col-sm-11">
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
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/combineQuery.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/bootstrap-validation.js"> </script>
<script type="text/javascript">
var validform;
//点击保存按钮
$(function() {	
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	validform=FormValid.validbyformid(executeFrm);
	
	$("#addsaveUserInfo").click(function() {
	  if(validform.check()){
		if($("#executeFrm").validationButton()) {
			//生成json串
			var data = Form2Json.formToJSON(executeFrm);
			//组成保存json串格式
			var data1 = defaultJson.packSaveJson(data);
			
			$.ajax({
				url :'${ctx}/xtgl/usersController?insert',
				data : data1,
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					xAlert("信息提示","新增成功",1);
					var a =window.parent;
					a.location.reload();
					window.close();
			      }
			});
			
		 }
	   }else {
		   return;
	   }
	});
});

</script>
		