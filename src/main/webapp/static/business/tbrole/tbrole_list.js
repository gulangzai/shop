$(top.hangge());
$(function(){
	 
		// 下拉框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		// 日期框
		$('.date-picker').datepicker();
		
		// 复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
				
		});
		 
	
	
	// 批量操作
	function makeAll(msg){
		bootbox.confirm(msg, function(result) {
			if(result) {
				var str = '';
				for(var i=0;i < document.getElementsByName('ids').length;i++)
				{
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
				}
				if(str==''){
					bootbox.dialog("您没有选择任何内容!", 
						[
						  {
							"label" : "关闭",
							"class" : "btn-small btn-success",
							"callback": function() {
								// Example.show("great success");
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
						top.jzts();
						$.ajax({
							type: "POST",
							url: ctx+'/tbRoleController/deleteAll.do?tm='+new Date().getTime(),
					    	data: {DATA_IDS:str},
							dataType:'json',
							// beforeSend: validateData,
							cache: false,
							success: function(data){
								 $.each(data.list, function(i, list){
									 nextPage(page_currentPage);  
								 });
							}
						});
					}
				}
			}
		});
	}
	
	
});	
//检索
function search(){
	top.jzts();
	$("#Form").submit();
}
 

// 新增
function add(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = ctx+'/tbRoleController/goAdd.do';
	 diag.Width = 650;
	 diag.Height = 455;
	 diag.CancelEvent = function(){ // 关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location=self.location",100);
			 }else{
				  nextPage(page_currentPage); 
			 }
		}
		diag.close();
	 };
	 
	 diag.show();
}


// 修改
function edit(Id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="编辑";
	 diag.URL = ctx+'/tbRoleController/goEdit.do?F_ROLE_ID='+Id;
	 diag.Width = 650;
	 diag.Height = 455;
	 diag.CancelEvent = function(){ // 关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 //nextPage(${page.currentPage});
			 nextPage(page_currentPage); 
		}
		diag.close();
	 };
	 diag.show();
} 

//删除
function del(Id){
	bootbox.confirm("确定要删除吗?", function(result) {
		if(result) {
			top.jzts();
			var url = ctx+"/tbRoleController/delete.do?F_ROLE_ID="+Id+"&tm="+new Date().getTime();
			$.get(url,function(data){
				nextPage(page_currentPage);  
			});
		}
	});
}

//导出excel
function toExcel(){
	window.location.href=ctx+'/tbUserController/excel.do';
}

		