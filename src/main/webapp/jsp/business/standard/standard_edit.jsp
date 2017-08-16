<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
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
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="standard/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="STANDARD_ID" id="STANDARD_ID" value="${pd.STANDARD_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover"> 
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">规格名:</td>
				<td><input type="text" name="F_STANDARDNAME" id="F_STANDARDNAME" value="${pd.F_STANDARDNAME}" maxlength="32" placeholder="这里输入规格名" title="规格名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">规格值:</td>
				<td><input type="text" name="F_STANDARDVALUE" id="F_STANDARDVALUE" value="${pd.F_STANDARDVALUE}" maxlength="32" placeholder="这里输入规格值" title="规格值"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">序号:</td>
				<td><input type="text" name="F_XUHAO" id="F_XUHAO" value="${pd.F_XUHAO}" maxlength="32" placeholder="这里输入序号" title="序号"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="mysave();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>