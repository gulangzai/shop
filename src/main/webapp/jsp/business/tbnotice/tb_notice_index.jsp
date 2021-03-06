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
	
		 
			<form class="form-inline" width="100%" action="${ctx}/tbnotice/tbNoticeController/dataList.do" method="post" name="INDEX_Form" id="INDEX_Form" style="border:solid 1px #ddd;line-height:40px;margin-top:5px;vertical-align:middle;">
					
					<div class="form-group" style="padding:0px 10px;">
					            
					             <label>主题</label> &nbsp;
							   	 <input type="text"    class="form-control" name="KEYWORD" id="KEYWORD"   style="width:120px;height:30px;border-radius:8px 8px 8px 8px;border:1px solid #d1d2d9;" placeholder="请输入主题"/>
							     
							  	<button class="btn  btn-link btn-sm" type="button" onclick="search();">
							  	   <i class="colorshow    glyphicon glyphicon-search"></i>
							  	   <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">查询</span>
							  	</button>
							  	<button class="btn btn-link btn-sm" type="button"  onclick="toExcel();"> 
							      	 <i  class="colorshow   glyphicon glyphicon-download-alt"></i>
							     	 <span style="font-family:'Microsoft YaHei';font-size:15px;color:#4e4c4c;">下载</span> 
					            </button> 
					</div> 
		</form>
		
		 
		 	<table id="jqGrid" class="table table-striped table-bordered table-hover imagetable"  action="${ctx}/tbnotice/tbNoticeController/dataList.do">
		        
		        <tr>
		          
				    <th name="F_NOTICE_UID"   align="center" formatter="">公告编号</th> 
				    <th name="F_NOTICE_TITLE"   align="center" formatter="FNonticeTitleFormatter">主题</th> 
				    <th name="F_NOTICE_CONTENT"   align="center" formatter="">内容</th> 
				    <th name="F_NOTICE_TYPE"   align="center" formatter="FNoticeTypeFormatter">公告类型</th>   
				    <th name="F_NOTICE_LEVEL"   align="center" formatter="FStatusFormatter">公告级别</th> 
				    <th name="F_CREATE_DATE"   align="center" formatter="">创建时间</th> 
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
	 
	 <script type="text/javascript" src="${ctxStatic}/business/tbnotice/js/tbnotice_list.js"> </script>
</html>

