<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/commons/taglib.jsp"%> 
<%
  String F_ClsId = request.getParameter("F_ClsId");
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
                                             编辑类型
         </h4>
      </div>
      <div class="modal-body">
           <form class="form-horizontal" action="${ctx}/goodClass/edit.do" role="form" name="Form" id="Form_tbclass_edit" method="post">
           	 
           	   <input type="hidden" name="F_ClsId" id="Edit_F_ClsId" value="<%=F_ClsId%>"> 
           	   <input type="hidden" name="F_PClsId" id="Edit_F_PClsId" value=""> 
             
	       <div class="form-group">
	          <label class="col-sm-2 control-label">商品类型名:</label>
	          <div class="col-sm-4">  
	             <input type="text" class="form-control" id="F_ClsName"  name="F_ClsName"  value=""  placeholder="这里输入商品类型" title="商品类型">
	          </div> 
	          
	          <label class="col-sm-2 control-label">商品分类码:</label>
	          <div class="col-sm-4">  
	             <input type="text" class="form-control" id="F_CODE"  name="F_CODE"  value=""  placeholder="这里输入商品码" title="商品分类码">
	          </div> 
	          
	       </div>
	       
	        <div class="form-group">
	          <label class="col-sm-2 control-label">分类标签（英文）:</label>
	          <div class="col-sm-4">  
	             <input type="text" class="form-control" id="F_LABEL"  name="F_LABEL"  value=""  placeholder="这里输入分类标签（英文）" title="商品分类标签（英文）">
	          </div> 
	          
	       </div>
	       
	       
	       
	       
	      <div class="form-group"> 
	          <label class="col-sm-2 control-label">是否可用:</label>
	          <div class="col-sm-6">  
	                 <div class="radio col-sm-6" >
								<label >
									<input type="radio" class="ace" name="F_Status" value="1" id="F_Status_label1">
									<span class="lbl"> 是</span>
								</label>  
				     </div>
				  
				     <div class="radio col-sm-6" >
				               <label>
									<input type="radio" class="ace" name="F_Status" value="0" id="F_Status_label0">
									<span class="lbl" style="margin-left: 20px;"> 否</span>
								</label>  
				    </div> 
	          </div>
	      </div>
	       
	          
        </form> 
    </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         <button type="button" class="btn btn-primary" onclick="saveEdit()">
            提交更改
         </button>
      </div> 
   </div><!-- /.modal-content -->
</div><!-- /.modal --> 
 </div> 

<script type="text/javascript"  src="${ctxStatic}/business/tbclass/js/tbclass_edit.js"></script>	
 