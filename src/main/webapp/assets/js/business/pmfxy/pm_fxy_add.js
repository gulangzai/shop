var validform; 
controllernameUrl=controllernameUrl+'pmfxy/pmFxyController';

/** modal高度自适应 */
$("#information").css('max-height',$(window).height()-210 +'px');
 
var scripts =[null];
ace.load_ajax_scripts(scripts, function() {  
    initAddPara(); 
    initAddListener();  
    adjustDialog();
    
}); 

function adjustDialog(){ 
	console.info($("#inside"));
	var inside = document.getElementById("inside");
	var pop_title = $(".pop_title").height();
	var modal_footer=$(".modal-footer").height();
    var height = inside.offsetHeight;  
	 var top = 50;
	 //$("#pmFxyAdd").css("top",top);  
	 $("#information").height(height-2*top-pop_title-modal_footer);
}


function initAddPara(){
	 DatePicker.datepicker(".REPORT_DATE1"); 
     DatePicker.datepicker(".REPORT_DATE2");   
     DatePicker.datepicker(".dataPicker");
     setStyle($("#executetableAdd"));
}




function initAddListener(){ 
	
	validform=FormValid.validbyformid(executetableAdd);  
	$("#btnAddtable").click(function() {
		var BEGIN_DATE = $("#ADD_BEGIN_DATE").val();
		var END_DATE = $("#ADD_END_DATE").val();  
		var d1 = new Date(BEGIN_DATE.replace(/\-/g, "\/"));
		var d2 = new Date(END_DATE.replace(/\-/g, "\/")); 
		if(d1>d2){
		   xAlert("信息提示", "结束日期必须大于开始日期", 1);
		   return;
	   }
	  if(validform.check()){
		if($("#executetableAdd").validationButton()) {
			//生成json串
			var data = Form2Json.formToJSON(executetableAdd);
			//组成保存json串格式
			var data1 = defaultJson.packSaveJson(data);
			$.ajax({
				url :controllernameUrl+"?insert",
				data : data1,
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					xAlert("信息提示","风险源添加成功",1);
					$("#btnClosetableadd").click();
					_reload();
			      }
			});
			
		 }
	   }else { 
		   return;
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