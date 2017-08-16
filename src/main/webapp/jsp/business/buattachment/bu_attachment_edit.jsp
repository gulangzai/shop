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
                                             编辑附件表
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/buattachment/buAttachmentController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_ADDRESS_UID" id="F_ADDRESS_UID" value="${pd.F_ADDRESS_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件UID:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="ATTACHMENT_UID"  name="ATTACHMENT_UID"  value="${pd.ATTACHMENT_UID}"  placeholder="请填写附件UID" title="附件UID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件名:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="FILE_NAME"  name="FILE_NAME"  value="${pd.FILE_NAME}"  placeholder="请填写文件名" title="文件名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件扩展名:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="FILE_EXT_NAME"  name="FILE_EXT_NAME"  value="${pd.FILE_EXT_NAME}"  placeholder="请填写文件扩展名" title="文件扩展名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件地址:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="FILE_PATH"  name="FILE_PATH"  value="${pd.FILE_PATH}"  placeholder="请填写文件地址" title="文件地址">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件的MIME_TYPE:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="MIME_TYPE"  name="MIME_TYPE"  value="${pd.MIME_TYPE}"  placeholder="请填写文件的MIME_TYPE" title="文件的MIME_TYPE">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件大小:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="FILE_SIZE"  name="FILE_SIZE"  value="${pd.FILE_SIZE}"  placeholder="请填写文件大小" title="文件大小">
						          </div>  
						       </div>
						     <div class="form-group">
						          <label class="col-sm-2 control-label">创建时间:</label>
						          <div class="col-sm-4">  
						             <input type="text" class="form-control CREATE_DATE" id="CREATE_DATE"  name="CREATE_DATE"  value="${pd.CREATE_DATE}"  placeholder="锟斤拷锟斤拷锟斤拷锟斤拷创建时间" title="创建时间">
						          </div>  
						       </div>
						  
					       <div class="form-group">
						          <label class="col-sm-2 control-label">创建人:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="CREATE_USER"  name="CREATE_USER"  value="${pd.CREATE_USER}"  placeholder="请填写创建人" title="创建人">
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
 
 
 <script type="text/javascript">
 
 $(function(){ 
	 init();
	 
	  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
	 
	 
 });
 
 function init(){ 
		var data1={F_ADDRESS_UID:'${pd.F_ADDRESS_UID}'};
		$.ajax({
			url : "${ctx}/buattachment/buAttachmentController/goEdit.do",
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
			     $("#ATTACHMENT_UID").val(obj.ATTACHMENT_UID); 
			     $("#FILE_NAME").val(obj.FILE_NAME); 
			     $("#FILE_EXT_NAME").val(obj.FILE_EXT_NAME); 
			     $("#FILE_PATH").val(obj.FILE_PATH); 
			     $("#MIME_TYPE").val(obj.MIME_TYPE); 
			     $("#FILE_SIZE").val(obj.FILE_SIZE); 
			     $("#CREATE_DATE").val(obj.CREATE_DATE); 
			     $("#CREATE_USER").val(obj.CREATE_USER); 
						 
		
		getPicFile("BU_ATTACHMENT",obj.F_ADDRESS_UID);
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
				$("#pictures").empty();
				response.forEach(function(ele,index){
					$("#pictures")
					.append($('<div class="col-sm-4" id="'+ele.PICTURES_ID+'"><img src="<%=rootFile%>/'+ele.PATH+'"  width="100%" height="180px"><p><button class="btn btn-default"  onclick="deletePic(\''+ele.PICTURES_ID+'\',\''+table+'\',\''+table_uid_value+'\')">x</button></p></div>')); 
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
	
	//update
	function update(){
		 
		$.ajax({
			url : "${ctx}/buattachment/buAttachmentController/edit.do",
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
