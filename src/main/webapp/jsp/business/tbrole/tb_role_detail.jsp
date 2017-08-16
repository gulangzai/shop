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
                                                查看角色
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbrole/tbRoleController/edit.do" role="form" name="Form" id="detailForm" method="post">
           	  
           	  
           	   <input type="hidden" name="F_ROLE_ID" id="F_ROLE_ID" value="${pd.F_ROLE_ID}"/>
 
					 
					        <div class="form-group">
						          <label class="col-sm-2 control-label">角色名:</label>
						          <div class="col-sm-10">  
						             <input type="text"
						             class="form-control" id="F_ROLE_NAME"  
						             name="F_ROLE_NAME"  value=""  
						             placeholder="请填写角色名" 
						             title="角色名" 
						             nullmsg="请填写角色名"/>
						           </div>  
						  </div>
						 
				 
					       
					       <div class="form-group">
						          <label class="col-sm-2 control-label">是否可用:</label>
						          <div class="col-sm-10">  
						          <select id="F_STATUS"  name="F_STATUS" >
						             <option value="1">可用</option>
						             <option value="0">停用</option>
						          </select> 
						          </div>  
						       </div>
					       
					       
                    <div class="form-group">
						          <label class="col-sm-2 control-label">备注:</label>
						          <div class="col-sm-10">  
						             <textarea type="text"
						             class="form-control" id="DESCRIPTION"  
						             name="DESCRIPTION"
						             rows="4" 
						             placeholder="请填写备注" 
						             title="备注" 
						             nullmsg="请填写备注"></textarea>  
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
 

 <script type="text/javascript" src="${ctxStatic}/business/tbrole/js/tbrole_detail.js"> </script>
