<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri= "/tld/base.tld" prefix="app" %>

<div class="sidebar responsive" id="sidebar">
        <div class="sidebar-shortcuts" id="sidebar-shortcuts">
             <img src="${pageContext.request.contextPath }/assets/img/www.ico.logo.ico" alt="">环亚保险经纪
        </div>

				<ul class="nav nav-list" id="leftMenu_ul">
					<app:menusub projectUid="${project_uid}" projectUserId="${projectUserId} "/>				
				</ul>

    <%--<div class="sidebar-toggle" id="sidebar-collapse">--%>
      <%--<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>--%>
    <%--</div>--%>


        <!--<div class="sidebar-toggle sidebar-collapse">-->
        <!--<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>-->
        <!--</div>-->
        <!--<script type="text/javascript">-->
        <!--try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}-->
        <!--</script>-->

    </div><!-- /.sidebar -->