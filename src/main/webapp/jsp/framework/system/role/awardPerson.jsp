<!DOCTYPE html>
<%@page import="com.copj.modules.utils.spring.SpringContextHolder"%>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%@ page import="com.ccthanking.framework.service.UserServiceCust" %>
<%@ page import="com.ccthanking.framework.service.impl.UserServiceCustImpl" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri= "/tld/base.tld" prefix="app" %>
<%
	String role_uid = request.getParameter("role_uid");
	String project_uid = request.getParameter("project_uid");
	UserServiceCust userService = SpringContextHolder.getBean("userServiceCustImpl", UserServiceCust.class);
	
	HashMap<String,String> map = new HashMap<String,String>();
	map.put("role_uid", role_uid);
	map.put("project_uid", project_uid);
	String[][] roleInfoArray = userService.queryPersonRole(map);
	int spLen = 0;
	int menuLen = 0;
	String dept_name = "";
	int kk = 1;
%>
<title>实例页面-查询</title>

</head>
<body>
<div class="modal-dialog width-50 height-auto">
	<div class="modal-content">
		<p class="pop_title">赋予角色<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png' ></span></p>
		<div id="information" style="padding: 0px">

			<div class="widget-main no-padding">
				<table class="table table-striped table-bordered table-hover">

					<tbody>

					<%
						// 每行显示的个数
						int num = 3;
						// 角色总数
						int line = 0;
						int cols = 1;
						for(int i = 0; i < roleInfoArray.length; i++) {
			
			
							{
								if(cols==1)
								{
							%>
								<tr>
								
							
							<%  }
			
									%>
										<td class="">
									<%
										if(roleInfoArray[i][0].equals(roleInfoArray[i][1])) {
									%>
											<input type="checkbox" id="name" name="name" value="<%=roleInfoArray[i][0] %>=<%=roleInfoArray[i][2] %>" checked="checked"/>&nbsp;&nbsp;<font color="red"><%=roleInfoArray[i][2] %></font>
									<%
										} else {
									%>
											<input type="checkbox" id="name" name="name" value="<%=roleInfoArray[i][0] %>=<%=roleInfoArray[i][2] %>"/>&nbsp;&nbsp;<font color="#000000"><%=roleInfoArray[i][2] %></font>
									<%		
										}
									%>
										
										</td>
									<%			
								if(cols==num)
								{ 
									
								%>
								</tr>
								<%
								}
								cols++;
								if(cols>num)
								{
									cols = 1;
									line++;
								}
							}
						}
						
				
						
					%>
		

					</tbody>
				</table>
			</div>

		</div>

		<div class="modal_footer">
			<span data-dismiss="modal" class="closeBtn" id="btnClose">关闭</span> 
			<span  class="saveBtn" id="saveRoleInfo">保存</span>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/combineQuery.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/bootstrap-validation.js"> </script>
<script type="text/javascript">
  var controllername= "${pageContext.request.contextPath }/userController";
var id = "<%=role_uid %>";
var name  = "";
$(function(){
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	$('#saveRoleInfo').click(function() {
		var checkObj = $(":checkbox");
		var checkValue = "";
		for(var i = 0; i < checkObj.length; i++) {
			if(checkObj[i].checked == true) {
				checkValue += checkObj[i].value + ",";
			}
		}
		$('#checkValue').val(checkValue);
		var data = "{\"roleid\":\""+id+"\",\"rolename\":\""+name+"\",\"checkValue\":\""+checkValue+"\"}";
		//组成保存json串格式frmPost9
		var data1 = defaultJson.packSaveJson(data);
		defaultJson.doInsertJson(controllername + "?awardRoleToPerson", data1);
		jQuery("#grid_table").jqGrid().trigger("reloadGrid");
		$('#btnClose').click();
	});
	
});


</script>
</body>
</html>