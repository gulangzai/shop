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
                                                查看文件表
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/bufile/buFileController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="FILE_UID" id="FILE_UID" value="${pd.FILE_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件UID:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="FILE_UID"  name="FILE_UID"  value="${pd.FILE_UID}"  placeholder="��������文件UID" title="文件UID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件所属对象表名:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="TARGET_TABLE"  name="TARGET_TABLE"  value="${pd.TARGET_TABLE}"  placeholder="��������附件所属对象表名" title="附件所属对象表名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件所属对象列名:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="TARGET_COL"  name="TARGET_COL"  value="${pd.TARGET_COL}"  placeholder="��������附件所属对象列名" title="附件所属对象列名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件所属对象ID:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="TARGET_UID"  name="TARGET_UID"  value="${pd.TARGET_UID}"  placeholder="��������附件所属对象ID" title="附件所属对象ID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">文件类型:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="FILE_TYPE"  name="FILE_TYPE"  value="${pd.FILE_TYPE}"  placeholder="��������文件类型" title="文件类型">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件类别名称:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="FILE_TYPE_NAME"  name="FILE_TYPE_NAME"  value="${pd.FILE_TYPE_NAME}"  placeholder="��������附件类别名称" title="附件类别名称">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件的描述:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="DESCRIPTION"  name="DESCRIPTION"  value="${pd.DESCRIPTION}"  placeholder="��������附件的描述" title="附件的描述">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">附件ID:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="ATTACHMENT_UID"  name="ATTACHMENT_UID"  value="${pd.ATTACHMENT_UID}"  placeholder="��������附件ID" title="附件ID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">是否有效:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="ENABLED"  name="ENABLED"  value="${pd.ENABLED}"  placeholder="��������是否有效" title="是否有效">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">创建时间:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="CREATE_DATE"  name="CREATE_DATE"  value="${pd.CREATE_DATE}"  placeholder="��������创建时间" title="创建时间">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">创建人:</label>
						          <div class="col-sm-10">  
						             <input type="text" readOnly="readOnly" class="form-control" id="CREATE_USER"  name="CREATE_USER"  value="${pd.CREATE_USER}"  placeholder="��������创建人" title="创建人">
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
		var data1={FILE_UID:'${pd.FILE_UID}'};
		$.ajax({
			url : "${ctx}/bufile/buFileController/goEdit.do",
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
			     $("#FILE_UID").val(obj.FILE_UID); 
			     $("#TARGET_TABLE").val(obj.TARGET_TABLE); 
			     $("#TARGET_COL").val(obj.TARGET_COL); 
			     $("#TARGET_UID").val(obj.TARGET_UID); 
			     $("#FILE_TYPE").val(obj.FILE_TYPE); 
			     $("#FILE_TYPE_NAME").val(obj.FILE_TYPE_NAME); 
			     $("#DESCRIPTION").val(obj.DESCRIPTION); 
			     $("#ATTACHMENT_UID").val(obj.ATTACHMENT_UID); 
			     $("#ENABLED").val(obj.ENABLED); 
			     $("#CREATE_DATE").val(obj.CREATE_DATE); 
			     $("#CREATE_USER").val(obj.CREATE_USER); 
						 
		
		getPicFile("BU_FILE",obj.FILE_UID);
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
			url : "${ctx}/bufile/buFileController/edit.do",
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
