<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>


<div class="container">
  
   <div class="modal-dialog"  tabindex="-1" role="dialog" style="width:80%">

			
	  <div class="modal-content">
         <div class="modal-header"> 
           <button type="button" data-action="close"  class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button> 
            <h4 class="modal-title" id="myModalLabel">
                                                           添加权限                                  
            </h4>
         </div>
 
			 <div class="modal-body">
       
	            <form  class="form-horizontal" id="userRoleForm">
	               <input type="hidden"   name="F_USER_ID" value="${F_USER_ID}" />
		               <div class="form-group">  
		               <div class="col-sm-12"> 
			              <c:forEach items="${varList}"  var="role">
			                     <div class="col-sm-4" style="float:left;width:150px;">
				                    <label>   
				                      <input type="checkbox" class="ace"  name="role" value="${role.F_ROLE_ID}" <c:if test="${role.F_ROLE_ID_1==role.F_ROLE_ID}">checked="checked"</c:if> />
				                      <span class="lbl"/>${role.F_ROLE_NAME}</span> 
				                    </label>
			                    </div>
			               </c:forEach>
			               </div>
		            </div>
	              </form> 
             
         </div>
         
         
         
         <div class="modal-footer">
           <button type="button" class="btn btn-default btn-save" 
               data-dismiss="modal">保存
            </button>
            <button type="button" class="btn btn-default btn-close" 
               data-dismiss="modal">关闭
            </button> 
         </div>
      </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>
 
 
    
<script>
	$(".btn-save").click(function(){
		$.ajax({
	    	type:'post',
	    	data:$("#userRoleForm").serialize(),
	    	dataType:'json',
	    	async:'false',
	    	url:'${ctx}/tbRoleController/saveUserRole.do',
	    	success:function(data){
	    		
	    	}
	    });
	}); 
</script> 