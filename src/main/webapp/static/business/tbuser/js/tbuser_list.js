$(document).ready(function () {
	       JqgridManager.init(jqGrid);
	       window.onresize = function(){ 
	    	   reload(); 
	       }  
	       
	      //改变浏览器大小自适应
	  	  $(window).on(
	  				'resize.jqGrid',
	  				function() {
	  					$("#jqGrid").jqGrid(    //jqGridtable 自适应width
	  							'setGridWidth',
	  							$("#INDEX_Form").width());
	  				});
	  		$(window).triggerHandler('resize.jqGrid'); 
	  		
});
	   
function doReportInfo(cellvalue, opts, rowObject){
	var F_USER_ID = rowObject.F_USER_ID;  
	var showHtml = "";
	//showHtml +=showHtml+"<button type='button' class='btn btn-default btn-sm' onclick='see("+F_ORDER_UID+")'>";
	//showHtml +="<span class='glyphicon  glyphicon glyphicon-file'></span>";
	//showHtml +="</button>";
	
	showHtml +="<button type='button' class='btn btn-default btn-sm' onclick=\"toRole('"+F_USER_ID+"')\">";
	showHtml +="<span class='glyphicon glyphicon glyphicon-cog'></span>";
	showHtml +="</button>&nbsp;";
	
	
	showHtml +=  "<button type='button' class='btn btn-default btn-sm' onclick=\"edit('"+F_USER_ID+"')\">";
	showHtml +="<span class='glyphicon glyphicon-edit'></span>";
	showHtml +="</button>&nbsp;";

	showHtml +="<button type='button' class='btn btn-default btn-sm' onclick=\"del('"+F_USER_ID+"')\">";
	showHtml +="<span class='glyphicon glyphicon-remove'></span>";
	showHtml +="</button>"; 
	return 	showHtml;
}

function toRole(F_USER_ID){ 
  	$("#edit-form").attr("class","modal");
	$("#edit-form").removeData("bs.modal");
	$("#edit-form").empty();
	$("#edit-form").modal({
		backdrop: 'static'
	}); 
	 
	$.get(ctx+"/tbrole/tbRoleController/toUserRole.do?F_USER_ID="+F_USER_ID,function(data){  
		$("#edit-form").empty();
		$("#edit-form").html("");
		$("#edit-form").html(data); 
	});
}

function FStatusFormatter(cellvalue, opts, rowObject){
    var F_NOTICE_LEVEL = rowObject.F_NOTICE_LEVEL;   
    var status = "一般";
    if(F_NOTICE_LEVEL==0){
    	status="一般";
    }else if(F_NOTICE_LEVEL==1){
    	status="重要";
    } 
	var showHtml = "";
	showHtml +="<span class='glyphicon'>"+status+"</span>";  
	return 	showHtml;
}

function FDeletedFormatter(cellvalue, opts, rowObject){
    var F_Deleted = rowObject.F_Deleted;   
    var status = "可用";
    if(F_Deleted=='1'){
    	status="可用";
    }else if(F_Deleted=='0'){
    	status="停用";
    } 
	var showHtml = "";
	showHtml +="<span class='glyphicon'>"+status+"</span>";  
	return 	showHtml;
}

function FUserNameFormatter(cellvalue, opts, rowObject){
    var F_UserName = rowObject.F_UserName;  
    var F_USER_ID = rowObject.F_USER_ID;
	var showHtml = "";
	showHtml +="<span class='glyphicon'><a href='javascript:void(0)' onclick=\"see('"+F_USER_ID+"')\">"+F_UserName+"</a></span>";  
	return 	showHtml;
}



function dateFormatter(cellvalue, options, row){
	 return new Date(cellvalue).Format("yyyy-MM-dd hh:mm:ss");
}

$(top.hangge());

//search
function search(){
	  var keyword=$("#KEYWORD").val();
      $("#jqGrid").jqGrid('setGridParam',{  
            datatype:'json',  
            postData:{'search':true,'keyword':keyword}, //发送数据  
            page:1  
      }).trigger("reloadGrid"); //重新载入  
}

//add
function add(id){
    $('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	});
	
  $.get(ctx+"/tbuser/tbUserController/goAddView.do?F_USER_ID="+id,function(data) {
    	$("#edit-form").empty();
		$("#edit-form").html("");
		$("#edit-form").html(data);
	});
}

		//edit
function edit(Id){
    $('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	});
	
    $.get(ctx+"/tbuser/tbUserController/goEditView.do?F_USER_ID="+Id,function(data) {
		$("#edit-form").empty();
		$("#edit-form").html("");
		$("#edit-form").html(data);
		});   
	 
	} 
	

   function see(Id){
	$('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	});
	
    $.get(ctx+"/tbuser/tbUserController/goDetailView.do?F_USER_ID="+Id,function(data) {
		$("#edit-form").empty();
		$("#edit-form").html("");
		$("#edit-form").html(data);
	});   
 
} 

//del
function del(Id){
	bootbox.confirm("确定要删除吗?", function(result) {
		if(result) { 
			var url = ctx+"/tbuser/tbUserController/delete.do?F_USER_ID="+Id+"&tm="+new Date().getTime();
			 
		 	$.ajax({
				url : url,
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) { 
					 if(!response.iserror){
						xAlert("信息提示","删除成功",1); 
						reload();
					} 
				}
			});  
			
		}
	});
}




 
$(function() { 
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


//makeAll
function makeAll(msg){
	bootbox.confirm(msg, function(result) {
		if(result) { 
			var str = '';
			var sel_ids = $('#jqGrid').jqGrid('getGridParam', 'selarrrow'); 
			for(var i=0;i<sel_ids.length;i++){
				var rowData =  $("#jqGrid").jqGrid("getRowData",sel_ids[i]);  
				if(str==''){
					 str += rowData.F_USER_ID;
				} else{
					 str += ',' + rowData.F_USER_ID;
				}  
			} 
			
			if(str==''){
				bootbox.dialog({
					message:"您没有选择任何内容!", 
					title: "确定框",  
					buttons:{
					  Cancel:{
						label : "关闭",
						className : "btn-small btn-success",
						callback: function() {
							//Example.show("great success");
							}
						} 
					}
				});
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
						url: ctx+'/tbnotice/tbUserController/deleteAll.do?tm='+new Date().getTime(),
				    	data: {DATA_IDS:str},
						dataType:'json', 
						cache: false,
						success: function(data){
							console.info(data);
							console.info(data.msg);
							  reload();
							  if(data.msg=='ok'){
								  xAlert("信息提示","批量删除成功",1); 
							  }else{
								  xAlert("信息提示","批量删除失败",1); 
							  } 
						}
					});
				}
			}
		}
	});
}





//导出excel
function toExcel(){
	window.location.href=ctx+'/tbuser/tbUserController/excel.do';
}

function reload(){
	jQuery("#jqGrid").jqGrid().trigger("reloadGrid");
}