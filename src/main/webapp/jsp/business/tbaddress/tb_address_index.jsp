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
	
		 
			<form class="form-inline" width="100%" action="${ctx}/tbaddress/tbAddressController/list.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					
					<div class="form-group">
					            收件人 
							   	<input class="form-control" name="KEYWORD" id="KEYWORD"   type="text"    style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="收件人"/>
							  
						 		
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
		
		 
		 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable"  action="${ctx}/tbaddress/tbAddressController/dataList.do">
		        
		        <tr>            <th name="F_DIQU"   align="center" formatter="formatterDiqu">地区</th> 
							   <!--  <th name="F_USER_ID"   align="center" formatter="">用户账号</th>  -->
							    <th name="F_ADDRESS_DETAIL"   align="center" formatter="">详细地址</th> 
							    <th name="F_POSTAL_CODE"   align="center" formatter="">邮政编码</th> 
							    <th name="F_RECEIVE_NAME"   align="center" formatter="">收件人</th> 
							    <th name="F_RECEIVE_MOBILE"   align="center" formatter="">手机号</th> 
							    <th name="CREATE_DATE"   align="center" formatter="">创建时间</th> 
				                <th class="center"  name="OPERATOR" style="text-align:center"  align="center"  formatter="doReportInfo">操作</th>	 
			  </tr>
		</table>
        <div id="jqGridPager"></div>
        
        
        <div class="form-inline" width="100%">  
			 <!--  <a class="btn btn-small btn-success" onclick="add();">新增</a> --> 
							 
			  <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >删除</a>
	    </div> 
	   
	</div> <!-- /row --> 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		 
       <script type="text/javascript">
		  
		  $(document).ready(function () {
		       JqgridManager.init(jqGrid);
		  });

		  

		  function formatterDiqu(cellvalue, opts, rowObject){
	    	    var F_ADDRESS_UID = rowObject.F_ADDRESS_UID;  
	    	    var provinceLabel = rowObject.F_PROVINCE_LABEL;
	    	    var cityLabel = rowObject.F_CITY_LABEL;
	    	    var districtLabel = rowObject.F_DISTRICT_LABEL;
	    		var showHtml =   "<span class='glyphicon'>"+provinceLabel+""+cityLabel+""+districtLabel+"</span>"; 
	    		return 	showHtml;
	    	}
	    	
		 function doReportInfo(cellvalue, opts, rowObject){
    	    var F_ADDRESS_UID = rowObject.F_ADDRESS_UID; 
    		
    		var showHtml =  "<button type='button' class='btn btn-default btn-sm' onclick='see("+F_ADDRESS_UID+")'>";
    		showHtml +="<span class='glyphicon  glyphicon glyphicon-file'></span>";
    		showHtml +="</button>&nbsp;&nbsp;";
    		
    		showHtml +=  "<button type='button' class='btn btn-default btn-sm' onclick='edit("+F_ADDRESS_UID+")'>";
    		showHtml +="<span class='glyphicon glyphicon-edit'></span>";
    		showHtml +="</button>&nbsp;&nbsp;";
		
    		showHtml +="<button type='button' class='btn btn-default btn-sm' onclick='del("+F_ADDRESS_UID+")'>";
    		showHtml +="<span class='glyphicon glyphicon-remove'></span>";
    		showHtml +="</button>&nbsp;"; 
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
			
		  $.get("${ctx}/tbaddress/tbAddressController/goAddView.do?F_ADDRESS_UID="+id,function(data) {
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
			
		    $.get("${ctx}/tbaddress/tbAddressController/goEditView.do?F_ADDRESS_UID="+Id,function(data) {
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
			
		    $.get("${ctx}/tbaddress/tbAddressController/goDetailView.do?F_ADDRESS_UID="+Id,function(data) {
				$("#edit-form").empty();
				$("#edit-form").html("");
				$("#edit-form").html(data);
			});   
		 
		} 
		
		//del
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					 
					var url = "${ctx}/tbaddress/tbAddressController/delete.do?F_ADDRESS_UID="+Id+"&tm="+new Date().getTime();
					 
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
								url: '${ctx}/tbaddress/tbAddressController/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='${ctx}/tbaddress/tbAddressController/excel.do';
		}
		</script>
		
		
		<div id="edit-form" class="modal"></div>
		
	</body>
</html>

