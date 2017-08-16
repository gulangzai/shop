<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/jsp/commons/taglib.jsp"%>
<%@ include file="/jsp/commons/common.jspf"%>
<script type="text/javascript"> 
</script>
<html lang="en">
	<head> 
	<link rel="stylesheet" href="${ctxStatic}/plugin/zTree/3.5/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="${ctxStatic}/js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/plugin/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	  
	</head>
<body>

 <div class="container" style="width:100%"> 
	  <div class="row"> 
			<div class="col-sm-2">
				<ul id="leftTree" class="ztree col-sm-12"></ul>
			</div> 
			 <div class="col-sm-10">
			      <iframe name="treeFrame" id="treeFrame" frameborder="0" src="${ctx}/jsp/business/goodClass/class_list.jsp"  style="margin:0 auto;width:100%;height:100%;"></iframe> 
	         </div> 
	  </div>
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
			
			//单击 节点 获取数据显示
			function zTreeOnClick (event, treeId, treeNode){
				var fClsId = treeNode.id; 
				$("#treeFrame")[0].contentWindow.flush(fClsId);
			}
			

			var zNodes = ${classes};
			
            //console.info(zNodes);
			function showIconForTree(treeId, treeNode) {
				return !treeNode.isParent;
			};

			$(document).ready(function(){
				$.fn.zTree.init($("#leftTree"), setting, zNodes);
			});
		 
			
			function treeFrameT(){
				var hmainT = document.getElementById("treeFrame");
				var bheightT = document.documentElement.clientHeight;
				hmainT.style.width = '100%';
				hmainT.style.height = (bheightT-7) + 'px';
				//alert(hmainT .style.height);
			}
			// treeFrameT();
			window.onresize=function(){  
				// treeFrameT();
			};
			
		
		</script>
</body>
</html>