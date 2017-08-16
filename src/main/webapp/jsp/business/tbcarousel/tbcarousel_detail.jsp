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
                                                查看轮播
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbnotice/tbNoticeController/edit.do" role="form" name="Form" id="detailForm" method="post">
           	
           	 <input type="hidden" name="F_Id" id="F_Id" value="${pd.F_Id}"/>
 
					<div class="form-group">
						<label class="col-sm-2 control-label">轮播链接:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="F_Url"
								name="F_Url" value="${pd.F_Url}"
								placeholder="请填写轮播链接" title="轮播链接">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">图片地址:</label>
						<div class="col-sm-10">
							<textarea rows="4" class="form-control" id="F_Address"
								name="F_Address" value="${pd.F_Address}"
								placeholder="请填写图片地址" title="图片地址">
						             </textarea>
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
 

 <script type="text/javascript" src="${ctxStatic}/business/tbcarousel/js/tbcarousel_detail.js"> </script>
