<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>
<%@ include file="/jsp/commons/common.jspf"%> 
	
<!DOCTYPE html>
<html lang="en">
	<head> 
	
	
	<!--查看图片插件 -->
	<link rel="stylesheet" media="screen" type="text/css" href="${ctx}/plugins/zoomimage/css/zoomimage.css" />
    <link rel="stylesheet" media="screen" type="text/css" href="${ctx}/plugins/zoomimage/css/custom.css" />
    
    <script type="text/javascript" src="${ctx}/plugins/zoomimage/js/jquery.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zoomimage/js/eye.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zoomimage/js/utils.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zoomimage/js/zoomimage.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zoomimage/js/layout.js"></script>
	<!--查看图片插件 -->

    <style type="text/css">
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
			<form class="form-inline" action="${ctx}/pictures/list.do" method="post" name="Form" id="Form">
			<div class="form-group">
				  
					<input class="form-control" autocomplete="off" id="nav-search-input" type="text" name="keyword" value="${pd.keyword}" placeholder="这里输入关键词" />
					 
					<button class="btn btn-mini btn-light"  type="button" onclick="search();"  title="检索">
					  <span  class="glyphicon glyphicon-search"></span>
					</button> 
					<c:if test="${QX.cha == 1 }">
					 <a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a> 
					</c:if>
				 
			</div>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center" onclick="selectAll()">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th style="text-align:center">图片</th>
						<th style="text-align:center">标题</th>
						<th style="text-align:center">ID</th>
						<th style="text-align:center">创建时间</th>
						<th style="text-align:center">属于</th>
						<th style="text-align:center">备注</th>
						<th class="center">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						 
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.PICTURES_ID}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td>
										<a href="${ctx}/uploadFiles/uploadImgs/${var.PATH}" title="${var.TITLE}" class="bwGal"><img src="${ctx}/uploadFiles/uploadImgs/${var.PATH}" alt="${var.TITLE}" width="100"></a>
										</td>
										<td>${var.TITLE}</td>
										<td>${var.PICTURES_ID}</td>
										<td>${var.CREATETIME}</td>
										<td>${var.MASTER_ID}</td>
										<td>${var.BZ}</td>
								<td style="width: 30px;" class="center">
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div>
											 
										<%--
										    <li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.PICTURES_ID}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
										    <li><a style="cursor:pointer;" title="删除" onclick="del('${var.PICTURES_ID}','${var.PATH}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
										 --%>
										 
										   <p style="width:100px;">
										    <button type="button" class="btn btn-default btn-sm" onclick="edit('${var.PICTURES_ID}');">
												<span class="glyphicon glyphicon-edit"></span>
											</button>
											
											<button type="button" class="btn btn-default btn-sm" onclick="del('${var.PICTURES_ID}','${var.PATH}');">
												<span class="glyphicon glyphicon-remove"></span>
											</button>
			                               </p>
                               
										</div>
								</td>
							</tr>
						
						</c:forEach>
					 
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
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
				 
				 
					<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >批量删除</a>
					 
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
		
		<script type="text/javascript">window.jQuery || document.write("<script src='${ctx}/static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="${ctx}/static/js/bootstrap.min.js"></script>
		<script src="${ctx}/static/js/ace-elements.min.js"></script>
		<script src="${ctx}/static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="${ctx}/static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="${ctx}/static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="${ctx}/static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="${ctx}/static/js/jquery.tips.js"></script><!--提示框-->
		<!-- 引入 -->
		
		
		
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
			 diag.Title ="新增1";
			 diag.URL = '${ctx}/tbPicturesController/goAdd.do';
			 diag.Width = 800;
			 diag.Height = 490;
			 diag.CancelEvent = function(){ //关闭事件
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				 }else{
					 nextPage(${page.currentPage});
				 }
				diag.close();
			 };
			 diag.show(); 
		}
		
		//删除
		function del(Id,PATH){
			
			if(confirm("确定要删除?")){ 
				top.jzts();
				var url = "${ctx}/tbPicturesController/delete.do?PICTURES_ID="+Id+"&PATH="+PATH+"&tm="+new Date().getTime();
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			}
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '${ctx}/tbPicturesController/goEdit.do?PICTURES_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 465;
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
		
		//全选 （是/否）
		function selectAll(){
			 var checklist = document.getElementsByName ("ids");
			   if(document.getElementById("zcheckbox").checked){
			   for(var i=0;i<checklist.length;i++){
			      checklist[i].checked = 1;
			   } 
			 }else{
			  for(var j=0;j<checklist.length;j++){
			     checklist[j].checked = 0;
			  }
			 }
		}

		
		
		//批量操作
		function makeAll(msg){
			
			if(confirm(msg)){ 
				
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						alert("您没有选择任何内容!"); 
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '${ctx}/tbPicturesController/deleteAll.do?tm='+new Date().getTime(),
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
		}
		
		//导出excel
		function toExcel(){
			window.location.href='${ctx}/tbPicturesController/excel.do';
		}
		</script>
		<style type="text/css">
		li {list-style-type:none;}
		</style>
		<ul class="navigationTabs">
            <li><a></a></li>
            <li></li>
        </ul>
	</body>
</html>

