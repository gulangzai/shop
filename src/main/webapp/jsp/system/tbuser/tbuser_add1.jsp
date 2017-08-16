<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
	<head> 
	   <%@ include file="/jsp/commons/common.jspf"%>  
	</head>
  
<body> 
	<form action="${ctx}/tbUserController/${msg}.do" name="Form" id="Form_user_add" method="post">
 
        <input type="hidden" name="F_Deleted" id="F_Deleted" value="0"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">用户名:</td>
				<td><input type="text" name="F_UserName" id="F_UserName" value="${pd.F_UserName}" maxlength="32" placeholder="这里输入用户名" datatype="*"  nullmsg="请输入用户名" title="用户名"  required errormsg="请输入用户名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">真实姓名:</td>
				<td><input type="text" datatype="*" name="F_RealName" id="F_RealName" value="${pd.F_RealName}" maxlength="32" placeholder="这里输入真实姓名" nullmsg="请输入真实姓名" title="真实姓名" required errormsg="请填写真实姓名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">性别:</td>
				<td><select type="number" name="F_Sex" id="F_Sex" value="${pd.F_Sex}" maxlength="32" placeholder="这里输入性别" title="性别" required>
				    <option value="0">男</option>
				    <option value="1">女</option>
				</select></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">邮件:</td>
				<td><input type="text" datatype="e" name="F_Email" id="F_Email" value="${pd.F_Email}" maxlength="32" placeholder="这里输入邮件" nullmsg="请输入邮件" title="邮件" required/></td>
			    
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">电话:</td>
				<td><input type="text" datatype="m" name="F_Mobile" id="F_Mobile" value="${pd.F_Mobile}" maxlength="32" placeholder="这里输入电话" nullmsg="请输入电话" title="电话" required/></td>
			</tr>
			
		 
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				  
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="${ctxStatic}/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
		
</body>

<script type="text/javascript"  src="${ctxStaticB}/js_system/tbuser/tbuser_edit.js"></script>	
	

</html>