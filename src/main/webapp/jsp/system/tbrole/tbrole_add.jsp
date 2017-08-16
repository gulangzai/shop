<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/jsp/commons/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
	
	 <%@ include file="/jsp/commons/common.jspf"%> 
	 
		<base href="<%=basePath%>">
 
		<style type="text/css">
		  form{
		   margin-top: 20px;
		  }
		</style>
		 
	</head>
	
		<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript"  src="static/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript"  src="${ctxStatic}/business/tbrole/tbrole_add.js"></script> 
	
	
	
<body> 
	<form action="${ctx}/tbRoleController/${msg}.do" name="Form" id="Form_role_add" method="post">
 
        <input type="hidden" name="F_STATUS" id="F_STATUS" value="0"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">角色名:</td>
				<td><input type="text" name="F_ROLE_NAME" id="F_ROLE_NAME" value="${pd.F_ROLE_NAME}" maxlength="32" placeholder="这里输入角色名" datatype="*"  nullmsg="请输入角色名" title="角色名"  required errormsg="请输入角色名"/></td>
			</tr>
		 
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">是否可用:</td>
				<td> 
				    <div class="radio" style="float:left">
						<label >
							<input type="radio" class="ace" name="F_STATUS0" value="0"  checked="checked" >
							<span class="lbl"> 是</span>
						</label>  
				   </div>
				  
				    <div class="radio" style="margin-left:10px;">
			               <label>
								<input type="radio" class="ace" name="F_STATUS0" value="1">
								<span class="lbl" style="margin-left: 20px;"> 否</span>
							</label>  
				    </div> 
				     
				</td>
			</tr>
		 
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
				<td><textarea   cols="200"  rows="5" style="width:80%;height:100%;" name="DESCRIPTION" id="DESCRIPTION" value="${pd.DESCRIPTION}" placeholder="这里输入备注" nullmsg="请输入备注"></textarea></td>
			</tr>
			
		 
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				  
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	

	
</body>

<script>
   (function(){
	   $("input[name='F_STATUS0']").change(function(){
		   $("#F_STATUS").val($(this).val());
	   }); 
   })();
</script>
</html>