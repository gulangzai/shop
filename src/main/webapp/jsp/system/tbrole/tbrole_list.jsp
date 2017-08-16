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
<script>
var page_currentPage = '${page.currentPage}';
</script>	

<body>

 
<script type="text/javascript" src="${ctxStatic}/business/tbrole/tbrole_list.js"> </script>

<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid"> 
  
		<div class="col-sm-12" id="inside">
	
			<!-- 检索  -->
			<form class="form-inline" action="${ctx}/tbRoleController/list.do"     method="post" name="Form" id="Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					 
				     <div class="form-group"  style="border:1px solid #F2F2F2;">
				      
				            用户名：  <input class="form-control" name="KEYWORD" id="KEYWORD"  type="text"   style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="用户名"/>
				                           日期：
						   	<input class="form-control date-picker" name="lastLoginStart" id="lastLoginStart" value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd"  style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="开始日期"/>
						     	~
				            <input class="form-control date-picker" type="text" data-date-format="yyyy-mm-dd"  style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="结束日期" name="lastLoginEnd" id="lastLoginEnd" value="${pd.lastLoginEnd}" />
					     	
					  	<button class="btn  btn-link btn-sm" type="button"   onclick="search();">
					  	   <i class="colorshow  ace-icon glyphicon glyphicon-search"></i>
					  	   <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">查询</span>
					  	</button>
					  	<button class="btn btn-link btn-sm" type="button"   onclick="toExcel();"> 
					      	 <i  class="colorshow  ace-icon glyphicon glyphicon-download-alt"></i>
					     	 <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">下载</span> 
			            </button> 
				   </div>  
		 
			<!-- 检索  --> 
		
			<table id="table_report" class="table table-striped table-bordered table-hover  imagetable">
				
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center" style="text-align:center">角色名</th>	
						<th class="center" style="text-align:center">描述</th> 
						<th class="center" style="text-align:center">是否可用</th> 
						<th class="center" style="text-align:center">操作</th>
					</tr>
				</thead> 				
				<tbody> 
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}"> 
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.F_ROLE_ID}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${(page.currentPage-1)*page.showCount+vs.index+1}</td>
										<td  style="text-align:center">${var.F_ROLE_NAME}</td>
										<td>${var.DESCRIPTION}</td>
										<td  style="text-align:center"><c:if test="${var.F_STATUS == '0'}">可用</c:if><c:if test="${var.F_STATUS == '1'}">禁用</c:if></td>
			 							
							   <td  class="center" style="width:60px;">   
							      <%--  <div class='hidden-phone visible-desktop btn-group'>
							          <a class='btn btn-mini btn-info' href="javascript:void(0)"  title="授权" onclick="toRole('${var.F_ROLE_ID}');">
									    <i class="icon-key"></i>  
								     </a>
									<a  class='btn btn-mini btn-info'  href="javascript:void(0)" title="编辑" onclick="edit('${var.F_ROLE_ID}');">
									   <i class='icon-edit'></i> 
									</a>
									<a class='btn btn-mini btn-danger'   title="删除" onclick="del('${var.F_ROLE_ID}');">
										<i class='icon-trash'></i>
									</a>
									  </div> --%>
									 <p style="width:120px;">
									    
									   <!--
									   <button type="button" class="btn btn-default btn-sm" onclick="toRole('${var.F_ROLE_ID}');">
											<span class="glyphicon glyphicon-wrench"></span>
										</button>
										  -->  
										    <button type="button" class="btn btn-default btn-sm" onclick="edit('${var.F_ROLE_ID}');">
												<span class="glyphicon glyphicon-edit"></span>
											</button>
											
											<button type="button" class="btn btn-default btn-sm" onclick="del('${var.F_ROLE_ID}');">
												<span class="glyphicon glyphicon-remove"></span>
											</button>
                                    </p>
                               
			                    
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
						 
						 
						  	<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >删除</a>
						
						</td>
						<td style="vertical-align:top;">
						<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
						</td>
					</tr>
				</table>
			</div> 
		 </form>
	</div> <!-- /row --> 
	
	
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
 <div id="XXXM"></div> 
		 
<script>
var ctx = "${ctx}";
$(top.hangge());
 

function toRole(F_USER_ID){
 
  	$("#XXXM").attr("class","modal");
	$("#XXXM").removeData("bs.modal");
	$("#XXXM").empty();
	$("#XXXM").modal({
		backdrop: 'static'
	}); 
	 
	$.get("${ctx}/tbRoleController/toUserRole.do?F_USER_ID="+F_USER_ID,function(data){  
		$("#XXXM").empty();
		$("#XXXM").html("");
		$("#XXXM").html(data); 
	});
}

</script>

</body>
</html>

