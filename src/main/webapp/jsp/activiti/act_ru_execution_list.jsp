
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>

 <%
String rootFile = request.getScheme()+"://"+request.getServerName()+":8088/file";
String rootFileApp = request.getScheme()+"://"+request.getServerName()+":8088/app"; 

%>
<%@ include file="/jsp/commons/common.jspf"%>  

<!DOCTYPE html>
<html lang="en">

	<head> 
<style type="text/css">
	table.imagetable {
		font-family: verdana, arial, sans-serif;
		font-size: 14px;
	}
	
	table.imagetable th {
		padding: 8px;
	}
	
	table.imagetable td {
		padding:  8px;
	}
	
	ul li{
	  float:left;
	  width:50px;
	}
	
	ol, ul {
     list-style: outside none none;
    }
</style>
	</head>
<body>



 <div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						 
  <div class="row-fluid"> 
  
	<div class="col-sm-12" id="inside">
	
			<!-- 检索  -->
			<form class="form-inline" width="100%" action="${ctx}/activitiCtrl/act_ru_execution_list_dataList.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					
					<div class="form-group">
					                                          商品名：
							   	<input class="form-control" name="KEYWORD" id="KEYWORD"   type="text"    style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="商品名"/>
							  
						 		
							  	<button class="btn  btn-link btn-sm" type="button" onclick="search();">
							  	   <i class="colorshow  ace-icon glyphicon glyphicon-search"></i>
							  	   <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">查询</span>
							  	</button>
							  	<button class="btn btn-link btn-sm" type="button"  onclick="toExcel();"> 
							      	 <i  class="colorshow  ace-icon glyphicon glyphicon-download-alt"></i>
							     	 <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">下载</span> 
					            </button>
					</div>
		  
		    </form> 
			<!-- 检索 结果 -->  
		
 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable" action="${ctx}/activitiCtrl/act_ru_execution_list_dataList.do">
		    <tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th> 
						<th name="id" align="center" width="5%">流程实例id</th>
						<th name="processDefinitionId" align="center" width="5%">流程定义id</th>
						<th name="processDefinitionName"  align="center"  width="10%">流程名</th>
						<th name="processDefinitionKey"  align="center" width="10%">流程关键字</th>
						<th name="processDefinitionVersion"  align="center"  width="10%">版本</th>
						<th name="OPERATOR"  align="center"  width="10%" formatter="doReportInfo">操作</th>
					</tr>
		</table>
		
        <div id="jqGridPager"></div>  
          
       <div class="form-inline" width="100%">  
			  <a class="btn btn-small btn-success" onclick="add();">新增</a> 
							 
			  <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >删除</a>
	    </div>
	      
	</div> <!-- /row -->  
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
	 
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
       
       <script type="text/javascript">
		
       $(document).ready(function () {
    	   
    	  JqgridManager.init(jqGrid);
    	    
       }); 
 
       //是否下线 
       function  isF_Status(cellvalue, opts, rowObject){
    	   var showHtml ="";
    	   if(rowObject.F_IsSpecial=='0'){
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
    	   var ID_ = rowObject.ID_;
    	  
    	/*	var showHtml ="<div class='hidden-sm hidden-xs action-buttons' style='padding-top:15px;'>";	
    		    showHtml +="<a class=\"blue\" title=\"查看整改信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
    			showHtml +="onclick=\"showFileList('"+project_uid+"');\">" ;
    			showHtml +="<span class=\"glyphicon glyphicon-file bigger-110\"></span>" ;
    			showHtml +="</a>&nbsp;";
    			 
    			showHtml +="<a class=\"blue\" title=\"修改整改信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
    			showHtml +=	" onclick=\"eidtXcZlxx('"+project_uid+"');\">";
    			showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
    			showHtml +="</a> &nbsp;";
    		 
    			 
    			showHtml +="<a class=\"\" title=\"删除\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
    			showHtml +=	" onclick=\"removeData('"+project_uid+"');\">";
    			showHtml +="<span class=\"colorshow1 glyphicon  glyphicon-trash bigger-110\"></i>";
    			showHtml +="</a></div>&nbsp;"; 	
    		*/
    		
    		var showHtml =  "<button type='button' class='btn btn-default btn-sm' onclick='edit("+ID_+")'>";
    		showHtml +="<span class='glyphicon glyphicon-edit'></span>";
    		showHtml +="</button>";
		
    		showHtml +="<button type='button' class='btn btn-default btn-sm' onclick='del("+ID_+")'>";
    		showHtml +="<span class='glyphicon glyphicon-remove'></span>";
    		showHtml +="</button>";
    		
    		
    		showHtml +="<button type='button' class='btn btn-default btn-sm' onclick='deploy("+ID_+")'>";
    		showHtml +="<span class='glyphicon glyphicon-deploy'>启动</span>";
    		showHtml +="</button>";
    		
    		
		
    		return 	showHtml;
    	}
       
    	
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
			  $("#dataTable").jqGrid('setGridParam',{  
		            datatype:'json',  
		            postData:{'keyword':encodeURI(encodeURI(keyword))}, //发送数据  
		            page:1  
		        }).trigger("reloadGrid"); //重新载入  
		        
		}
		
		//新增
		function add(){
			
			
		   $('#edit').attr("data-target","edit-form");
			$('#edit-form').removeData("bs.modal");
			$("#edit-form").empty();
			$('#edit-form').modal({
				backdrop: 'static'
			});
			
			$.get("${ctx}/tbProductController/goAddView.do",function(data) {
				$("#edit-form").empty();
				$("#edit-form").html("");
				$("#edit-form").html(data);
			});
			
		 /*   $.get("${ctx}/tbProductController/goEditView.do?F_PRODUCT_ID="+Id,function(data) {
				$("#edit-form").empty();
				$("#edit-form").html("");
				$("#edit-form").html(data);
			}); */
			    
		 
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) { 
				 
					$.ajax({
						type: "POST",
						url: "${ctx}/activitiCtrl/delete.do?F_PRODUCT_ID="+Id+"&tm="+new Date().getTime(),
				         dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(response){
							  
							 if(!response.iserror){
									xAlert("信息提示","删除成功",1); 
									$("#INDEX_Form").submit();
							 } 
							 
						}
					});
					
				}
			});
		}
		
		//部署
		function deploy(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) { 
				 
					$.ajax({
						type: "POST",
						url: "${ctx}/activitiCtrl/deploy.do?ID_="+Id+"&tm="+new Date().getTime(),
				         dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(response){ 
							 if(!response.iserror){
									xAlert("信息提示","部署成功",1); 
									$("#INDEX_Form").submit();
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
					/*for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}*/
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
							top.jzts();
							$.ajax({
								type: "POST",
								url: '${ctx}/tbProductController/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									console.info(data);
									$("#INDEX_Form").submit();
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
			 
			
		   $.get("${ctx}/activitiCtrl/goEditView.do?F_PRODUCT_ID="+Id,function(data) {
					$("#edit-form").empty();
					$("#edit-form").html("");
					$("#edit-form").html(data);
		  }); 
			
		} 
		
		
		
		//导出excel
		function toExcel(){
			window.location.href='${ctx}/activitiCtrl/excel.do';
		}
		</script>
		
		
		<div id="edit-form" class="modal"></div>
	</body>
</html>

