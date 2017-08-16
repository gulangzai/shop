var form; 
$(function(){ 
	 form = FormValid.validbyFormId("#editForm"); 
	 init(); 
	  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
 });
 
 function init(){ 
		var data1={id:$("#id").val()};
		$.ajax({
			url : ctx+"/tbmenu/tbMenuController/goEdit.do",
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
			     $("#id").val(obj.id); 
			     $("#parent").val(obj.parent); 
			     $("#name").val(obj.name); 
			     $("#F_MENU_URL").val(obj.F_MENU_URL); 
			     $("#F_MENU_ICON").val(obj.F_MENU_ICON); 
			     $("#level").val(obj.level); 
			     $("#F_STATUS").val(obj.F_STATUS);  
    }
	
	function getPicFile(table,table_uid_value){
		$.ajax({
			url : ctx+"/tbPicturesController/getPicture.do?TABLE="+table+"&TABLE_UID_VALUE="+table_uid_value,
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
	
	//update
	function update(){ 
		form = FormValid.validbyFormId("#editForm");  
		if(form.check()&&!$("input").hasClass("Validform_error")){
			$.ajax({
				url : ctx+"/tbmenu/tbMenuController/edit.do",
				data : $("#editForm").serialize(),
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					 console.info(typeof response);
					 if(!response.iserror){ 
						xAlert("信息提示","修改成功",1);
						$("#editClose").click();
						reload();
					} else{
						xAlert("信息提示","修改失败",1);
					}
				}
			});  
		}
	}