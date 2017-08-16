<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ include file="/jsp/framework/common/taglibs.jsp"%> 
<style>
.page-content {
	background-color: #fff;
	position: relative;
	margin: 0;
}
</style>
<!-- Modal -->

<div class="modal-dialog width-70 height-auto" id="pmFxyAdd">
	<%--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">--%>
	<div style="background: #fff" class="modal_content">
		<p class="pop_title">添加风险源<span data-dismiss="modal"><img src='${ctx}/assets/img/close.png'></span> </p>
		<div id="information">
			<form method="post" role="form" class="form-horizontal"
				id="executetableAdd">
				<!-- 获取 项目 的 uid -->
				<input id="XCROJECT_UID" type="hidden" name="ROJECT_UID"
					fieldname="PROJECT_UID" value="1" /> <input type="hidden"
					id="target_uid" fieldname="target_uid" /> <input type="hidden"
					id="TARGET_TABLE" fieldname="TARGET_TABLE" value="PM_FXY" />

				<div class='row'> 
					<span class='col-xs-2'><b>*</b>风险源类型</span> <select id="FXY_TYPE"
						  type="text" class='col-xs-4' name="FXY_TYPE"
						fieldname="FXY_TYPE" kind="dic"
						src="T#SYS_DIC: DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='FXYLX'  AND ENABLED='1' AND P_DIC_UID IS NOT NULL order by XUHAO">
					<option value="请选择">请选择</option>
					</select> 
					<span class='col-xs-2'><b>*</b>危险因素分类</span> <select id="WXYS_FL"
						  type="text" class='col-xs-4' name="WXYS_FL"
						fieldname="WXYS_FL" kind="dic"
						src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='WXYSFL'  AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
					<option value="请选择">请选择</option>
					</select> 
				</div>
				<div class="rowbox row"> 
					<span class="col-xs-2"><b class="ptop">*</b>危险因素</span>

					<textarea datatype="*" nullmsg="请填写危险因素！" placeholder="请填写危险因素！"
						type="text" name="WXYS" id="WXYS" fieldname="WXYS" rows="4"
						class="col-xs-10"></textarea> 
				</div>

				<div class='row'> 
					<span class="col-xs-2"><b>*</b>可能导致的事故</span> <select id="SHIGU"
						  type="text" name="SHIGU" fieldname="SHIGU" kind="dic"
						class="col-xs-4"
						src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='SGFL' AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
					<option value="请选择">请选择</option>
					</select> 
					
					<span class="col-xs-2">区域</span> <select id="QUYU"
						type="text" name="QUYU" fieldname="QUYU" kind="dic"
						class="col-xs-4"
						src="T#sys_dic:  DIC_CODE:DIV_VALUE:1=1 AND DIC_NAME_CODE='FXYQY' AND ENABLED='1' AND P_DIC_UID IS NOT NULL  order by XUHAO">
					    <option value="">请选择</option>
					</select> 
					
				</div>

				<div class="rowbox row"> 
					<span class="col-xs-2"><b class="ptop">*</b>控制措施</span>
					<textarea datatype="*" nullmsg="请填写控制措施！" placeholder="请填写控制措施！"
						type="text" name="CUOSHI" id="CUOSHI" fieldname="CUOSHI" rows="4"
						class="col-xs-10"></textarea> 
				</div>

				<div class="rowbox row"> 
					<span class="col-xs-2">应急预案</span>
					<textarea   nullmsg="请填写应急预案！" placeholder="请填写应急预案！"
						type="text" name="YIJIN_YUAN" id="YIJIN_YUAN"
						fieldname="YIJIN_YUAN" rows="4" class="col-xs-10"></textarea> 
				</div>

				<div class='row'> 
					<span class="col-xs-2">开始日期</span> <input
						readonly="readonly"   data-date-format="yyyy-mm-dd"
						nullmsg="请输入开始日期" placeholder="请输入开始日期" type="text"
						name="BEGIN_DATE" id="ADD_BEGIN_DATE" fieldname="BEGIN_DATE"
						class="REPORT_DATE1 col-xs-4"> 
					<span class="col-xs-2">结束日期</span> <input
						readonly="readonly" data-date-format="yyyy-mm-dd"
						nullmsg="请输入结束日期" placeholder="请输入结束日期" type="text"
						name="END_DATE" id="ADD_END_DATE" fieldname="END_DATE"
						class="REPORT_DATE2 col-xs-4"> 
				</div>
 
			 
				<div class="rowbox row"> 
					<span class="col-xs-2"><a file_type="10801" id="addFile1"
						onclick="selectFile_s(this);" class="btn"
						style=' background: #f1c672 !important;'>工作记录</a>
					</span>
					<div class="rowboxDiv col-xs-10">
						<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:true;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10801"></tbody>
						</table>
					</div> 
				</div>
				<div class="rowbox row"> 
					<span class="col-xs-2"><a file_type="10802" id="addFile2"
						onclick="selectFile_s(this);" class="btn "
						style=' background: #f1c672 !important;'>应急预案</a>
					</span>
					<div class="rowboxDiv col-xs-10">
						<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:true;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10802"></tbody>
						</table>
					</div> 
				</div>
				<div class="rowbox row"> 
					<span class="col-xs-2"><a file_type="10803" id="addFile3"
						onclick="selectFile_s(this);" class="btn "
						style='background: #f1c672 !important;'>附件上传</a>
					</span>
					<div class="rowboxDiv col-xs-10">
						<table role="presentation" class="table table-striped">
							<tbody
								showType="width:80px;height:80px;quanxian:true;del:true;attr:multi;preview:false;"
								class="files showFileTab" data-toggle="modal-gallery"
								data-target="#modal-gallery" file_type="10803"></tbody>
						</table>
					</div> 
				</div>
			</form>

		</div>

		<div class="modal_footer">
			<span data-dismiss="modal" class="closeBtn" id="btnClosetableadd">关闭</span>
			<span class="saveBtn" id="btnAddtable">保存</span>
		</div>
	</div>
</div>
<script type="text/javascript">
var ctx = '${ctx}';
var controllernameUrl="${pageContext.request.contextPath}/";
</script>

<jsp:include page="/jsp/file_upload/fileupload_xiao.jsp" flush="true" />
<script src="${pageContext.request.contextPath }/assets/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/sys_resources/js/common/Form2Json.js"> </script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/business/pmfxy/pm_fxy_add.js"> </script>