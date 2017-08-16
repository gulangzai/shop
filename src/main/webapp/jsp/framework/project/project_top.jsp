<%@page import="com.ccthanking.framework.Constants"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
User user = RestContext.getCurrentUser();
String user_uid = "";
String username = "";
if(user!=null){
	user_uid = user.getIdCard();
	username = user.getName();
}else{
	response.sendRedirect("/"+Constants.APP_NAME);
	return;
}
%>
<style>
.header-right{
		position:relative;
		padding-top:12px;
}
</style>
<script language="javascript">
var project_uid = "";
function closeGdzxt(){
	window.openen=null;
	window.open('','_self');
	window.close();
}

jQuery(function($){
    //init();
	project_uid=$("#qproject_uid").val();
	if(project_uid==null||project_uid==''){
		return false;
	}else{
		$.ajax({
			url :'${pageContext.request.contextPath}/project/buProjectController?queryProject',
			data : "project_uid="+project_uid,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) { 
				var resultobj = JSON.parse(response.obj);
				$('#project_name').val(resultobj.projectName);
				$('#project_uid').val(resultobj.projectUid);
				$("#pname").html(resultobj.projectName);
			}	
		});
	}
})

	
function init(){
      var project_uid = $("#qproject_uid").val();
      $.ajax({
			url :'${pageContext.request.contextPath}/project/buProjectController?queryWeather',
			data : {"project_uid":project_uid},
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(result) { 
				var CITY_NAME = "";
				var WEATHER_DESC = "";//天气现象描述
				var MAX_TEMPERATURE = "";
				var MIN_TEMPERATURE = "";
				var WIND = "";//风力
				var WIND_DIRECTION = "";//风向
				var REPORT_DATE = "";//预报日期
				var WEATHER_PIC = "";//天气图标
				if(result.obj !=null && result.obj != ""){
							$.each(result.obj,function(){
							    CITY_NAME = this.CITY_NAME;
							    WEATHER_DESC  = this.WEATHER_DESC;
							    MAX_TEMPERATURE = this.MAX_TEMPERATURE;
							    MIN_TEMPERATURE = this.MIN_TEMPERATURE;
							    WIND = this.WIND;
								WIND_DIRECTION = this.WIND_DIRECTION;
								REPORT_DATE = this.GET_TIME;
								WEATHER_PIC = "./"+this.WEATHER_PIC;
								
							});
							//获取 当前项目所在的城市
							//$("#CITY_NAME").html(thtml);
							//星期几 处理
							var date = new Date();
							var day = date.getDay();//返回的是一周中 的某一天
							if(day === 0){
							   day = '日';
							}else if(day === 1){
							   day = "一";
							}else if(day === 2){
							   day = "二";
							}else if(day === 3){
							   day = "三";
							}else if(day === 4){
							   day = "四";
							}else if(day === 5){
							   day = "五";
							}else if(day === 6){
							   day = "六";
							}
							
							//显示天气的图标
							var tianqitb = "<i class=\"ace-icon\"><img width=\"36\" height=\"36\" src=\""+WEATHER_PIC+"\"></img></i>";
							//var tianqitb = "<i class=\"ace-icon\"><img width=\"45\" height=\"45\" src=\"./assets/images/weather/icon/day/yu.png\"></img></i>";
							$("#addTQTB").html(tianqitb);
							$("#someDay").html("周"+day+"&nbsp;");
							var reportyear = date.getFullYear();
 	                        var reportmonth = date.getMonth()+1;
 	                        var getDay = date.getDate();
							//日期处理 显示为年月 日 的 格式
							$("#REPORT_DATE").html(reportmonth+"月"+getDay+"日"+"&nbsp;&nbsp;");
							
							if(MIN_TEMPERATURE =="" || MAX_TEMPERATURE == "" ){
								$("#WEATHER_DESC").html("&nbsp;&nbsp;"+WEATHER_DESC+"&nbsp;");
							}else{
							//天气现象描述及气温处理
							$("#WEATHER_DESC").html("&nbsp;&nbsp;"+WEATHER_DESC+"&nbsp;"+MIN_TEMPERATURE+"~"+MAX_TEMPERATURE+"℃"+"&nbsp;&nbsp;&nbsp;&nbsp;");
							}
							
							$("#WIND_DIRECTION").html("&nbsp;&nbsp;"+WIND_DIRECTION+"&nbsp;"+WIND);
							//$("#WIND").html(WIND+"&nbsp;");
							
				
				//成功 获取天气状况 再 去查询工况信息(最新)
				$.ajax({
						url :'${pageContext.request.contextPath}/project/buProjectController?queryGKdetail',
						data : "project_uid="+project_uid,
						cache : false,
						async :	false,
						dataType : "json",  
						type : 'post',
						success : function(response) { 
							//var obj = convertJson.string2json1(response.msg);
							var resultobj = JSON.parse(response.obj);
							var PROJECT_ADDRESS = resultobj.PROJECT_ADDRESS;
							//获取 当前的农历日期
							var sysNlDate = resultobj.NLDATE.toString();
							var num = sysNlDate.indexOf('年');
							num++;
							var strDate = sysNlDate.substring(num);
							var dizhitb = "<img src=\"assets/images/login/address.png\" title=\""+PROJECT_ADDRESS+"\" width=\"26px;\" height=\"26px;\"/>";
							$("#showDIZHI").html(dizhitb);
							$("#xmdzname").html(PROJECT_ADDRESS);
							$("#addGKTB").html(tianqitb);
							$("#getNlDate").html("农历"+strDate);
			                var gkDescriprion = resultobj.DESCRIPTION.toString();
			                if(gkDescriprion.length > 10){
			                   var Descriprion = gkDescriprion.substr(0,12);
			                   $("#GKDETAIL").html(Descriprion);
			                }else{
			                   $("#GKDETAIL").html(gkDescriprion);
			                }
			               
			               
						}	
					});
							
				}else{
				   // $("#showTianqi").css("display","none");
				  return;
				}
			}	
		});

}
//注销按钮响应函数
	    function dologout(){
	    	//document.location.href="${pageContext.request.contextPath }/userController/logout";
	    	bootbox.confirm("确认退出系统吗？", function(result) {
				if (result) {
					window.location.href="${pageContext.request.contextPath }/logout";
				} else {
					return;
				}
			});
	    	
	    }
</script>
