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
                                           添加属性表
         </h4>
      </div>
      <div class="modal-body">
           <form class="form-horizontal" action="${ctx}/sysattr/sysAttrController/edit.do" role="form" name="Form" id="addForm" method="post">
           	 <input type="hidden" name="F_ATTR_UID" id="F_ATTR_UID" value="${pd.F_ATTR_UID}"/>
		  
		 
					       <div class="form-group">
						          <label class="col-sm-2 control-label">属性表名:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_ATTR_TABLE"  name="F_ATTR_TABLE"  value="${pd.F_ATTR_TABLE}"  placeholder="请填写属性表名" title="属性表名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">属性表名(描述):</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_ATTR_NAME"  name="F_ATTR_NAME"  value="${pd.F_ATTR_NAME}"  placeholder="请填写属性表名(描述)" title="属性表名(描述)">
						          </div>  
						   </div> 
        </form>
     
   </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         <button type="button" class="btn btn-primary" onclick="save()">
            提交更改
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 </div>
 <script type="text/javascript" src="${ctxStatic}/business/sysattr/js/sys_attr_add.js"></script>