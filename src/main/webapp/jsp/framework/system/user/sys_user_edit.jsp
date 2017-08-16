<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ page import="com.ccthanking.framework.Constants"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%> 
<%@ taglib uri="/tld/base.tld" prefix="app"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/sys_resources/plugins/lightbox/themes/default/jquery.lightbox.css" /> 
<%
	User user = RestContext.getCurrentUser();
	String user_uid = "";
	String username = "";
	if(user!=null){
		user_uid = user.getIdCard();
		username = user.getName();
	}else{
		if("".equals(request.getContextPath())){
			response.sendRedirect("/");
		}else{
			response.sendRedirect("/"+Constants.APP_NAME);
		}
		return;
	}
	String PROJECT_UID = request.getParameter("PROJECT_UID");
	String USER_UID = request.getParameter("USER_UID");  
%>
<style>
.page-content {
    background-color: #fff;
    position: relative;
    margin: 0;
    padding:3px 0px 0px 3px;
}
</style>
<!-- Modal -->
<div class="modal-dialog  width-40 height-auto" style="min-width: 500px;">
  <div class="modal-content" >
   <p class="pop_title">修改用户<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png' ></span></p>
  <div id="information">
      <form id="sys_userEditForm">
       <input  type="hidden" name="USER_UID" operation="=" fieldname="su.USER_UID" value="<%=USER_UID%>"/>    
      </form>
      
 	  <form method="post" role="form" class="form-horizontal"  id="execute_sys_userEdit" > 
 	   <!-- 获取 项目 的 uid -->    	
      	  <input id="XCROJECT_UID" type="hidden" name="ROJECT_UID" fieldname="PROJECT_UID"  /> 
	  	  <input  type="hidden" name="USER_UID"   fieldname="USER_UID" value="<%=USER_UID%>"/>       
          <input type="hidden" id="target_uid" fieldname="target_uid"/>
	  	  <input type="hidden" value="1" id="xmShowTP"  />
	  	  <fieldset style="width:50%;margin:0px auto">
	      <div class="form-group" >	 		
		  		  <div class="block clearfix" style="border:1px solid #D5D5D5;text-align:center" > 
					   <span class="profile-picture padding" onclick="selectFile(this);" file_type="10008">
							    <img id="showPICTURES" src="${pageContext.request.contextPath}/assets/images/userImg/profile-pic.jpg" 
							    alt="Alex's Avatar" class="img-responsive " width="60"  height="55"/>
					   </span>
					   <span class="padding" >
							<i class="ace-icon fa  bigger-100"></i>
		                      <font color="red"></font>     
					   </span>
				 </div> 
				 <div>
				     <table  id="sfshowTb" role="presentation" class="table table-striped" style="display: none;">
	                          <tbody class="files showFileTab" data-toggle="modal-gallery" data-target="#modal-gallery"  file_type="10008"></tbody>
	                 </table>
				 </div>
		   </div>   			 
		   
		   <div class="rowbox row">
							<span class="col-xs-3"><b>*</b>登录名</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="LOGON_NAME_SYS_USER_EDIT" type="text" fieldname="LOGON_NAME" datatype="/^[a-zA-Z0-9_]{3,16}$/" nullmsg="请输入登录名" disabled="disabled"
										   placeholder="登录名"/>
									<i class="ace-icon fa fa-user" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3"><b>*</b>姓名</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="USER_NAME" type="text"  fieldname="USER_NAME" datatype="*" nullmsg="请输入姓名" placeholder="姓名" disabled="disabled" />
									<i class="ace-icon fa fa-user" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3">邮箱</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="EMAIL_SYS_USER_EDIT" type="text"  fieldname="EMAIL"  datatype="e" placeholder="邮箱" ignore="ignore"/>
									<i class="ace-icon fa fa-envelope" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3"><b>*</b>手机</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="MOBILE_SYS_USER_EDIT" type="text" fieldname="MOBILE" datatype="/^[a-zA-Z0-9_]{11}$/" errormsg="您输入的手机号码格式不正确" nullmsg="请输入手机号码" 
										 placeholder="手机"/>
									<i class="ace-icon fa fa-phone fa-flip-horizontal" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
		      
		 </fieldset>
     </form>
     
  </div>

  <div class="modal_footer"> 
    <span id="btnCloseXcJd"  class="closeBtn" data-dismiss="modal" aria-hidden="true">关闭</span>
    <span id="sys_userEditSave" class="saveBtn" type="button">&nbsp;保存&nbsp;</span>
  </div>
</div>
</div>
<div id="XMZK-XMMC" class="modal"></div>
<jsp:include page="/jsp/file_upload/fileupload_util.jsp" flush="true" />
<jsp:include page="/jsp/file_upload/showPictureorUser.jsp" flush="true" />	

<%@ include file="/jsp/framework/common/basic_scripts.jsp"%>
<script src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/plugins/lightbox/jquery.min.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/plugins/lightbox/jquery.lightbox.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/NetUtil.js"></script>


<script type="text/javascript"> 
var validform;
var controlletnameUrl="${pageContext.request.contextPath }/";
var scripts =[null]; 
controllernameUrl = controlletnameUrl+"sys/sysUserController";

ace.load_ajax_scripts(scripts, function() { 
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	DatePicker.datepicker(".REPORT_DATE1");
	DatePicker.datepicker(".REPORT_DATE_ONE");
});
 
 
$(function() {	  
	 
    setFormValues(); 
      
  //删除多余的 div 避免弹出图片时出现多层
	var div1 = $(".jquery-lightbox-overlay").eq(0);
	var div2 = $(".jquery-lightbox-move").eq(0); 
	$(".jquery-lightbox-overlay").remove();
	$(".jquery-lightbox-move").remove();
	$("body").append(div1);
	$("body").append(div2);
	validform=FormValid.validbyformid(execute_sys_userEdit); 
	$("#sys_userEditSave").click(function(){ 
		 
		  validform=FormValid.validbyformid(execute_sys_userEdit); 
		 //alert($("#MOBILE").attr("class").indexOf("Validform_error")==-1);
		 if(validform.check()){
			 //console.info($("#MOBILE_SYS_USER_EDIT")); 
			  setTimeout("bSubmit()",1000); 
			  bSubmit();
		 } 
    }); 
});

function bSubmit(){ 
	
	 if($("#MOBILE_SYS_USER_EDIT").attr("class").indexOf("Validform_error")==-1){
		  
			if($("#execute_sys_userEdit").validationButton()) {
			   
				//生成json串
				var data = Form2Json.formToJSON(execute_sys_userEdit);
				//组成保存json串格式
				var data1 = defaultJson.packSaveJson(data); 
				$.ajax({
					url :controllernameUrl+"?updateUser",
					data : data1,
					cache : false,
					async :	false,
					dataType : "json",  
					type : 'post',
					success : function(response) { 
				      xAlert("信息提示","修改成功",1);
					  $("#btnCloseXcJd").click();
					  jQuery("#grid_table").jqGrid().trigger("reloadGrid"); 
					}
				});  
			}
		   }else {
			   xAlert("信息提示：","填写信息有误，请检查！",1);
			   return;
		   } 
}

function setFormValues(){
	 
	var data = combineQuery.getQueryCombineData(sys_userEditForm,null,null);
	var data1={msg:data};
	$.ajax({
		url : controllernameUrl+"?queryUser",
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			var resultobj = defaultJson.dealResultJson(response.msg); 
			$("#execute_sys_userEdit").setFormValues(resultobj);
			queryFileData('sys_user',resultobj.USER_UID); 
		}
	});
	
/*	var logon_name_value=$("#LOGON_NAME").val();
	var ajaxurl = "${ctx}/commons/SysUserController?checkUserName&username="+logon_name_value;
	$("#LOGON_NAME").attr("ajaxurl",ajaxurl);	
	
	var email_value=$("#EMAIL").val();
	var ajaxurl_email="${ctx}/commons/SysUserController?checkEmail&email="+email_value;
	$("#EMAIL").attr("ajaxurl",ajaxurl_email);	
	*/
}


function selectFile(obj){
	var targetUid = $('#target_uid').val();
	var file_type = $(obj).attr('file_type');
	setFileData("SYS_USER","USER_UID",targetUid,file_type);
    document.getElementById("fileupload_btn").click();	 
}

function _reload(){
	jQuery("#grid_table").jqGrid().trigger("reloadGrid");
}

(function () {
    var v17 = $.noConflict(true);
    window.$.v17 = v17;
 })();

(function ($) {
 	$('.lightbox').lightbox();
 })(window.$.v17);

</script>