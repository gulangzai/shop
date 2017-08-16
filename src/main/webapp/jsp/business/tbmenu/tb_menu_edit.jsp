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
                                             编辑菜单
         </h4>
      </div>
      <div class="modal-body">
      
             <form class="form-horizontal" action="${ctx}/tbmenu/tbMenuController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 
           	 
           	 
           	  <input type="hidden" name="id" id="id" value="${pd.id}"/>  
           	  <input type="hidden" name="F_MENU_SERIAL" id="F_MENU_SERIAL"/>  
           	  
               
             <input type="hidden" name="parent" id="parent" value="${pd.parent}"/>  
                       
                          <div class="form-group">
						          <label class="col-sm-2 control-label">菜单名:</label>
						          <div class="col-sm-10">  
						             <input type="text"
						             datatype="*"
						             class="form-control" id="name"  
						             name="name"   
						             placeholder="请填写菜单名" 
						             title="菜单名" 
						             nullmsg="请填写菜单"/>
						           </div>  
						  </div>
						  
						   <div class="form-group">
						          <label class="col-sm-2 control-label">菜单URL:</label>
						          <div class="col-sm-10">  
						             <input type="text"  
						             class="form-control" 
						             id="F_MENU_URL"  
						             name="F_MENU_URL"  
						             value=""  
						             placeholder="请填写菜单URL"  
						              nullmsg="请输入菜单URL"/>
						          </div>  
						  </div>
						  
						  
						  
					       <div class="form-group">
						          <label class="col-sm-2 control-label">菜单图标:</label>
						          <div class="col-sm-10">  
						             <input type="text"  
						             datatype="*"  
						             class="form-control" 
						             id="F_MENU_ICON"  
						             name="F_MENU_ICON"      
						             placeholder="请填写菜单图标" title="菜单图标"  
						             nullmsg="请输入菜单图标"/>
						             </input>
						          </div>  
						       </div>
						       
						       
						   <div class="form-group">
						          <label class="col-sm-2 control-label">菜单层级:</label>
						          <div class="col-sm-10">  
						             <input type="number"  
						             datatype="*"  
						             class="form-control" 
						             id="level"  
						             name="level"      
						             placeholder="请填写菜单层级" title="菜单层级"  
						             nullmsg="请输入菜单层级">
						             </input>
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
					 
					 

		   </form>
     
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button> 
         <button type="button" class="btn btn-primary" onclick="update()">
                                            保存
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>

 <script type="text/javascript" src="${ctxStatic}/business/tbmenu/js/tbmenu_edit.js"> </script>