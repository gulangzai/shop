$(document).ready(function () {
	   
JqgridManager.init(jqGrid);
	  
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
 
       //是否下线 
   function  isF_Status(cellvalue, opts, rowObject){
	   var showHtml ="";
   if(rowObject.F_Status=='0'){
		showHtml +=  "<div  class='btn btn-default btn-sm'>正常售出</div>"; 
   }else{
	    showHtml +=  "<div  class='btn btn-default btn-sm'>下线</div>";
   		    
	   }  
		return 	showHtml;
   }
   //是否特卖
   function isF_IsSpecial(cellvalue, opts, rowObject){
	   var showHtml ="";
   if(rowObject.F_IsSpecial=='0'){
		showHtml +=  "<div  class='btn btn-default btn-sm'>特卖</div>"; 
   }else{
	    showHtml +=  "<div  class='btn btn-default btn-sm'>不特卖</div>";
   		    
	   } 
	
		return 	showHtml;
   }
   
   function doReportInfo(cellvalue, opts, rowObject){
	   var F_PRODUCT_ID = rowObject.F_PRODUCT_ID; 
		var showHtml =  "<button type='button' class='btn btn-default btn-sm' onclick='edit("+F_PRODUCT_ID+")'>";
	showHtml +="<span class='glyphicon glyphicon-edit'></span>";
	showHtml +="</button>";
	showHtml +="<button type='button' class='btn btn-default btn-sm' onclick='del("+F_PRODUCT_ID+")'>";
	showHtml +="<span class='glyphicon glyphicon-remove'></span>";
	showHtml +="</button>";
	
		return 	showHtml;
	}
   
	
	$(top.hangge());
	
	//检索
function search(){
	// jQuery("#jqGrid").jqGrid().trigger("reloadGrid");
	/*top.jzts();*/
	var keyword = $("#KEYWORD").val(); 
	$("#jqGrid").jqGrid('setGridParam',{  
            datatype:'json',  
            postData:{'KEYWORD':encodeURI(encodeURI(keyword))}, //发送数据  
            page:1  
        }).trigger("reloadGrid");     //重新载入  
}

//新增
function add(){
	
	
    $('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	});
	
	$.get(ctx+"/tbProductController/goAddView.do",function(data) {
		$("#edit-form").empty();
		$("#edit-form").html("");
		$("#edit-form").html(data);
	}); 
 
}

//删除
function del(Id){
	bootbox.confirm("确定要删除吗?", function(result) {
		if(result) { 
		 
			$.ajax({
				type: "POST",
				url: ctx+"/tbProductController/delete.do?F_PRODUCT_ID="+Id+"&tm="+new Date().getTime(),
		         dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(response){
					  
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
	
	//下拉框
	//$(".chzn-select").chosen(); 
	//$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	
	//日期框
	//$('.date-picker').datepicker();
	
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
			var sel_ids = $('#jqGrid').jqGrid('getGridParam', 'selarrrow'); 
			for(var i=0;i<sel_ids.length;i++){
				var rowData =  $("#jqGrid").jqGrid("getRowData",sel_ids[i]);  
				if(str==''){
					 str += rowData.F_PRODUCT_ID;
				} else{
					 str += ',' + rowData.F_PRODUCT_ID;
				}  
			} 
			if(str==''){ 
				bootbox.dialog({  
	                message: "您没有选择任何内容",  
	                title: "提示",  
	                buttons: {  
	                    Cancel: {  
	                        label: "关闭",  
	                        className: "btn-default",  
	                        callback: function () {  
	                            //alert("Cancel");  
	                        }  
	                    }  
	                }  
	            });   
				return;
			}else{
				if(msg == '确定要删除选中的数据吗?'){ 
					$.ajax({
						type: "POST",
						url: ctx+'/tbProductController/deleteAll.do?tm='+new Date().getTime(),
				    	data: {DATA_IDS:str},
						dataType:'json', 
						cache: false,
						success: function(data){
							  console.info(data);
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

//修改
function edit(Id){
    $('#edit').attr("data-target","edit-form");
	$('#edit-form').removeData("bs.modal");
	$("#edit-form").empty();
	$('#edit-form').modal({
		backdrop: 'static'
	});
	 
	
   $.get(ctx+"/tbProductController/goEditView.do?F_PRODUCT_ID="+Id,function(data) {
			$("#edit-form").empty();
			$("#edit-form").html("");
			$("#edit-form").html(data);
    });  
} 



//导出excel
function toExcel(){
	window.location.href= ctx+'/tbProductController/excel.do';
}

function reload(){
	jQuery("#jqGrid").jqGrid().trigger("reloadGrid");
}