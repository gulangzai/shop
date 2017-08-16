 var form;
 $(function(){ 
	 $("input[name='F_ISSPECIAL_label']").change(function(){ 
		 $("#F_IsSpecial").val($(this).val());
	 }); 
	  
	 $("input[name='F_Status_label']").change(function(){ 
		 $("#F_Status").val($(this).val());
	 });
	 
	 form = FormValid.validbyFormId("#addForm"); 
 });
  
	 
	//保存
	function save(){
		  
		if(form.check()){
			$.ajax({
				url : ctx+"/sysattr/sysAttrController/save.do",
				data : $("#addForm").serialize(),
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
	}