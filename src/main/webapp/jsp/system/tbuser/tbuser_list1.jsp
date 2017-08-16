<!DOCTYPE html>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%@ taglib uri="/tld/base.tld" prefix="app"%>
<title><fmt:message key="ui.title" /></title> 
<style type="text/css">
.ui-jqgrid tr.jqgrow td { 
text-overflow : ellipsis;
} 


</style>
</head>
<body >
	<div class="main-container rightBox_Content" id="main-container">
			<div class="page-content">
				 <div class="col-sm-12 fxgl" id="inside">
		    <!-- form 开始 位置 -->
					<form class="form-inline"  id="queryForm" width="100%"
					   role="form" >
				<!--  <input id="PROJECT_UID" type="hidden" fieldname="t.PROJECT_UID" operation="="/>  -->
						<div class="rightBox_Content_QueryToAdd"> 
						
						<select id="QUYU"
								datatype="*"  type="text" name="QUYU" fieldname="QUYU" kind="dic" operation="=" style="width:200px;"
								src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='FXYQY' AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
							   <option value="">请选择区域</option>
							</select> 
							
							<input type="text" placeholder="危险因素"    name="t.WXYS" fieldname="t.WXYS" operation="=" logic="and">
							<input type="text" placeholder="可能导致的事故"  name="SHIGU" fieldname="t.SHIGU" id="SHIGU" operation="=" logic="and" >
							
							<input type="text" placeholder="开始时间" id="BEGIN_DATE" name="t.END_DATE" fieldname="t.END_DATE" operation=">=" logic="and" data-date-format="yyyy-mm-dd">
							<span></span>
							<input type="text" placeholder="结束时间" id="END_DATE" name="t.BEGIN_DATE " fieldname="t.BEGIN_DATE" operation="<=" logic="and" data-date-format="yyyy-mm-dd">
							 
							
					
							
							<span class="dark" id="searchForPlan"><img src="${pageContext.request.contextPath }/assets/img/search_icon2.png" alt="">查询</span>
							<span class='addBtn' id="newAdd" type="button"><b>+</b><s>添 加</s></span>
						</div>
				        
				         
					  </form>
					  
					  <!--表格区--->
					    <table   sortname="t.FXY_UID" multiselect=false  rownum="10" sortorder="desc"  class=""  id="grid_table" 
							    action="${ctx}/pmfxy/pmFxyController?query">
							<tr>
							  
							    <th name="FXY_TYPE"   align="center" width="1">风险源类型</th> 
							    <th name="WXYS"       align="left"  width="2" formatter="fxyTypeFormat">危险因素</th> 
							    <th name="WXYS_FL"    align="center" width="2"  formatter="">危险因素分类</th> 
							    <th name="SHIGU"      align="center" width="2" formatter="">可能导致的事故</th> 
							    <th name="CUOSHI"     align="left" width="2" formatter="">控制措施</th>  
							    <th name="QUYU"       align="center" width="1" formatter="">区域</th>  
							    <th name="BEGIN_DATE" align="center" width="1"  formatter="">开始时间</th> 
							    <th name="END_DATE"   align="center" width="1" formatter="">结束时间</th> 
							    <th name="YIJIN_YUAN" align="left" width="2" formatter="">应急预案描述</th>  
							    <th name="yjya"       align="center" width="1" formatter="yjyaFotmatter">应急预案</th> 
							    <th name="wjqd"       align="center" width="1" formatter="wjqdFotmatter">工作记录</th>
								<th name="operation"  align="center" width="1" formatter="doUpdate">操作</th>
							</tr> 
						</table> 
						
						<script type="text/javascript">
							var $path_base = "/";
						</script>
				</div>
			</div>
		</div>
		<div id="table-input" class="modal"></div>
<div id="xmgk-save" class="modal"></div>
<div id="XMZK-XMMC" class="modal"></div>

		<div class="workBox">
			<table id="showFileContents">
			    <tr style="background:#FDC03F">
					<th>
					文件名
					</th>
					<th>
					上传时间
					</th>
				</tr> 
			</table>
	</div>
<script type="text/javascript">
var ctx = '${ctx}';
var controllernameUrl="${pageContext.request.contextPath}/";
</script>
<%@ include file="/jsp/framework/common/basic_scripts.jsp"%>
	<script
		src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery-form.js"></script>	

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/business/pmfxy/pm_fxy_index.js"> </script>
</body>
</html>