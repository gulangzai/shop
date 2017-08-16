<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>
<%@page import="com.copj.modules.utils.spring.SpringContextHolder"%>
<%@ page import="com.ccthanking.framework.service.UserServiceCust" %>
<%@ page import="com.ccthanking.framework.service.impl.UserServiceCustImpl" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri="/tld/base.tld" prefix="app"%>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	String project_uid = request.getParameter("project_uid");
	String name = request.getParameter("name");
	String ryid = request.getParameter("ryid");
	UserServiceCust userService = SpringContextHolder.getBean("userServiceCustImpl", UserServiceCust.class);
	
	HashMap<String,String> map = new HashMap<String,String>();
	map.put("project_uid", project_uid);
	map.put("ryid", ryid);
	String[][] roleInfoArray = userService.queryRole(map);
	int spLen = 0;
	int menuLen = 0;
	int quickLen = 0;
	for(int len=0;len<roleInfoArray.length;len++)
	{
		if("2".equals(roleInfoArray[len][2])) {
			spLen++;
		} else if("1".equals(roleInfoArray[len][2])) {
			menuLen++;
		} else if("3".equals(roleInfoArray[len][2])) {
			quickLen++;
		} 
	}
	
%>
<title><fmt:message key="ui.title" /></title>
</head>
<!-- Modal -->

<div class="modal-dialog width-50 height-auto">
	<div class="modal-content">
			<p class="pop_title">角色信息<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png' ></span></p>
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
						
						//if("1".equals(roleInfoArray[i][3])){
							if(cols==1){
						%>
							<tr>

								<%  } %>
									<td class="">
										<%
									if(roleInfoArray[i][0].equals(roleInfoArray[i][1])) {
								%>
											<input type="checkbox" id="name" name="name" value="<%=roleInfoArray[i][0] %>=<%=roleInfoArray[i][2] %>" checked="checked" />&nbsp;&nbsp;<font color="red"><%=roleInfoArray[i][2] %></font>
											<%
									} else {
								%>
												<input type="checkbox" id="name" name="name" value="<%=roleInfoArray[i][0] %>=<%=roleInfoArray[i][2] %>" />&nbsp;&nbsp;<font color="#000000"><%=roleInfoArray[i][2] %></font>
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
						//}
					}
					
				
					
				%>

					</tbody>
				</table>
			</div>

		</div>

		<div class="modal_footer">
			<span class="closeBtn" id="btnClose" data-dismiss="modal" aria-hidden="true">关闭</span>
			<span class="saveBtn" id="saveRoleInfo">保存</span>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/combineQuery.js"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206"> </script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/sys_resources/js/common/bootstrap-validation.js"> </script>
<script type="text/javascript">
	var account = "<%=ryid%>";
  	var controllername= "${pageContext.request.contextPath }/userController";
	
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
		var data = "{\"account\":\""+account+"\",\"checkValue\":\""+checkValue+"\"}";
		//组成保存json串格式frmPost9
		var data1 = defaultJson.packSaveJson(data);
		defaultJson.doInsertJson(controllername + "?awardRoleToUser", data1);
		jQuery("#grid_table").jqGrid().trigger("reloadGrid");
		$('#btnClose').click();
	});
	
});


</script>
</html>