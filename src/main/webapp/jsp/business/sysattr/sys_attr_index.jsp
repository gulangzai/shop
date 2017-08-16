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
	</head>
<body>



 <div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid"> 
	<div class="col-sm-12" id="inside">
	
		 
			<form class="form-inline" width="100%" action="${ctx}/sysattr/sysAttrController/list.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					
					 
		    </form>
		
		 
		 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable"  action="${ctx}/sysattr/sysAttrController/dataList.do">
		        
		        <tr>
		           <th name="F_ATTR_UID"   align="center" formatter="">属性UID</th>
		           <th name="F_ATTR_TABLE"   align="center" formatter="">属性表名</th> 
				   <th name="F_ATTR_NAME"   align="center" formatter="">属性表名(描述)</th> 
				   <th class="center"  name="OPERATOR" style="text-align:center"  align="center"  formatter="doReportInfo">操作</th>	 
				 	
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
	 
 <div id="edit-form" class="modal"></div>
		
</body>
	<script type="text/javascript" src="${ctxStatic}/business/sysattr/js/sys_attr_index.js"></script>
</html>

