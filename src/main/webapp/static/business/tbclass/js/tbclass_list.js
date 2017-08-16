$(document).ready(function () {
	   
   JqgridManager.init(jqGrid,queryForm);
	  
	  //改变浏览器大小自适应
   $(window).on(
  			'resize.jqGrid',
  			function() {
  				$("#jqGrid").jqGrid(    //jqGridtable 自适应width
  						'setGridWidth',
  						$("#inside").width());
  			});
  	$(window).triggerHandler('resize.jqGrid');
}); 


$(function() {
		
		//下拉框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		//日期框
		$('.date-picker').datepicker();
		
		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
				
		});
		
	});
	
	
//批量操作
function makeAll(msg){
	bootbox.confirm(msg, function(result) {
		if(result) {
			var str = '';
			var emstr = '';
			var phones = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	
				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
				  	
				  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
				  	else phones += ';' + document.getElementsByName('ids')[i].alt;
				  }
			}
			if(str==''){
				bootbox.dialog("您没有选择任何内容!", 
					[
					  {
						"label" : "关闭",
						"class" : "btn-small btn-success",
						"callback": function() {
							//Example.show("great success");
							}
						}
					 ]
				);
				
				$("#zcheckbox").tips({
					side:3,
		            msg:'点这里全选',
		            bg:'#AE81FF',
		            time:8
		        });
				
				return;
			}else{
				if(msg == '确定要删除选中的数据吗?'){ 
					$.ajax({
						type: "POST",
						url: ctx+'/happuser/deleteAllU.do?tm='+new Date().getTime(),
				    	data: {USER_IDS:str},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							reload();
						}
					});
				}else if(msg == '确定要给选中的用户发送邮件吗?'){
					sendEmail(emstr);
				}else if(msg == '确定要给选中的用户发送短信吗?'){
					sendSms(phones);
				}
				
			}
		}
	});
}
		
//导出excel
function toExcel(){
	var USERNAME = $("#nav-search-input").val();
	var lastLoginStart = $("#lastLoginStart").val();
	var lastLoginEnd = $("#lastLoginEnd").val();
	var ROLE_ID = $("#role_id").val();
	var STATUS = $("#STATUS").val();
	window.location.href=ctx+'/happuser/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID+'&STATUS='+STATUS;
}
		
 
		
		//检索
function search(){ 
	reload();
}

//去发送电子邮件页面
function sendEmail(EMAIL){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送电子邮件";
	 diag.URL = '${ctx}/head/goSendEmail.do?EMAIL='+EMAIL+'&msg=appuser';
	 diag.Width = 660;
	 diag.Height = 470;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//去发送短信页面
function sendSms(phone){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送短信";
	 diag.URL = '${ctx}/head/goSendSms.do?PHONE='+phone+'&msg=appuser';
	 diag.Width = 600;
	 diag.Height = 265;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//新增
function add(){ 
	 $('#edit').attr("data-target","edit-form");
		$('#edit-form').removeData("bs.modal");
		$("#edit-form").empty();
		$('#edit-form').modal({
			backdrop: 'static'
		}); 
	   $.get(ctx+"/jsp/business/goodClass/tbclass_add.jsp?F_ClsId="+F_ClsId,function(data) {
				$("#edit-form").empty();
				$("#edit-form").html("");
				$("#edit-form").html(data);
	    });  
}

//修改
function editClass(F_ClsId){ 
    $('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	}); 
   $.get(ctx+"/jsp/business/goodClass/tbclass_edit.jsp?F_ClsId="+F_ClsId,function(data) {
			$("#edit-form").empty();
			$("#edit-form").html("");
			$("#edit-form").html(data);
    }); 
   
}

//删除
function delClass(fClsId,msg){
	if(msg==undefined){
		msg = fClsId;
	}
	bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
		if(result) { 
			var url = ctx+"/goodClass/deleteClass.do?F_ClsId="+fClsId+"&tm="+new Date().getTime();
			$.get(url,function(data){  
				reload();
			});
		}
	});
} 


function doReportInfo(cellvalue, opts, rowObject){ 
	   var F_ClsId = rowObject.fClsId; 
		var showHtml =  "<label type='button' class='btn btn-default btn-sm' onclick='editClass("+F_ClsId+")'>";
	showHtml +="<span class='glyphicon glyphicon-edit'></span>";
	showHtml +="</label>";
	showHtml +="<label type='button' class='btn btn-default btn-sm' onclick='delClass("+F_ClsId+")'>";
	showHtml +="<span class='glyphicon glyphicon-remove'></span>";
	showHtml +="</label>";
	
		return 	showHtml;
}

//是否可用
function statusFormatter(cellvalue, opts, rowObject){
	   var showHtml ="";
	   if(rowObject.fStatus=='1'){
				showHtml +=  "<div  class='btn btn-default btn-sm'>可用</div>"; 
		}else{
			    showHtml +=  "<div  class='btn btn-default btn-sm'>停用</div>"; 
	   }  
	   return 	showHtml;
}

var F_ClsId;
var F_PclsId;
function flush(fClsId){ 
	$("#F_ClsId").val(fClsId); 
	F_ClsId = fClsId;
	F_PclsId = fClsId;
	reload();
}


function reload(){
	JqgridManager.reload(jqGrid,queryForm); 
	 
	//jQuery("#jqGrid").jqGrid().trigger("reloadGrid");
}