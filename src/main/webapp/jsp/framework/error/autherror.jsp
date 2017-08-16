<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>无权限</title>
    <meta http-equiv=Content-Type content="text/jsp; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
<body>
	
    <table cellSpacing=0 cellPadding=0 width="100%" border=0  align=center>
	  <tbody>
		  <tr>
		    <td align=center >
		    	<span style="color:red">没有权限访问！ </span>
				<input type="button" class="xlbutton" value="返回" onclick="javascript:window.history.go(-1);" />
			</td>
		 </tr>
	  </tbody>
	</table>
</body>

</html>
