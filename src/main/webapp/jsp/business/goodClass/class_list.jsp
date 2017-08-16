<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/commons/taglib.jsp"%>
<%@ include file="/jsp/commons/common.jspf"%> 
<%
   String F_ClsId = request.getParameter("F_ClsId");
%>
 
<!DOCTYPE html>
<html lang="en">
	<head>   
    </head>
<body>
 <div class="container-fluid" id="main-container">  
 
				<div id="page-content" class="clearfix"> 
				
				  <div class="row-fluid"> 
				  
					<div class="col-sm-12" id="inside"> 
	  
						  <!-- 检索  -->
						  <form class="form-inline"  action="${ctx}/goodClass/dataList.do?F_ClsId=${F_ClsId}" method="post" name="userForm" id="queryForm">
							 
							    <div class="form-group"  style="border:1px solid #F2F2F2;">
							   
									<input  class="form-control" type="hidden" fieldname="F_ClsId" name="F_ClsId" id="F_ClsId" value="${F_ClsId}"/>
							 
									
									<label class="btn btn-big btn-success" onclick="add();">新增商品类别</label>
									<!-- 检索  -->
							 
							    </div>
						  </form>	
							 
							<table id="jqGrid" class="table table-striped table-bordered table-hover"  action="${ctx}/goodClass/dataList.do">  
									<tr> 
										<th name="fClsId" align="center">类型ID</th>
										<th name="fClsName" align="center">商品类型名</th> 
										<th name="fStatus" align="center" formatter="statusFormatter">状态</th>
										<th name="OPERATOR" align="center" formatter="doReportInfo">操作</th>
									</tr> 
							</table> 
					       <div id="jqGridPager"></div>
		  
					</div>
				  
					<!-- PAGE CONTENT ENDS HERE -->
				  </div><!--/row--> 
				</div><!--/#page-content-->
			</div><!--/.fluid-container#main-container-->
		
	    <div id="edit-form" class="modal"></div>   
	    
	    
	    
	</body>
</html>
<script type="text/javascript"  src="${ctxStatic}/business/tbclass/js/tbclass_list.js"></script>	


