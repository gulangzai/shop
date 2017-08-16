<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<!-- Modal -->
<div class="modal-dialog width-70 height-auto">
  <div class="modal-content" >
   		<div class="widget-header widget-header-large">
   		<div class="widget-toolbar">
			<a href="#" data-action="close" data-dismiss="modal">
				<i class="ace-icon fa fa-times"></i>
				</a>
		</div>
    	<h3 id="myModalLabel" class="blue bigger">用户信息<span id="title_sp"></span></h3>
  </div>
  <div class="modal-body">

 	  <form method="post" role="form" class="form-horizontal"  id="executeFrm" >      	
      	
	  		<div class="form-group" >
		  		<label class="col-sm-2 control-label no-padding-right" for="USER_CODE">
					登录名：<span class="required-indicator">*</span>
				</label>
				<div class="col-sm-4">
					 <input datatype="/^[a-zA-Z0-9_]{3,16}$/"  nullmsg="请输入登录名！"type="text" name="LOGON_NAME" id="LOGON_NAME" fieldname="LOGON_NAME" class="col-xs-11 col-sm-11"  ajaxurl="${ctx}/xtgl/usersController?check"/>
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
					 <input datatype="*6-100"  nullmsg="请输入登录密码！" errormsg=""  placeholder="请输入登录密码" type="password" name="MIMA" id="MIMA" fieldname="MIMA" class="col-xs-11 col-sm-11" autocomplete="off"  />
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
				</div>
	  		<label class="col-sm-2 control-label no-padding-right">
				确认密码：<span class="required-indicator">*</span>
			</label>
				<div class="col-sm-4">
					 <input id="confirmPwd"  datatype="*6-100"  nullmsg="请输入确认密码！" recheck="MIMA" errormsg="您两次输入的账号密码不一致！"  placeholder="请输入确定密码" type="password" class="col-xs-11 col-sm-11"  />
					 <div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
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
	  		
     </form>
     
	</div>

  <div class="modal_footer">
    <button class="btn btn-success btn-sm" id="addsaveUserInfo">保存</button>
    <button class="btn btn-danger btn-sm pull-right" id="btnClose" data-dismiss="modal" aria-hidden="true">关闭</button>
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
		