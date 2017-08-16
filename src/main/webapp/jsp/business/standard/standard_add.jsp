<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head> 
		<meta charset="utf-8" />
<%@ include file="/jsp/commons/common.jspf"%>

<script type="text/javascript">
 	
	//保存
	function mysave(){
		
	  if($("#F_STANDARD_ID").val()==""){
			$("#F_STANDARD_ID").tips({
				side:3,
	            msg:'请输入主键',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#F_STANDARD_ID").focus();
			return false;
		}
		if($("#F_PRODUCTID").val()==""){
			$("#F_PRODUCTID").tips({
				side:3,
	            msg:'请输入商品id',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#F_PRODUCTID").focus();
			return false;
		}
		if($("#F_STANDARDNAME").val()==""){
			$("#F_STANDARDNAME").tips({
				side:3,
	            msg:'请输入规格名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#F_STANDARDNAME").focus();
			return false;
		}
		if($("#F_STANDARDVALUE").val()==""){
			$("#F_STANDARDVALUE").tips({
				side:3,
	            msg:'请输入规格值',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#F_STANDARDVALUE").focus();
			return false;
		}
		if($("#F_XUHAO").val()==""){
			$("#F_XUHAO").tips({
				side:3,
	            msg:'请输入序号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#F_XUHAO").focus();
			return false;
		}
		 var standardName =   document.getElementById('F_STANDARDNAME').value; 
		 var standardValue =  document.getElementById('F_STANDARDVALUE').value;
		 var xuhao =   document.getElementById('F_XUHAO').value;
		 
		var $tr= $("<tr style='height:50px'></tr>");
		$tr
		.append($("<td></td>").append($("<input type='text' style='height:30px' name='F_XUHAO[]'>").val(xuhao)))
		.append($("<td></td>").append($("<input type='text' style='height:30px' name='F_StandardName[]'>").val(standardName)))
		.append($("<td></td>").append($("<input type='text' style='height:30px' name='F_StandardValue[]'>").val(standardValue)));  
		return true;
	}
	
</script>
	</head>
<body>
	<form action="standard/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="STANDARD_ID" id="STANDARD_ID" value="${pd.STANDARD_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">规格名:</td>
				<td>
					<select class="chzn-select" name="F_STANDARDNAME" id="F_STANDARDNAME"  style="width:150px;">
					    <option value="数量">数量</option>
					    <option value="运费">运费</option> 
					    <option value="本站价 ">本站价 </option>    
					</select> 
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">规格值:</td>
				<td><input type="text" name="F_STANDARDVALUE" id="F_STANDARDVALUE" value="${pd.F_STANDARDVALUE}" maxlength="32" placeholder="这里输入规格值" title="规格值"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">序号:</td>
				<td><input type="number" name="F_XUHAO" id="F_XUHAO" value="${pd.F_XUHAO}" maxlength="32" placeholder="这里输入序号" title="序号"/></td>
			</tr> 
			 
			
			<!-- 序号:<input class="datepicker" type="text" name="F_XUHAO" id="F_XUHAO" value="${pd.F_XUHAO}" maxlength="32"/>  -->
			 
		</table>
		</div>
   </form> 
		 
	 	
	 	<script type="text/javascript">
		$(top.hangge());
		$(function() { 
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});   
		});
		
		</script>
</body>
</html>