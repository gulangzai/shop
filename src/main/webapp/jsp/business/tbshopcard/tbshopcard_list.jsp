<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>
 
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@ include file="/jsp/commons/common.jspf"%> 
		
		 
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
		vertical-align:middle;
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
			<form class="form-inline" action="${ctx}/tbShopcardController/list.do" method="post" name="Form" id="Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;"  width="100%">
			
			<div class="form-group"> 
					 
					<input class="form-control" autocomplete="off" id="nav-search-input" type="text" name="field1" value="" placeholder="这里输入关键词"  style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" />
					  
					<input class="span10 date-picker form-control" name="lastLoginStart" id="lastLoginStart" value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/>
					<input class="span10 date-picker form-control" name="lastLoginEnd" id="lastLoginEnd" value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/>
				 	      
				 	<select class="chosen-select form-control" name="field2" id="field2" data-placeholder="请选择"  style="width:300px;">
						<option value=""></option>
						<option value="">全部</option>
						<option value="">1</option>
						<option value="">2</option>
				  	</select>
					
					<button class="btn btn-mini btn-light" onclick="search();">检索</button>
					 
					<button  type="button"  class="btn btn-default btn-sm"  onclick="toExcel();">
					     <span class="glyphicon glyphicon-arrow-down"></span>
					</button>
					
				 
								
			</div>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover imagetable">
				
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center"  width="5%">序号</th> 
						<th class="center"  style="text-align:center"  width="8%">订单编号</th>
						<th class="center"  style="text-align:center"  width="12%">用户名</th>
						<th class="center"  style="text-align:center" width="12%">手机号</th>
						<th class="center"  style="text-align:center" width="12%">商品名</th>
						<th class="center"  style="text-align:center" width="25%">商品介绍</th>
						<th class="center"  style="text-align:center" width="12%">下单时间</th>
						<th class="center" width="8%">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
					 
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.F_SHOPCARDID}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td style="width: 30px;">${var.F_SHOPCARDID}</td>
										<td>${var.F_UserName}</td>
										<td>${var.F_Mobile}</td>
										<td>${var.F_ProductName}</td>
										<td>${var.F_ProductDesc}</td>
										<td>${var.CREATE_DATE}</td>
								<td style="width: 30px;" class="center">
									<!-- <div class='hidden-phone visible-desktop btn-group'> 
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
											
									    <ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
										  -->
											 <a style="cursor:pointer;" title="编辑" onclick="edit('${var.F_SHOPCARDID}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a> 
											 
											 
											 <a style="cursor:pointer;" title="删除" onclick="del('${var.F_SHOPCARDID}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a> 
										
										<!--	 
										 </ul>
										</div>
									</div> -->
								</td>
							</tr>
						
						</c:forEach>
						 
						 
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
					
				
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
				 
					<a class="btn btn-small btn-success" onclick="add();">新增</a>  
				 	<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >删除</a>
							
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		 </table>
		</div>
		</form>
		
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='${ctx}/static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="${ctx}/static/js/bootstrap.min.js"></script>
		<script src="${ctx}/static/js/ace-elements.min.js"></script>
		<script src="${ctx}/static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="${ctx}/static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="${ctx}/static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="${ctx}/static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="${ctx}/static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '${ctx}/tbShopcardController/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
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
					var url = "${ctx}/tbShopcardController/delete.do?F_SHOPCARDID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '${ctx}/tbShopcardController/goEdit.do?F_SHOPCARDID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		</script>
		
		<script type="text/javascript">
		
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
								url: '${ctx}/tbShopcardController/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='${ctx}/tbShopcardController/excel.do';
		}
		</script>
		
	</body>
</html>

