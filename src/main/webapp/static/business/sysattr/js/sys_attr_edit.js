 $(function(){  
	 init();
	 $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
	 
 });
 
 function init(){  
		var data1={F_ATTR_UID: $("#F_ATTR_UID").val()};
		$.ajax({
			url : ctx+"/sysattr/sysAttrController/goEdit.do",
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
     $("#F_ATTR_UID").val(obj.F_ATTR_UID); 
     $("#F_ATTR_TABLE").val(obj.F_ATTR_TABLE); 
     $("#F_ATTR_NAME").val(obj.F_ATTR_NAME);  
}
	
 
	
 
//保存
function update(){ 
	$.ajax({
		url : ctx+"/sysattr/sysAttrController/edit.do",
		data : $("#editForm").serialize(),
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			 console.info(typeof response);
			 if(!response.iserror){
				 xAlert("信息提示","上传成功",1);
				$("#editClose").click();
				reload();
			} 
		}
	});  
	 
}