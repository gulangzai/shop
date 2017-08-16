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
                                                查看登录日志
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbloginlog/tbLoginLogController/edit.do" role="form" name="Form" id="detailForm" method="post">
           	  
           	  
           	   <input type="hidden" name="F_LOGIN_LOG_UID" id="F_LOGIN_LOG_UID" value="${pd.F_LOGIN_LOG_UID}"/>
 
					 
					  <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						             <input type="text" datatype="*" class="form-control" id="userId"  name="userId"  value=""  placeholder="请填写用户账号" title="用户账号">
						          </div>  
						  </div>
						  
						   <div class="form-group">
						          <label class="col-sm-2 control-label">用户名:</label>
						          <div class="col-sm-10">  
						             <input type="text" datatype="*" class="form-control" id="F_UserName"  name="F_UserName"  value=""  placeholder="请填写用户名" title="用户名">
						          </div>  
						  </div>
						  
						  
						  
					       <div class="form-group">
						          <label class="col-sm-2 control-label">登录时间:</label>
						          <div class="col-sm-10">  
						             <input  type="text" 
						             class="form-control" 
						             id="loginTime"  
						             name="loginTime"      
						             placeholder="请填写登录时间" 
						             title="用户登录时间">
						             </input>
						          </div>  
						       </div>
						 
						  <div class="form-group">
						          <label class="col-sm-2 control-label">登出时间:</label>
						          <div class="col-sm-10">  
						             <input  type="text" 
						             class="form-control" 
						             id="loginOut"  
						             name="loginOut" 
						             nullmsg="登出时间">
						             </input>
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
 

 <script type="text/javascript" src="${ctxStatic}/business/tbloginlog/js/tbloginlog_detail.js"> </script>
