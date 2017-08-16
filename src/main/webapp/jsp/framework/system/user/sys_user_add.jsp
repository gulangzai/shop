<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ page import="com.ccthanking.framework.Constants"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%> 
<%@ taglib uri="/tld/base.tld" prefix="app"%>  
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
.padding{
margin:1px 1px 1px 1px ;
cursor: pointer;
}
.page-content {
    background-color: #fff;
    position: relative;
    margin: 0;
    padding:3px 0px 0px 3px;
}
</style>
 </head> 

<div class="modal-dialog width-40 height-auto" style="min-width: 500px;">
			<div class="modal-content" >
	<p class="pop_title">添加用户<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png' ></span></p>
  
				 <div id="information">
						<form method="post" role="form" class="form-horizontal"  id="executeFrm" style="padding: 0px;"> 
					     <input id="XCROJECT_UID" type="hidden" name="ROJECT_UID" fieldname="PROJECT_UID"  /> 
						 <input type="hidden" id="target_uid" fieldname="target_uid"  />   
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
									<input class="col-xs-12" id="LOGON_NAME_S" type="text" fieldname="LOGON_NAME" datatype="/^[a-zA-Z0-9_]{3,16}$/" nullmsg="请输入登录名"
										  ajaxurl="${pageContext.request.contextPath}/sys/sysUserController?checkName"  placeholder="登录名"/>
									<i class="ace-icon fa fa-user" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3"><b>*</b>姓名</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" fieldname="USER_NAME" datatype="*" nullmsg="请输入姓名" placeholder="姓名" />
									<i class="ace-icon fa fa-user" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3"><b>*</b>密码</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12"  type="password" fieldname="PWD" datatype="/^[\s|\S]{6,}$/" errorMsg="密码只能是数字和字母组成" nullmsg="请输入密码"  placeholder="密码"/>
									<i class="ace-icon fa fa-lock" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3">邮箱</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="LOGON_NAME_S" fieldname="EMAIL"  datatype="e" placeholder="邮箱" ignore="ignore"/>
									<i class="ace-icon fa fa-envelope" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
			
			<div class="rowbox row">
							<span class="col-xs-3"><b>*</b>手机</span>

							<div class="col-sm-8">
								<div class="input-icon input-icon-right" >
									<input class="col-xs-12" id="MOBILE_PHONE" type="text" fieldname="MOBILE" datatype="/^[a-zA-Z0-9_]{11}$/" errormsg="您输入的手机号码格式不正确" nullmsg="请输入手机号码" 
										 ajaxurl="${pageContext.request.contextPath}/sys/sysUserController?checkMobile&USER_UID=<%=user_uid%>" placeholder="手机"/>
									<i class="ace-icon fa fa-phone fa-flip-horizontal" style="margin-top: 0px;"></i> 
								</div>
							</div>
			</div>
		   
							</fieldset>
						</form>
			     </div>  
			      <div class="modal_footer">
	                <span data-dismiss="modal" class="closeBtn" id="btnClosesys_useradd">关闭</span>
					<span id="btnResetsys_useradd" type="reset" class="saveBtn">重置</span>
	               <span class="saveBtn" id="saveBtn">保存</span>
				  </div>
		</div> 
</div> 

<jsp:include page="/jsp/file_upload/showPictureorUser.jsp" flush="true" />	

<script type="text/javascript">
		var validform;
		var scripts = [null];
		//对应后台Controller
		var controllername = "${pageContext.request.contextPath }/sys/sysUserController";
		//页面加载自动执行此函数
		ace.load_ajax_scripts(scripts, function() {
			/** modal高度自适应 */
			$("#information").css('max-height',$(window).height()-210 +'px');
			$("#XCROJECT_UID").val($("#project_uid").val());
			init();
		});
	
		function init(){
			validform = FormValid.validbyformid(executeFrm);
			var table = document.getElementById("sfshowTb");
			
			/**点击 注册按钮 再次判断 之前的登录名及邮箱是否验证通过**/
			$('#saveBtn').click(function() { 
				 if (validform.check() && $("#LOGON_NAME_S").attr("class").indexOf("Validform_error") == -1 
						&& $("#MOBILE_PHONE").attr("class").indexOf("Validform_error") == -1) {
					bootbox.confirm("确认添加用户吗？", function(result) {
						if (result) {
							addUser();
						} else {
							return;
						}
					});
				 }else {
					xAlert("信息提示：","填写信息有误，请检查！",1);
					return;
				} 
			});
			
		}

		function addUser() {
			//生成json串 executeFrm 为表单id
			var data = Form2Json.formToJSON(executeFrm);
			//组成保存json串格式
			var data1 = defaultJson.packSaveJson(data);
			$.ajax({
				url: controllername+'?addUser',
				data: data1,
				cache: false,
				async: false,
				dataType: "json",
				type: 'post',
				success: function(response) {
					xAlert("信息提示", "添加用户成功", 1); 
					$("#btnClosesys_useradd").click();
					_reload();
				}
			});
		}
		
/**用户头像上传*/
function selectFile(obj){
	var targetUid = $('#target_uid').val();
	var file_type = $(obj).attr('file_type');
	setFileData("SYS_USER","USER_UID",targetUid,file_type);
    document.getElementById("fileupload_btn").click();
}

</script>	
</html>