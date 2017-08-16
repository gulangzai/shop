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
                                                查看收货地址
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbaddress/tbAddressController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_ADDRESS_UID" id="F_ADDRESS_UID" value="${pd.F_ADDRESS_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">地区:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_DIQU"  name="F_DIQU"  value="${pd.F_DIQU}"  placeholder="��������地区" title="地区">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_USER_ID"  name="F_USER_ID"  value="${pd.F_USER_ID}"  placeholder="��������用户账号" title="用户账号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">详细地址:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_ADDRESS_DETAIL"  name="F_ADDRESS_DETAIL"  value="${pd.F_ADDRESS_DETAIL}"  placeholder="��������详细地址" title="详细地址">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">邮政编码:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_POSTAL_CODE"  name="F_POSTAL_CODE"  value="${pd.F_POSTAL_CODE}"  placeholder="��������邮政编码" title="邮政编码">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">收件人:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_RECEIVE_NAME"  name="F_RECEIVE_NAME"  value="${pd.F_RECEIVE_NAME}"  placeholder="��������收件人" title="收件人">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">手机号:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="F_RECEIVE_MOBILE"  name="F_RECEIVE_MOBILE"  value="${pd.F_RECEIVE_MOBILE}"  placeholder="��������手机号" title="手机号">
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
		var data1={F_ADDRESS_UID:'${pd.F_ADDRESS_UID}'};
		$.ajax({
			url : "${ctx}/tbaddress/tbAddressController/goEdit.do",
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
			     $("#F_DIQU").val(obj.F_DIQU); 
			     $("#F_USER_ID").val(obj.F_USER_ID); 
			     $("#F_ADDRESS_DETAIL").val(obj.F_ADDRESS_DETAIL); 
			     $("#F_POSTAL_CODE").val(obj.F_POSTAL_CODE); 
			     $("#F_RECEIVE_NAME").val(obj.F_RECEIVE_NAME); 
			     $("#F_RECEIVE_MOBILE").val(obj.F_RECEIVE_MOBILE); 
			     $("#CREATE_DATE").val(obj.CREATE_DATE); 
						 
		
		getPicFile("TB_ADDRESS",obj.F_ADDRESS_UID);
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
			url : "${ctx}/tbaddress/tbAddressController/edit.do",
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
