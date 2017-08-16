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
             <form class="form-horizontal" action="${ctx}/tbnotice/tbNoticeController/edit.do" role="form" name="Form" id="detailForm" method="post">
           	 <input type="hidden" name="F_NOTICE_UID" id="F_NOTICE_UID" value="${pd.F_NOTICE_UID}"/>
           	 
           	 <div class="form-group">
						<label class="col-sm-2 control-label">公告主题:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="F_NOTICE_TITLE"
								name="F_NOTICE_TITLE" value="${pd.F_NOTICE_TITLE}"
								placeholder="请填写公告主题" title="用户账号">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">公告内容:</label>
						<div class="col-sm-10">
							<textarea  rows="4" class="form-control" id="F_NOTICE_CONTENT"
								name="F_NOTICE_CONTENT" value="${pd.F_NOTICE_CONTENT}"
								placeholder="请填写公告内容" title="商品id">
						             </textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">公告类型:</label>
						<div class="col-sm-10">
							<select id="F_NOTICE_TYPE" name="F_NOTICE_TYPE">
								<option value="XTXX">系统消息</option>
								<option value="DDTZ">订单通知</option>
								<option value="QTTZ">其他通知</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">公告等级:</label>
						<div class="col-sm-10">
							<select id="F_NOTICE_LEVEL" name="F_NOTICE_LEVEL">
								<option value="1">重要</option>
								<option value="0">一般</option>
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
 

 <script type="text/javascript" src="${ctxStatic}/business/tbnotice/js/tbnotice_detail.js"> </script>
