<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>
 
<%@ include file="/jsp/commons/edit.jspf"%>
 <%
String rootFile = request.getScheme()+"://"+request.getServerName()+":8088/file";
String rootFileApp = request.getScheme()+"://"+request.getServerName()+":8088/app"; 

%>


<div class="container">
<div class="modal-dialog"  tabindex="-1" role="dialog" style="width:80%">
   <div class="modal-content">
      <div class="modal-header">
         <button type="button" class="close"
            data-dismiss="modal" aria-hidden="true">
               &times;
         </button>
         <h4 class="modal-title" id="myModalLabel">
                                                查看通知公告
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbuser/tbUserController/edit.do" role="form" name="Form" id="detailForm" method="post">
           	  
           	  
           	   <input type="hidden" name="F_USER_ID" id="F_USER_ID" value="${pd.F_USER_ID}"/>
 
					 
					  <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						             <input type="text" datatype="*" class="form-control" id="F_UserName"  name="F_UserName"  value=""  placeholder="请填写用户账号" title="用户账号">
						          </div>  
						  </div>
						  
						   <div class="form-group">
						          <label class="col-sm-2 control-label">用户密码:</label>
						          <div class="col-sm-10">  
						             <input type="password" datatype="*" class="form-control" id="F_RealPassword"  name="F_RealPassword"  value=""  placeholder="请填写用户密码" title="用户密码">
						          </div>  
						  </div>
						  
						  
						  
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户邮箱:</label>
						          <div class="col-sm-10">  
						             <input rows="4" type="email" class="form-control" id="F_Email"  name="F_Email"      placeholder="请填写用户邮箱" title="用户邮箱" value="">
						             </input>
						          </div>  
						       </div>
						 
						  <div class="form-group">
						          <label class="col-sm-2 control-label">用户手机号:</label>
						          <div class="col-sm-10">  
						             <input rows="4" type="text" class="form-control" id="F_Mobile"  
						             name="F_Mobile"     
						             placeholder="请填写用户手机号" title="用户手机号" value=""
						             datatype="/^[a-zA-Z0-9_]{11}$/"
						             errormsg="您输入的手机号码格式不正确" nullmsg="请输入手机号码"
						             ajaxurl="${pageContext.request.contextPath}/tbuser/tbUserController?checkMobile&USER_UID=uidIsNull">
						             </input>
						          </div>  
						       </div>
						       
						       
					       <div class="form-group">
						          <label class="col-sm-2 control-label">性别:</label>
						          <div class="col-sm-10">  
						             <select id="F_Sex"  name="F_Sex" >
							             <option value="0">男</option>
							             <option value="1">女</option>
							             <option value="2">未知 </option>
							          </select> 
						          </div>  
						       </div>
					       
					       <div class="form-group">
						          <label class="col-sm-2 control-label">是否可用:</label>
						          <div class="col-sm-10">  
						          <select id="F_Deleted"  name="F_Deleted" >
						             <option value="1">可用</option>
						             <option value="0">停用</option>
						          </select> 
						          </div>  
						       </div>
					        
 
		      
        </form>
    
     
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>
 

 <script type="text/javascript" src="${ctxStatic}/business/tbuser/js/tbuser_detail.js"> </script>
