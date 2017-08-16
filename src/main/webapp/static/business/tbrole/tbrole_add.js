$(top.hangge());
$(function() { 
	//单选框
	$(".chzn-select").chosen(); 
	$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	
	//日期框
	$('.date-picker').datepicker();
	
	//保存
	
	
});

function save(){ 
	var validForm = FormValid.validbyFormId($("#Form_role_add")); 
	if(validForm.check()){ 
		$("#Form_role_add").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	} 
}
