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
                                             编辑订单管理
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tborder/tbOrderController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_ORDER_UID" id="F_ORDER_UID" value="${pd.F_ORDER_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">订单编号:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_OrderSeries"  name="F_OrderSeries"  value="${pd.F_OrderSeries}"  placeholder="请填写订单编号" title="订单编号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_USER_ID"  name="F_USER_ID"  value="${pd.F_USER_ID}"  placeholder="请填写用户账号" title="用户账号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品id:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_PRODUCT_ID"  name="F_PRODUCT_ID"  value="${pd.F_PRODUCT_ID}"  placeholder="请填写商品id" title="商品id">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品单价:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_SinglePrice"  name="F_SinglePrice"  value="${pd.F_SinglePrice}"  placeholder="请填写商品单价" title="商品单价">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品购买数量:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_BuyCount"  name="F_BuyCount"  value="${pd.F_BuyCount}"  placeholder="请填写商品购买数量" title="商品购买数量">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品总价值:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_Cost"  name="F_Cost"  value="${pd.F_Cost}"  placeholder="请填写商品总价值" title="商品总价值">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">买家留言:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_Message"  name="F_Message"  value="${pd.F_Message}"  placeholder="请填写买家留言" title="买家留言">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">订单状态:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_Status"  name="F_Status"  value="${pd.F_Status}"  placeholder="请填写订单状态" title="订单状态">
						          </div>  
						       </div>
						     <div class="form-group">
						          <label class="col-sm-2 control-label">创建时间:</label>
						          <div class="col-sm-4">  
						             <input type="text" class="form-control CREATE_DATE" id="CREATE_DATE"  name="CREATE_DATE"  value="${pd.CREATE_DATE}"  placeholder="锟斤拷锟斤拷锟斤拷锟斤拷创建时间" title="创建时间">
						          </div>  
						       </div>
						  
						 
	       
 
			
	   
	    <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">
				           图片上传&nbsp;
				</label> 
			 
				<div class="col-sm-9">
				     <div id="wrapper">
							<div id="container"> 
								<div id="uploader">
									<div class="queueList">
										<div id="dndArea" class="placeholder">
											<div id="filePicker"></div>
											<p>或将照片拖到这里，单次最多可选300张</p>
										</div>
									</div>
									<div class="statusBar" style="display: none;">
										<div class="progress">
											<span class="text">0%</span> <span class="percentage"></span>
										</div>
										<div class="info"></div>
										<div class="btns">
											<div id="filePicker2"></div>
											<div class="uploadBtn">开始上传</div>
										</div>
									</div>
								</div>
							</div> 
						</div>
				 </div>
		 </div>
		  
		   <div class="form-group">
		      <label class="col-sm-2 control-label">图片:</label>
		       <div class="col-sm-9"  id="pictures"> 
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

 <script type="text/javascript" src="${ctxStatic}/business/tborder/js/tborder_edit.js"> </script>