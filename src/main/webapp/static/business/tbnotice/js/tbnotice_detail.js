$(function(){ 
	 init(); 
	 $("#detailForm input[type='text']").attr("readOnly","readOnly"); 
	 $("#detailForm textarea").attr("disabled",true);
	 $("#detailForm select").attr("disabled",true);
 });
 
  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
   });
     
 
 function init(){ 
		var data1={F_NOTICE_UID: $("#F_NOTICE_UID").val()};
		$.ajax({
			url : ctx+"/tbnotice/tbNoticeController/goEdit.do",
			data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response); 
				var product = response;
				setValue(product);
			}
		});  
	}
   
	
	function setValue(obj){  
		 $("#F_NOTICE_UID").val(obj.F_NOTICE_UID); 
	     $("#F_NOTICE_TITLE").val(obj.F_NOTICE_TITLE); 
	     $("#F_NOTICE_CONTENT").val(obj.F_NOTICE_CONTENT); 
	     $("#F_CREATE_UID").val(obj.F_CREATE_UID); 
	     $("#F_CREATE_DATE").val(obj.F_CREATE_DATE); 
	     $("#F_NOTICE_TYPE").val(obj.F_NOTICE_TYPE); 
	     $("#F_NOTICE_LEVEL").val(obj.F_NOTICE_LEVEL); 
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