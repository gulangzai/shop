var validform; 
controllernameUrl=controllernameUrl+'pmfxy/pmFxyController';
  
 
var scripts =[null];
ace.load_ajax_scripts(scripts, function() {  
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
    initEditPara(); 
    initEditListener();   
}); 

function initEditPara(){
	 DatePicker.datepicker(".REPORT_DATE1"); 
     DatePicker.datepicker(".REPORT_DATE2");   
     setStyle($("#execute_tableEdit"));
}

function initEditListener(){
	
	 //删除多余的 div 避免弹出图片时出现多层
	var div1 = $(".jquery-lightbox-overlay").eq(0);
	var div2 = $(".jquery-lightbox-move").eq(0); 
	$(".jquery-lightbox-overlay").remove();
	$(".jquery-lightbox-move").remove();
	$("body").append(div1);
	$("body").append(div2);
	
	validform=FormValid.validbyformid(execute_tableEdit); 
	$("#tableEditSave").click(function(){ 
		
		var BEGIN_DATE = $("#execute_tableEdit_BEGIN_DATE").val();
		var END_DATE = $("#execute_tableEdit_END_DATE").val();  
		var d1 = new Date(BEGIN_DATE.replace(/\-/g, "\/"));
		var d2 = new Date(END_DATE.replace(/\-/g, "\/")); 
	  
		  if(validform.check()){
			if($("#yanshouseeFormResult").validationButton()) {
				//生成json串
				var data = Form2Json.formToJSON(execute_tableEdit);
				//组成保存json串格式
				var data1 = defaultJson.packSaveJson(data); 
				$.ajax({
					url :controllernameUrl+"?update",
					data : data1,
					cache : false,
					async :	false,
					dataType : "json",  
					type : 'post',
					success : function(response) { 
				      xAlert("信息提示","提交成功",1);
					  $("#btnCloseXcJd").click();
					  jQuery("#grid_table").jqGrid().trigger("reloadGrid"); 
					}
				});  
			}
		   }else {
			   xAlert("信息提示","验收日期小于复查日期",1);
			   return;
		   }
		 
    }); 
	
    setFormValues(); 
}



function setFormValues(){
	var data = combineQuery.getQueryCombineData(tableEditForm,null,null);
	var data1={msg:data};
	$.ajax({
		url : controllernameUrl+"?query",
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		success : function(response) {
			var resultobj = defaultJson.dealResultJson(response.msg); 
			$("#execute_tableEdit").find($("#FXY_TYPE")).val(resultobj.FXY_TYPE);
			
			$("#execute_tableEdit_WXYS_FL").val(resultobj.WXYS_FL);
			$("#execute_tableEdit").find($("#WXYS")).text(resultobj.WXYS); 
			$("#execute_tableEdit_SHIGU").find("option[text='"+resultobj.SHIGU+"']").attr("selected",true); 
			$("#execute_tableEdit_SHIGU").val(resultobj.SHIGU);
			$("#execute_tableEdit_QUYU").find("option[text='"+resultobj.QUYU+"']").attr("selected",true); 
			$("#execute_tableEdit_QUYU").val(resultobj.QUYU); 
			//$("#execute_tableEdit_SHIGU option[text='"+resultobj.SHIGU+"']").attr("selected", true);   
			// console.log($("#execute_tableEdit_SHIGU"));
			//$("#execute_tableEdit").find($("#SHIGU")).val(resultobj.SHIGU);
			$("#execute_tableEdit").find($("#CUOSHI")).text(resultobj.CUOSHI); 
			$("#execute_tableEdit").find($("#YIJIN_YUAN")).text(resultobj.YIJIN_YUAN); 
			$("#execute_tableEdit_BEGIN_DATE").val(resultobj.BEGIN_DATE);
			$("#execute_tableEdit_END_DATE").val(resultobj.END_DATE);
			//$("#execute_tableEdit").setFormValues(resultobj);
			queryFileData('PM_FXY',resultobj.FXY_UID); 
		}
	});
}


function selectFile_s(obj){ 
	
	$('#xmgk-save').removeData("bs.modal");
	$("#xmgk-save").empty();
	$('#xmgk-save').modal({
		backdrop: 'static'
	}); 
    var target_table = $("#TARGET_TABLE").val();
    var target_col = "FXY_UID"; 
    var target_uid = $("#target_uid" ).val();
    var project_uid = $("#project_uid").val();
	var file_type = $(obj).attr('file_type');

   
	$.get(ctx+"/jsp/business/pmfxy/pm_fxy_shangchuan.jsp?target_table="+target_table+"&target_col="+target_col+"&target_uid="+target_uid+"&project_uid="+project_uid+"&file_type="+file_type,function(data) {
		$("#xmgk-save").empty();
		$("#xmgk-save").html("");
		$("#xmgk-save").html(data);
	});
}

function _reload(){
	jQuery("#grid_table").jqGrid().trigger("reloadGrid");
}