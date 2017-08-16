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
	   //所有的input都禁止编辑
	$("#execute_tableDetail input").each(function() { 
	   $(this).attr("disabled", "disabled"); 
	}); 
	$("#execute_tableDetail textarea").each(function() { 
	   $(this).attr("disabled", "disabled"); 
	}); 
	$("#execute_tableDetail select").each(function() { 
	   $(this).attr("disabled", "disabled"); 
	}); 
	
	 DatePicker.datepicker(".REPORT_DATE1"); 
     DatePicker.datepicker(".REPORT_DATE2");   
     setStyle($("#execute_tableDetail"));
}

function initEditListener(){ 
    setFormValues(); 
}



function setFormValues(){
	var data = combineQuery.getQueryCombineData(tableDetailForm,null,null);
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
			$("#execute_tableDetail").find($("#FXY_TYPE")).val(resultobj.FXY_TYPE);
			
			$("#execute_tableDetail_WXYS_FL").val(resultobj.WXYS_FL);
			$("#execute_tableDetail").find($("#WXYS")).text(resultobj.WXYS); 
			$("#execute_tableDetail_SHIGU").find("option[text='"+resultobj.SHIGU+"']").attr("selected",true); 
			$("#execute_tableDetail_SHIGU").val(resultobj.SHIGU);
			$("#execute_tableDetail_QUYU").find("option[text='"+resultobj.QUYU+"']").attr("selected",true); 
			$("#execute_tableDetail_QUYU").val(resultobj.QUYU); 
			//$("#execute_tableEdit_SHIGU option[text='"+resultobj.SHIGU+"']").attr("selected", true);   
			 console.log($("#execute_tableEdit_SHIGU"));
			//$("#execute_tableEdit").find($("#SHIGU")).val(resultobj.SHIGU);
			$("#execute_tableDetail").find($("#CUOSHI")).text(resultobj.CUOSHI); 
			$("#execute_tableDetail").find($("#YIJIN_YUAN")).text(resultobj.YIJIN_YUAN); 
			$("#execute_tableDetail_BEGIN_DATE").val(resultobj.BEGIN_DATE);
			$("#execute_tableDetail_END_DATE").val(resultobj.END_DATE);
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