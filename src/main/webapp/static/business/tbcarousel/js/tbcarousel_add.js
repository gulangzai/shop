 var form; 
$(function(){ 
	 form = FormValid.validbyFormId("#addForm"); 
 });
 
 $("#CREATE_DATE").datepicker({
        format: 'yyyy-mm-dd',
	    language: "zh-CN",
	    autoclose: true
 });
 
 function deletePic(PICTURES_ID,table,table_uid_value){
	
	$.ajax({
		url : ctx+"/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
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

//保存
function save(){
	  
	if(form.check()){
		$.ajax({
			url : ctx+"/tbcarousel/tbCarouselController/save.do",
			data : $("#addForm").serialize(),
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				 console.info(typeof response);
				 if(!response.iserror){
					xAlert("信息提示","保存成功",1);
					$("#editClose").click();
					reload();
				} 
			}
		});  
	} 
}
