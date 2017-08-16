<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.ccthanking.framework.common.User"%>
<%@ page import="com.ccthanking.framework.common.rest.handle.servlet.RestContext" %>
<%@ include file="/jsp/framework/common/taglibs.jsp" %>
<%@ taglib uri= "/tld/base.tld" prefix="app" %>
<!DOCTYPE html>
<html>
  <head>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String projectId = request.getParameter("project_uid");
	String projectUserId = request.getParameter("projectUserId");
	
	User user = RestContext.getCurrentUser();
	String username = "";
	String userid="";
	if(user!=null){
		username = user.getName();
		userid= user.getIdCard();
	}
%>
	<base href="${ctx_site}/">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
 	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/css/RiskSourceManagement.css" />--%>
    <link rel="icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" /> 
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />	
    <title><fmt:message key="ui.title"/></title>
	<%@ include file="/jsp/framework/common/head.jsp"%>
  	<style>
		.user{
		position:relative;
	}
	.user>ul{
		display:none;
		position:absolute;
		left: -22px;
		top: 40px;
		height:60px;
		box-shadow: 0 0 5px grey;
		background:#fff;
	}
	.user>ul>li{
		width:82px;
		height:30px;
	}
	.user>ul>li>a{
		color:#3c4045;
		width:82px;
		height:30px;
		line-height:30px;
		text-align:center;
		display:block;
		font-weight:normal;
		font-size:14px;
	}
	#sidebar .submenu>li.active>a{
	color: #FCB421
	}
	</style>
  </head>
  
<body class="no-skin" style=''>
  	<div class="navbar" style="display: none;">
		<!-- 不能去掉  影响表格自适应 原因待查 -->
		</div>

		<!-- /section:basics/navbar.layout -->
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>
			<%@ include file="/jsp/framework/project/project_left.jsp"%>

			<!-- /section:basics/sidebar -->
			
			<div class="main-content">
				<div class="page-content">
					<div id="rightBox">
					   <div class="rightBox_Top">
				            <span>示例工程</span>
							<div class="PersonalInformation">
								<span class='user' >
								<img src="${ctx}/assets/img/user.png" alt=""><%=username %>
								<img src="${ctx}/assets/img/xialajiantou.png" alt="">
								<ul>
									<li>
										<a id="updatepwd">修改密码</a>
									</li>
								</ul>
								</span>
								<span onclick="dologout();"><img src="${ctx}/assets/img/exit.png" alt="">退出</span>
							</div>
				        </div>
				     </div>   
					<%@ include file="/jsp/framework/common/setting.jsp"%>					
					
					<div id = "page-content-area" class="page-content-area">
					
						<!-- ajax content goes here -->
					</div><!-- /.page-content-area -->
					
				</div><!-- /.page-content -->
			</div><!-- /.main-content -->

				

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->
		
		
  
  <!-- basic scripts -->
  		<div id="user-pwdupdate" class="modal"></div>
	<input type="hidden" id="project_uid" value="<%=projectId%>" >
	<input type="hidden" id="projectUserId" value="<%=projectUserId%>" >
	<%@ include file="/jsp/framework/common/basic_scripts.jsp"%>
 	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/Form2Json.js"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/convertJson.js"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/combineQuery.js"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/default.js?version=20131206"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/bootstrap-validation.js"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/js/common/loadFields.js?version=20131206"></script>
	<script type="text/javascript"  src="${ctx}/assets/sys_resources/plugins/validform/js/Validform_v5.3.2_min.js"></script>
	<script src="${ctx}/assets/js/hy.js"></script>
 		
  <script type="text/javascript">
		$(function(){
			$('#updatepwd').click(function (){
		   	$('#updatepwd').attr("data-target","user-pwdupdate");
				$('#user-pwdupdate').removeData("bs.modal");
				$("#user-pwdupdate").empty();
				$('#user-pwdupdate').modal({
					backdrop: 'static'
				});
				$.get("${ctx}/jsp/framework/system/user/user-pwd-update.jsp?USER_UID="+'<%= userid%>',function(data) {
					$("#user-pwdupdate").empty();
					$("#user-pwdupdate").html("");
					$("#user-pwdupdate").html(data);
				});

		});
		});
     function menutree_click(menuName,menuLocation,menuDesc,target){

    	 return true;
    	 
    	 if('enable_ajax_content' in ace) {
    		 alert('sd '+menuLocation);
    		 var options = {
    			  content_url:"'"+menuLocation+"'",
   	    		  default_url: 'homepage.html'//default url
   	    		  ,
   	    		  loading_icon: "fa-cog fa-2x blue"
    		 }
    		 ace.enable_ajax_content(jQuery, options);
    	 }
    	 
	 	
		//alert("menuName---"+menuName+"---menuLocation--"+menuLocation+"---menuDesc--"+menuDesc+"---target--"+target);
		if("#"!=menuLocation){
			window.location.href="${ctx}/"+menuLocation;
		}	
	 }
     
     jQuery(function($) {
    	 	
    	 	if('enable_ajax_content' in ace) {
				var options = {
				  content_url: function(url) {
					return url;
				  },
				  default_url:'page/business/index/index'
				}
				//alert(options.content_url);
				ace.enable_ajax_content($, options);
			  }
     });
     
     $(document).ready(function () {
         $('.user').click(function(){
		if($(this).children('ul').css('display')=='none'){
			$(this).children('ul').css('display','block');
		}else{
			$(this).children('ul').css('display','none');
		}
	});

         $('#pager span a').click(function () {
             $(this).addClass('active1').parent().siblings().children().removeClass('active1');
         })
         
         //选中对应菜单
         var httpUrl =  document.location.toString();
         var urlIndex = httpUrl.indexOf("#");
       	 var urlPath = httpUrl.substring(urlIndex+1,httpUrl.length);
       	 
         $("#leftMenu_ul li").each(function(i){
        	 if($(this).find("a").attr("data-url") == urlPath){
        		 $(this).addClass('active');
        		 $(this).find("a").find("span").addClass('active2');
        	 }
        	 
        	 //二级菜单加了没效果
        	// if($(this).children("ul").length!=0){
        	//	 var ulLi = $(this).find("ul").find("li");
        	//	 ulLi.each(function(){
        	//		 if($(this).find("a").attr("data-url") == urlPath){
        	//			 $(this).addClass('active'); 
        	//			 //$(this).find("a").addClass('active2');
        	//		 }
        	//	 });
        	// }
         });
         
     })
     
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
  </body>
</html>
