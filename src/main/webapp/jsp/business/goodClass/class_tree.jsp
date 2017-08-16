<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/jsp/commons/taglib.jsp"%>
<%@ include file="/jsp/commons/common.jspf"%>
<script type="text/javascript"> 
</script>
<html lang="en">
	<head> 
	<link rel="stylesheet" href="${ctxStatic}/plugin/zTree/3.5/zTreeStyle.css" type="text/css">
	 <script type="text/javascript" src="${ctxStatic}/plugin/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	  
	</head>
<body>
 <div class="container-fluid" id="main-container">


<table style="width:100%;" border="0">
	<tr>
		<td style="width:15%;" valign="top" bgcolor="#F9F9F9">
			<div style="width:15%;">
				<ul id="leftTree" class="ztree"></ul>
			</div>
		</td>  
	</tr>
</table> 
		<form>
		   <input type="hidden" id="choseClassId"/>
		   <input type="hidden" id="choseClassName"/>
		</form>
</div> 
        
		<!-- 引入 -->
		<script type="text/javascript">
			$(top.hangge());
			 
			var setting = {
				view: {
					showIcon: showIconForTree
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					onClick:zTreeOnClick
				}	
			};
			
			var fClsId;
			var className;
			
			//单击 节点 获取数据显示
			function zTreeOnClick (event, treeId, treeNode){
				fClsId = treeNode.id;
				className = treeNode.name; 
				$("#choseClassId").val(fClsId); 
				$("#choseClassName").val(className);
			}
			

			var zNodes = ${classes};
			
            //console.info(zNodes);
			function showIconForTree(treeId, treeNode) {
				return !treeNode.isParent;
			};

			$(document).ready(function(){
				$.fn.zTree.init($("#leftTree"), setting, zNodes);
			});
			
			
		 
			
		</script>
</body>
</html>