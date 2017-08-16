<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp"%> 
<%@ taglib uri="/tld/base.tld" prefix="app"%>  
<%
String project_uid=request.getParameter("project");
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

<div class="modal-dialog width-40 height-auto"> 
			<div class="modal-content" >
				 <div class="widget-header widget-header-large">
				   		<div class="widget-toolbar">
							<a href="#" data-action="close" data-dismiss="modal">
								<i class="ace-icon fa fa-times"></i>
								</a>
						</div>
	    	      <h3 id="myModalLabel" class="blue bigger">添加已有用户</h3>
	              </div>
  
				 <div class="modal-body"> 
						<form method="post" role="form" class="form-horizontal"  id="executeFrm" > 
					     <input id="XCROJECT_UID" type="hidden" name="ROJECT_UID" fieldname="PROJECT_UID"  /> 
							<fieldset style="width:50%;margin:0px auto">
								<!-- 
								<div class="block clearfix" style="border:1px solid #D5D5D5;text-align:center" >
								   <span class="profile-picture padding" onclick="selectFile(this);" file_type="10008" style="width:60px;height:55px;align:center">
										    <img id="showPICTURES" src="${pageContext.request.contextPath}/assets/images/userImg/profile-pic.jpg" 
										    alt="Alex's Avatar" class="img-responsive " width="60px"  height="50px"/>
								   </span>
								 </div>
								 <div>
								  <table  id="sfshowTb" role="presentation" class="table table-striped" style="display: none;">
	                                 <tbody class="files showFileTab" data-toggle="modal-gallery" data-target="#modal-gallery"  file_type="10008"></tbody>
                                  </table>
								 </div>
								  -->
								<label class="block clearfix">
									<span class="block input-icon input-icon-right">
										<input id="LOGON_NAMES" name="login_name" type="text" class="form-control" fieldname="LOGON_NAME" datatype="/^[a-zA-Z][a-zA-Z0-9]*$/" nullmsg="请输入登录名"
										   placeholder="登录名" /><!--  ajaxurl="${pageContext.request.contextPath}/commons/SysUserController?checkName" -->
										<i class="ace-icon fa fa-user"></i>
									</span>
								</label>
								<label class="block clearfix">
								  <div id ="z_name" >
								 
								  </div>
									<!-- <span class="block input-icon input-icon-right">
										<input type="text" class="form-control" id="z_name"  datatype="*" nullmsg="请输入姓名" placeholder="姓名" />
										<i class="ace-icon fa fa-user"></i>
									</span>
									 -->
								</label>
								
								<!-- 
								<label class="block clearfix">
									<span class="block input-icon input-icon-right">
										<input type="password" class="form-control" fieldname="PWD" datatype="/^[A-Za-z0-9]+$/" errorMsg="密码只能是数字和字母组成" nullmsg="请输入密码"  placeholder="密码" />
										<i class="ace-icon fa fa-lock"></i>
									</span>
								</label>
								<label class="block clearfix">
									<span class="block input-icon input-icon-right">
										<input id="XZEMAIL" type="text" class="form-control" fieldname="EMAIL" datatype="e" errormsg="您输入的邮箱格式不正确" nullmsg="请输入邮箱"
										 ajaxurl="${pageContext.request.contextPath}/commons/SysUserController?check" placeholder="邮箱" />
										<i class="ace-icon fa fa-envelope"></i>
									</span>
								</label>
								
								<label class="block clearfix">
									<span class="block input-icon input-icon-right">
										<input type="text" class="form-control" fieldname="MOBILE" datatype="m" errormsg="您输入的手机号码格式不正确" nullmsg="请输入手机号码" placeholder="手机" />
										<i class="ace-icon fa fa-mobile"></i>
									</span>
								</label>
								<div class="space-24"></div>
								 -->
							</fieldset>
							  
			  
						</form>
						 
			     </div>
			     <div class="modal_footer"> 
							   	
							     <button id="saveBtn" class="btn btn-1 btn-sms btn-round  pull-right" type="button">&nbsp;保存&nbsp;</button>
							     <button id="btnClosesys_useradd"  class="btn btn-2 btn-sms  btn-round" data-dismiss="modal" aria-hidden="true">关闭</button>
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
	    $(function(){
	         $('input[name="login_name"]').blur(function(){
               
               selectname();
             })
	    })
	   
           
		function init(){
			validform = FormValid.validbyformid(executeFrm);
			var table = document.getElementById("sfshowTb");
			
			/**点击 注册按钮 再次判断 之前的登录名及邮箱是否验证通过**/
			$('#saveBtn').click(function() { 
				 if (validform.check() && $("#LOGON_NAMES").attr("class").indexOf("Validform_error") == -1 
						) {
								bootbox.confirm("确认导入用户吗？", function(result) {
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
				url: controllername+'?daoruyonghu',
				data: data1,
				cache: false,
				async: false,
				dataType: "json",
				type: 'post',
				success: function(response) {
					$("#btnClosesys_useradd").click();
					_reload();
				}
			});
		}
		function selectname() {
		    var names=$("#LOGON_NAMES").val();
		    var user_name="";
			$.ajax({
				url: controllername+'?queryname',
				data: {"names":names},
				cache: false,
				async: false,
				dataType: "json",
				type: 'post',
				success: function(response) {
				   $("#z_name").empty();
				    msg = eval("("+response.msg+")");
				    if(msg=='0'){
				         var html = "<span id='yonghu_a' style='color:red;font-size:15px;'>&nbsp;&nbsp;没有此用户</span>";
			            $("#z_name").append(html);
				    }else{
			        user_name= msg.response.data[0].USER_NAME;
			        }
			        if(!user_name==""){
			            var html = "<span id='yonghu_a' style='color:red;font-size:15px;'>&nbsp;&nbsp;姓名："+user_name+"</span>";
			            $("#z_name").append(html);
			        }
			        
				}
			});
		}

</script>	
</html>