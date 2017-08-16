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
	
		 
			<form class="form-inline" width="100%" action="${ctx}/tbuser/tbUserController/dataList.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:50px;vertical-align:middle;">
					
					<div class="form-group">
					                                         用户名/手机号/邮箱
							   	<input type="text"    class="form-control" name="KEYWORD" id="KEYWORD"   style="width:120px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="请输入用户名"/>
							   
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
		
		 
		 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable"  action="${ctx}/tbuser/tbUserController/dataList.do">
		        
		        <tr> 
				    <th name="F_USER_ID"   align="center" formatter="">用户编号</th> 
				    <th name="F_UserName"   align="center" formatter="FUserNameFormatter">用户名</th> 
				    <th name="F_Email"   align="center" formatter="">邮箱</th> 
				    <th name="F_Mobile"   align="center" formatter="">手机号</th>   
				    <th name="F_RealName"   align="center" formatter="">真实姓名</th> 
				    <th name="F_visits"   align="center" formatter="">访问次数</th> 
				    <th name="F_Deleted"   align="center" formatter="FDeletedFormatter">是否可用</th> 
				   <!--  <th name="F_CREATE_DATE"   align="center" formatter="">创建时间</th> --> 
				    
	                <th  name="OPERATOR" style="text-align:center"  align="center"  formatter="doReportInfo">操作</th>	 
	 	
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
	 
	 <script type="text/javascript" src="${ctxStatic}/business/tbuser/js/tbuser_list.js"> </script>
</html>

