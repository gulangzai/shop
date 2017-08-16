 $(function(){  
	 init();
 });
 
 function init(){     
		var data1={F_ClsId: $("#Edit_F_ClsId").val()};
		$.ajax({
			url : ctx+"/goodClass/goEdit.do",
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
	
function setValue(classObj){  
	if(classObj.F_Status=='1'){
		$("#F_Status_label1").attr("checked",'true');
		$("#F_Status").val("1");
	}else{
		$("#F_Status_label0").attr("checked",'true');
		$("#F_Status").val("0");
	}  
	$("#Edit_F_PClsId").val(classObj.F_PClsId);
	$("#F_ClsName").val(classObj.F_ClsName); 
	$("#F_CODE").val(classObj.F_CODE); 
	$("#F_LABEL").val(classObj.F_LABEL); 
}

 

function saveEdit(){
	var validForm = FormValid.validbyFormId($("#Form_tbclass_edit"));  
	var status = $("input[type='radio']:checked").val(); 
	if(validForm.check()){  
		$.post(ctx+'/goodClass/edit',
		  {
			F_ClsId:$("#Edit_F_ClsId").val(),
			F_ClsName:$("#F_ClsName").val(), 
			F_Order:$("#F_Order").val(),
			F_PClsId:$("#Edit_F_PClsId").val(),
			F_Status:status,
			F_CODE:$("#F_CODE").val(),
			F_LABEL:$("#F_LABEL").val()
		  },function(data,status){ 
			  if(data.result=="ok"){   
				  $("#editClose").click();
					reload();  
			  }   
		});
	}
} 
 

 