<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>

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
              编辑商品
         </h4>
      </div>
      <div class="modal-body">
           <form class="form-horizontal"  role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_PRODUCT_ID" id="F_PRODUCT_ID" value="${pd.F_PRODUCT_ID}"/>
		     <input type="hidden" name="F_CLSID" id="F_CLSID" value="${pd.F_CLSID}"/>
		     <input type="hidden" name="F_IsSpecial" id="F_IsSpecial"/>
		     <input type="hidden" name="F_Status" id="F_Status" value="0"/>
		
	       <div class="form-group">
	          <label class="col-sm-2 control-label">商品名:</label>
	          <div class="col-sm-4">  
	             <input type="text" class="form-control" id="F_PRODUCTNAME"  name="F_ProductName"  value="${pd.F_PRODUCTNAME}"  placeholder="这里输入商品名" title="商品名">
	          </div> 
	          
	         
	          <label class="col-sm-2 control-label">实际进货价:</label>
	           <div class="col-sm-4">  
	              <input type="text"  class="form-control"  name="F_REAL_PRICE" id="F_REAL_PRICE" value="${pd.F_REAL_PRICE}" maxlength="32" placeholder="这里输入本站价" title="本站价"/>
	           </div>
	            
	       </div>
	       
	          &nbsp;&nbsp;&nbsp;
 
			<div class="form-group">
			
			 <label class="col-sm-2 control-label">商品展示价:</label>
	           <div class="col-sm-4">  
	              <input type="text"  class="form-control"  name="F_SHOW_PRICE" id="F_SHOW_PRICE" value="${pd.F_SHOW_PRICE}" maxlength="32" placeholder="这里输入商品展示价" title="商品展示价"/>
	           </div>
	           
	          <label class="col-sm-2 control-label">商品价格:</label>
	           <div class="col-sm-4">  
	              <input type="text"  class="form-control"  name="F_PRICE" id="F_PRICE" value="${pd.F_PRICE}" maxlength="32" placeholder="这里输入商品价格" title="商品价格"/>
	           </div>
	           
	          
	           
	       </div>
	       
	       
	      <div class="form-group">
	          <label class="col-sm-2 control-label">是否特卖:</label>
	          <div class="col-sm-4">  
	                 <div class="radio col-sm-5" >
								<label >
									<input type="radio" class="ace" name="F_ISSPECIAL_label" value="0" id="F_ISSPECIAL_label0" <c:if test='${pd.F_ISSPECIAL==0}'>checked="checked"</c:if>>
									<span class="lbl"> 是</span>
								</label>  
				     </div>
				  
				     <div class="radio col-sm-5" >
				               <label>
									<input type="radio" class="ace" name="F_ISSPECIAL_label" value="1" id="F_ISSPECIAL_label1" <c:if test='${pd.F_ISSPECIAL==1}'>checked="checked"</c:if>>
									<span class="lbl" style="margin-left: 20px;"> 否</span>
								</label>  
				    </div> 
	          </div>
	          
	           <label class="col-sm-2 control-label">商品状态:</label>
	          <div class="col-sm-4">  
	                 <div class="radio col-sm-6">
								<label >
									<input type="radio" class="ace" name="F_Status_label" value="0" id="F_Status_label0" <c:if test='${pd.F_Status==0}'>checked="checked"</c:if>>
									<span class="lbl"> 正常</span>
								</label>  
				     </div>
				  
				     <div class="radio col-sm-6">
				               <label>
									<input type="radio" class="ace" name="F_Status_label" value="1" id="F_Status_label1" <c:if test='${pd.F_Status==1}'>checked="checked"</c:if>>
									<span class="lbl" style="margin-left: 20px;"> 下线</span>
								</label>  
				    </div> 
	          </div>
	          
	          
	       </div>
	       
	       
	    
	       
	         &nbsp;&nbsp;&nbsp;
 
			<div class="form-group">
	          <label class="col-sm-2 control-label">商品数量:</label>
	           <div class="col-sm-4">  
	              <input type="text"  class="form-control"  name="F_Number" id="F_Number" value="${pd.F_PRICE}" maxlength="32" placeholder="这里输入商品数量" title="商品数量"/>
	           </div>
	           
	            <label class="col-sm-2 control-label">运费:</label>
	           <div class="col-sm-4">  
	              <input type="text"  class="form-control"  name="F_Express" id="F_Express" value="${pd.F_Express}" maxlength="32" placeholder="这里输入运费" title="运费"/>
	           </div>
	           
	       </div>
	       
	       
			
			<div class="form-group">  
	            <label class="col-sm-2 control-label">商品类型:</label>
	           <div class="col-sm-4">   
	              <input type="text"  class="form-control"  name="F_CLSNAME" id="F_CLSNAME" value="${pd.F_CLSNAME}" maxlength="32" placeholder="这里输入商品类型" title="商品类型"/>
	            </div>
	            <label  class="btn"  id="selectClassTree">选择</label>
	       </div>
			 
	        &nbsp;&nbsp;&nbsp;
	        
	        <div class="form-group">
		      <label for="lastname" class="col-sm-2 control-label">商品描述:</label>
		      <div class="col-sm-9">
		        <textarea  cols="100"  rows="5"   style="width: 100%;"  name="F_PRODUCTDESC" id="F_PRODUCTDESC"   placeholder="这里输入商品描述" title="商品描述">${pd.F_PRODUCTDESC}</textarea>
		      </div>
		   </div>
	   
	   <div class="form-group">
			      <label for="lastname" class="col-sm-2 control-label">图片URL1</label>
			      <div class="col-sm-10">
			        <input   type="text" class="form-control"  name="F_PATH1" id="F_PATH1"   placeholder="这里输入商品URL1" title="商品URL">${pd.F_PATH1}</textarea>
			      </div>
		   </div>
		   
			   <div class="form-group">
				      <label for="lastname" class="col-sm-2 control-label">图片URL2</label>
				      <div class="col-sm-10">
				        <input   type="text" class="form-control"  name="F_PATH2" id="F_PATH2"   placeholder="这里输入商品URL2" title="商品URL">${pd.F_PATH2}</textarea>
				      </div>
			   </div>
			   
			   <div class="form-group">
				      <label for="lastname" class="col-sm-2 control-label">图片URL3</label>
				      <div class="col-sm-10">
				        <input   type="text" class="form-control"  name="F_PATH3" id="F_PATH3"   placeholder="这里输入商品URL3" title="商品URL">${pd.F_PATH3}</textarea>
				      </div>
			   </div>
			   
			   <div class="form-group">
				      <label for="lastname" class="col-sm-2 control-label">图片URL4</label>
				      <div class="col-sm-10">
				        <input   type="text" class="form-control"  name="F_PATH4" id="F_PATH4"   placeholder="这里输入商品URL4" title="商品URL">${pd.F_PATH4}</textarea>
				      </div>
			   </div>
		   
	   
	       <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right" ></label>
                <div class="col-sm-10"> 
						<div class="col-xs-11 col-sm-11">
							<a data-target=""  style="float: right;" id="newAddZhengGaiContent" data-toggle="modal">
								<button type="button" class="btn btn-link btn-sm" id="addScslItem"
									title="添加" onclick="addStandard()">
									<i class="ace-icon glyphicon glyphicon-plus blud">添加</i>
								</button> </a> 
					</div>
				</div>
				<!-- /section:custom/widget-box.options -->
            </div>
            
	     	<div class="form-group" >
	  			<label class="col-sm-2 control-label no-padding-right" >规格项</label>
				<div class="col-sm-10" >
					<span  class="col-xs-11 col-sm-11" > 
				 		
						 <table class="table table-striped table-bordered table-hover">
								<thead class="thin-border-bottom">
									<tr>
										<th id="XH">序号</th>
										<th fieldname="WG_DENGJI2">规格名</th>
										<th fieldname="WG_DENGJI3">规格值</th> 
										<th class="col-sm-2" style="text-align:center;">操作</th>
									</tr>
								</thead>
								<tbody id="t1" class="guige"></tbody>
							</table>  
							 
					</span>
				</div>
			</div>
			
	   
	    <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">
				        图片上传：&nbsp;
				</label> 
			 
				<div class="col-sm-9">
				     <div id="wrapper">
							<div id="container">
								<!--头部，相册选择和格式选择--> 
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
		  
    </form>
    
      <div class="row">
		      <label class="col-sm-2 control-label no-padding-right" style="text-align:right">图片:</label>
		       <div class="col-sm-9"  id="pictures">
		          
		      </div>
		 </div>
     
     
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         <button type="button" class="btn btn-primary" onclick="editUpdate()">
            提交更改
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal --> 
 </div>
 <script type="text/javascript" src="${ctxStatic}/business/tbproduct/js/tbproduct_edit.js"></script>
 