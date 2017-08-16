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
                                                查看订单管理
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tborder/tbOrderController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_ORDER_UID" id="F_ORDER_UID" value="${pd.F_ORDER_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">订单编号:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_OrderSeries"  name="F_OrderSeries"  value="${pd.F_OrderSeries}"  placeholder="��������订单编号" title="订单编号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_USER_ID"  name="F_USER_ID"  value="${pd.F_USER_ID}"  placeholder="��������用户账号" title="用户账号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品id:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_PRODUCT_ID"  name="F_PRODUCT_ID"  value="${pd.F_PRODUCT_ID}"  placeholder="��������商品id" title="商品id">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品单价:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_SinglePrice"  name="F_SinglePrice"  value="${pd.F_SinglePrice}"  placeholder="��������商品单价" title="商品单价">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品购买数量:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_BuyCount"  name="F_BuyCount"  value="${pd.F_BuyCount}"  placeholder="��������商品购买数量" title="商品购买数量">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品总价值:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_Cost"  name="F_Cost"  value="${pd.F_Cost}"  placeholder="��������商品总价值" title="商品总价值">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">买家留言:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_Message"  name="F_Message"  value="${pd.F_Message}"  placeholder="��������买家留言" title="买家留言">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">订单状态:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_Status"  name="F_Status"  value="${pd.F_Status}"  placeholder="��������订单状态" title="订单状态">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">创建时间:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="CREATE_DATE"  name="CREATE_DATE"  value="${pd.CREATE_DATE}"  placeholder="��������创建时间" title="创建时间">
						          </div>  
						       </div>
						 
	      <div class="form-group">
	           <div id="dndArea" class="placeholder"> </div>
		      <label class="col-sm-2 control-label">图片:</label>
		       <div class="col-sm-9"  id="detail-pictures"> 
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
 
 
 <script type="text/javascript">
 
 $(function(){ 
	 init();
 });
 
  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
   });
     
 
 function init(){ 
		var data1={F_ORDER_UID:'${pd.F_ORDER_UID}'};
		$.ajax({
			url : "${ctx}/tborder/tbOrderController/goEdit.do",
			data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				var product = response;
				setValue(product);
			}
		});  
	}
   
	
	function setValue(obj){  
			     $("#F_OrderSeries").val(obj.F_OrderSeries); 
			     $("#F_USER_ID").val(obj.F_USER_ID); 
			     $("#F_PRODUCT_ID").val(obj.F_PRODUCT_ID); 
			     $("#F_SinglePrice").val(obj.F_SinglePrice); 
			     $("#F_BuyCount").val(obj.F_BuyCount); 
			     $("#F_Cost").val(obj.F_Cost); 
			     $("#F_Message").val(obj.F_Message); 
			     $("#F_Status").val(obj.F_Status); 
			     $("#CREATE_DATE").val(obj.CREATE_DATE); 
						 
		
		getPicFile("TB_ORDER",obj.F_ORDER_UID);
    }
	
	function getPicFile(table,table_uid_value){
		$.ajax({
			url : "${ctx}/tbPicturesController/getPicture.do?TABLE="+table+"&TABLE_UID_VALUE="+table_uid_value,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				$("#detail-pictures").empty();
				response.forEach(function(ele,index){
					$("#detail-pictures")
					.append($('<div class="col-sm-4" id="'+ele.PICTURES_ID+'"><img src="<%=rootFile%>/'+ele.PATH+'"  width="100%" height="180px"></div>')); 
					$("#editForm").append($('<input type="hidden" name="PICTURES_ID" id="'+ele.PICTURES_ID+'_input"  value="'+ele.PICTURES_ID+'"/>'));
				});
				
			}
		});  
	}
	
	function deletePic(PICTURES_ID,table,table_uid_value){
		
		$.ajax({
			url : "${ctx}/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				if(!response.iserror){
					if(table_uid_value!=''&&table_uid_value!='undefined'){
						//getPicFile(table,table_uid_value);
					}else{
						
					} 
					var pic = "#"+PICTURES_ID; 
					$(pic).remove(); 
					//<input type="hidden" name="PICTURES_ID" id="PICTURES_ID" />
					var p_input = "#"+PICTURES_ID+"_input";
					console.info($(p_input));
					//$("#editForm").remove($(p_input));
					$(p_input).remove();
					
				} 
				
			}
		});  
	}
	
	//����
	function update(){
		 
		$.ajax({
			url : "${ctx}/tborder/tbOrderController/edit.do",
			data : $("#editForm").serialize(),
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				 console.info(typeof response);
				 if(!response.iserror){
					alert("上传成功");
					$("#editClose").click();
					$("#INDEX_Form").submit();
				} 
			}
		});  
		 
	}
	 
 
 </script>
