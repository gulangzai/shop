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
	
		 
			<form class="form-inline" width="100%" action="${ctx}/chicmeproduct/chicmeProductController/list.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					
					<div class="form-group">
					           我的消息UID
							   	<input class="form-control" name="KEYWORD" id="KEYWORD"   type="text"    style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="商品名"/>
							  
						 		
							  	<button class="btn  btn-link btn-sm" type="button" onclick="search();">
							  	   <i class="colorshow  ace-icon glyphicon glyphicon-search"></i>
							  	   <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">查询</span>
							  	</button>
							  <!--	<button class="btn btn-link btn-sm" type="button"  onclick="toExcel();"> 
							      	 <i  class="colorshow  ace-icon glyphicon glyphicon-download-alt"></i>
							     	 <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">下载</span> 
					            </button>
					            -->
					</div> 
		</form>
		
		 
		 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable"  action="${ctx}/chicmeproduct/chicmeProductController/dataList.do">
		        
		        <tr>
		          
							    <th name="brand"   align="center" formatter="">商标</th> 
							    <th name="category"   align="center" formatter="">目录</th> 
							    <th name="color"   align="center" formatter="">颜色</th> 
							    <th name="description"   align="center" formatter="">描述</th> 
							    <th name="price"   align="center" formatter="">价格</th> 
							    <th name="size"   align="center" formatter="">大小</th> 
							    <th name="sku"   align="center" formatter="">sku</th> 
				   <th class="center"  name="OPERATOR" style="text-align:center" width="5%" align="center"  formatter="doReportInfo">操作</th>	 
				 	
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
		   
		 function doReportInfo(cellvalue, opts, rowObject){
    	    var ID = rowObject.ID; 
    		
    		var showHtml =  "<button type='button' class='btn btn-default btn-sm' onclick='see("+ID+")'>";
    		showHtml +="<span class='glyphicon  glyphicon glyphicon-file'></span>";
    		showHtml +="</button>";
    		
    		showHtml +=  "<button type='button' class='btn btn-default btn-sm' onclick='edit("+ID+")'>";
    		showHtml +="<span class='glyphicon glyphicon-edit'></span>";
    		showHtml +="</button>";
		
    		showHtml +="<button type='button' class='btn btn-default btn-sm' onclick='del("+ID+")'>";
    		showHtml +="<span class='glyphicon glyphicon-remove'></span>";
    		showHtml +="</button>"; 
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
		            postData:{'search':true,'keyword':encodeURI(encodeURI(keyword))}, //发送数据  
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
			
		  $.get("${ctx}/chicmeproduct/chicmeProductController/goAddView.do?id="+id,function(data) {
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
			
		    $.get("${ctx}/chicmeproduct/chicmeProductController/goEditView.do?id="+Id,function(data) {
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
			
		    $.get("${ctx}/chicmeproduct/chicmeProductController/goDetailView.do?id="+Id,function(data) {
				$("#edit-form").empty();
				$("#edit-form").html("");
				$("#edit-form").html(data);
			});   
		 
		} 
		
		//del
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					 
					var url = "${ctx}/chicmeproduct/chicmeProductController/delete.do?id="+Id+"&tm="+new Date().getTime();
					 
				 	$.ajax({
						url : url,
						cache : false,
						async :	false,
						dataType : "json",  
						type : 'post',
						success : function(response) { 
							 if(!response.iserror){
								xAlert("信息提示","删除成功",1); 
								$("#INDEX_Form").submit();
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
							top.jzts();
							$.ajax({
								type: "POST",
								url: '${ctx}/chicmeproduct/chicmeProductController/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		}
		

		
		
		
		//导出excel
		function toExcel(){
			window.location.href='${ctx}/chicmeproduct/chicmeProductController/excel.do';
		}
		</script>
		
		
		<div id="edit-form" class="modal"></div>
		
	</body>
</html>

