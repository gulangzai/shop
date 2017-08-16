$(top.hangge());
$(function() { 
	//单选框
	$(".chzn-select").chosen(); 
	$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	
	//日期框
	$('.date-picker').datepicker();
	
   
	
	$("#add_save").click(function(){
		var validForm = FormValid.validbyFormId($("#Form_user_add")); 
		var status = $("input[type='radio']:checked").val(); 
		if(validForm.check()){ 
			$("#zhongxin").hide();
			$("#zhongxin2").show(); 
			$.post(ctx+'/goodClass/add',
			  {
				F_ClsName:$("#F_ClsName").val(),
				F_PClsId:$("#F_PClsId").val(),
				F_Order:$("#F_Order").val(),
				F_Status:status,
				F_CODE:$("#F_CODE").val(),
				F_LABEL:$("#F_LABEL").val()
			  },function(data,status){ 
				  if(data.result=="ok"){  
					  $("#addClose").click();
					  reload(); 
				  }   
			});
		}
	});
	
});  
