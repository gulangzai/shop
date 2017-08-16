<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/framework/common/taglibs.jsp"%>  
<%
	 
	String PROJECT_UID = request.getParameter("PROJECT_UID");
	String FXY_UID = request.getParameter("FXY_UID");  
%>

<style>
.page-content {
    background-color: #fff;
    position: relative;
    margin: 0;
    padding:3px 0px 0px 3px;
}
</style>
<!-- Modal -->
<div class="modal-dialog width-70 height-auto">
 	<div style="background: #fff" >
 	<p class="pop_title">查看风险源<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png'></span> </p>
    <div id="information">
      <form id="tableDetailForm">
          <input  type="hidden" name="FXY_UID" operation="=" fieldname="FXY_UID" value="<%=FXY_UID%>"/>    
       <!--   <input  type="hidden" name="PROJECT_UID" operation="=" fieldname="PROJECT_UID" value="<%=PROJECT_UID%>"/>    -->
      </form>
      
 	  <form method="post" role="form" class="form-horizontal"  id="execute_tableDetail" > 
 	      <!-- 获取 项目 的 uid -->    	
      	  <input id="XCROJECT_UID" type="hidden" name="ROJECT_UID" fieldname="PROJECT_UID"  /> 
	  	  <input type="hidden" id="target_uid" fieldname="target_uid"  /> 
		  <input type="hidden" id="TARGET_TABLE" fieldname="TARGET_TABLE" value="PM_FXY" />	 	 		
		 		
		     <div class='row'> 
					<span class='col-xs-2'><b>*</b>风险源类型</span> 
		          	 <input  type="text"  id ="FXY_TYPE" disabled="disabled"  datatype="*"   name="FXY_TYPE" fieldname="FXY_TYPE"  class='col-xs-4'/> 

		       
					<span class='col-xs-2'><b>*</b>危险因素分类</span> 
					<select id="execute_tableDetail_WXYS_FL" datatype="*" type="text" class='col-xs-4'
						name="WXYS_FL" fieldname="WXYS_FL" kind="dic"
						src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='WXYSFL'  AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
					</select> 
			 </div>
					
				 
					<div class="rowbox row">
						 
					 <span class="col-xs-2"><b class="ptop">*</b>危险因素</span>
							 
			 		 <textarea datatype="*" nullmsg="请填写危险因素！"  placeholder="请填写危险因素！" type="text"  
							 name="WXYS" id="WXYS" fieldname="WXYS"   rows="4"  class="col-xs-10" ></textarea>
						 
					</div>
					
					<div class='row'>
					       <span class="col-xs-2"><b>*</b>可能导致的事故</span>
							<select id="execute_tableDetail_SHIGU" datatype="*" type="text"
								name="SHIGU" fieldname="SHIGU" kind="dic" 
								class="col-xs-4"
								src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='SGFL' AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
							</select> 
							
							 <span class="col-xs-2">区域</span> 
							 <select id="execute_tableDetail_QUYU" type="text" 
							    name="QUYU" fieldname="QUYU" kind="dic"
								class="col-xs-4"
								src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='FXYQY' AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
							    <option value="">请选择</option>
							</select> 
					</div>
					
					<div class="rowbox row">  
							<span class="col-xs-2"><b class="ptop">*</b>控制措施</span> 
						      <textarea datatype="*" nullmsg="请填写控制措施！"  placeholder="请填写控制措施！" type="text" 
						       class="col-xs-10"
							 name="CUOSHI" id="CUOSHI" fieldname="CUOSHI"   rows="4"  ></textarea>
					 
					       
					</div>
					
					 <div class="rowbox row"> 
						<span class="col-xs-2">应急预案描述</span>
						<textarea   nullmsg="请填写应急预案！" placeholder="请填写应急预案！"
							type="text" name="YIJIN_YUAN" id="YIJIN_YUAN"
							fieldname="YIJIN_YUAN" rows="4" class="col-xs-10"></textarea> 
					</div>
					
		       <div class='row'> 
					   <span class="col-xs-2">开始日期</span>
							 <input readonly="readonly" data-date-format="yyyy-mm-dd"
								nullmsg="请输入开始日期" placeholder="请输入开始日期" type="text"
								name="BEGIN_DATE" id="execute_tableDetail_BEGIN_DATE" fieldname="BEGIN_DATE" class="REPORT_DATE1 col-xs-4">
						 
				 
						<span class="col-xs-2">结束日期</span> <input readonly="readonly" data-date-format="yyyy-mm-dd"
							 nullmsg="请输入结束日期" placeholder="请输入结束日期" type="text"
							name="END_DATE" id="execute_tableDetail_END_DATE" fieldname="END_DATE"  class="REPORT_DATE2 col-xs-4">
				 
				</div>
			 
				 
				 
				<div class="rowbox row"> 
					<span  class="col-xs-2"><a file_type="10801" id="addFile1" onclick="selectFile_s(this);"
					class="btn btn-info" 
					style=' background: #fcb421 !important;'>工作记录</a></span>
					<div class="rowboxDiv col-xs-10">
					<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:false;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10801"></tbody>
					</table>
					</div> 
				</div>
				
				<div class="rowbox row"> 
					<span class="col-xs-2"><a file_type="10802" id="addFile2" onclick="selectFile_s(this);"
					class="btn btn-info"
					style=' background: #fcb421 !important;'>应急预案</a></span>
					<div class="rowboxDiv col-xs-10">
					<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:false;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10802"></tbody>
					</table>
					</div> 
				</div>
				
				<div class="rowbox row">
					<span class="col-xs-2"><a file_type="10803" id="addFile3" onclick="selectFile_s(this);"
					class="btn btn-info"
					style='background: #fcb421 !important;'>附件上传</a></span>
					<div class="rowboxDiv  col-xs-10">
					<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:false;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10803"></tbody>
					</table>
					</div> 
			</div>
			 
     </form>
     
	</div>
	
  <div class="modal_footer"> 
       <span data-dismiss="modal" class="closeBtn" id="btnClosetabledetail">关闭</span>
  </div>
</div>
</div>
<div id="xmgk-save" class="modal"></div>
<div id="XMZK-XMMC" class="modal"></div>
<script type="text/javascript">
var ctx = '${ctx}';
var controllernameUrl="${pageContext.request.contextPath}/";
</script>

<jsp:include page="/jsp/file_upload/fileupload_xiao.jsp" flush="true" /> 
<script src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/business/pmfxy/pm_fxy_detail.js"> </script>