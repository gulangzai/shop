<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.lanbao.util.Constants"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/sys_resources/plugins/lightbox/themes/default/jquery.lightbox.css" />
<%@ include file="/jsp/framework/common/taglibs.jsp"%>  
<style>
.setposition{
	position: absolute;
	left:30%;
	top:13%;
	Z-index:10;
	border:1px solid black;
}
</style>
<% 
	String root = request.getScheme()+"://"+request.getServerName()+":8088"+"/file";
	String target_table = request.getParameter("target_table");
	String target_col = request.getParameter("target_col");
	String file_type = request.getParameter("file_type");
	String project_uid = request.getParameter("project_uid");
	
	String target_uid =request.getParameter("target_uid");
%>


<div class="modal-dialog setposition width-60 height-auto" style="background:rgb(239,243,248)">
  <div class="modal-content" >
    <p id="myModalLabel" class="pop_title">添加文件<img src='${ctx}/assets/img/close.png' data-dismiss="modal" id="closeZlPage" ></p>
  <div class="modal-body">
     <div class="dropzone form_scY"></div>
  </div>
  
  <div class="modal_footer"> 
  <span class="closeBtn" id='btnCloses' data-dismiss="modal">关闭</span>
     <span id="btnClose_fujian" data-dismiss="modal" class="saveBtn">保存</span>
  </div>
  
 </div>
</div>
 <jsp:include page="/jsp/file_upload/fileupload_xiao.jsp" flush="true" />
<script type="text/javascript" src="${ctx}/assets/js/dropzone.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/css/dropzone.css"/>  
<script type="text/javascript">   
var target_table = "<%=target_table%>";
var target_col = "<%=target_col%>";
var file_type = "<%=file_type%>";
var project_uid = "<%=project_uid%>";
var target_uid ="<%=target_uid%>";
var userid = "";   

var url = "${pageContext.request.contextPath }/UploadUtilServlet?target_table="+target_table+"&target_col="+target_col+"&file_type="+file_type+"&target_uid="+target_uid+"&project_uid="+project_uid+"&create_user="+userid;
var uid=[];
var json=[];
$(".dropzone").dropzone({
    url: url,
    paramName: "file",
    addRemoveLinks: true,
    dictRemoveFile: "删除文件",
    dictCancelUpload:"",
    acceptedFiles:"",
    autoProcessQueue: true,  
    init: function() { 
    },
    success: function (file, response, e) { 
       //console.log(response.xhr.responseText);
       //console.log(file.xhr.responseText);
        //insertFileTab(file.xhr.responseText);
         var xhr = file.xhr;
        var response = xhr.response;
        var response = eval("("+response+")");
        var FILE_UID_S =  response[0].FILE_UID; 
       
        uid.push(FILE_UID_S);
        json.push(file.xhr.responseText);
        $(file.previewTemplate).children('.dz-success-mark').css('opacity', '1');  
        $(file.previewTemplate).children('.dz-progress').css('opacity', '0') ; 
    },
     removedfile: function(file) { 
        var xhr = file.xhr;
        var response = xhr.response;
        var response = eval("("+response+")");
        var FILE_UID =  response[0].FILE_UID; 
      /*   bootbox.confirm("确认要删除吗？", function(result){
    		if(result){  */
    			$.ajax({
    				url : "${pageContext.request.contextPath }/fileUploadUtilController?deleteFiles",
    				cache : false,
    				async :	false,
    				data : {"file_uid":FILE_UID},
    				dataType : "json",  
    				type : 'post',
    				success : function(response) {
    				    console.log(response);
    					if(response.success){
    						xAlert("信息提示","删除成功！"); 
    						//queryFileData_insert(target_table,target_uid);
    					}else{
    						xAlert("信息提示","删除失败，请联系管理员！");
    					}
    				}
    			});
    		     var _ref;
    		     return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
    		/* }else{
    			return;
    		}
      });   */
   } 
});  
$(function(){ 
	/** modal高度自适应 */
	$("#information").css('max-height',$(window).height()-210 +'px');
	//关闭按钮  
	$("#btnClose_fujian").click(function(){
	    /*  for(var j=0;j<json.length;j++){
	         console.log(json[j]);
	         insertFileTab(json[j]);
	     } */
	     queryFileData_insert(target_table,target_uid);
		// m_close();
	 }); 
	 $("#btnCloses").click(function(){
	     //console.log(uid);
	     var file_uid_ss="";
	     
	     for(var i = 0; i < uid.length; i++) {
				file_uid_ss += uid[i]+ ",";
		 }
		
	     $.ajax({
    				url : "${pageContext.request.contextPath }/fileUploadUtilController?deleteFiles",
    				cache : false,
    				async :	false,
    				data : {"file_uid":file_uid_ss},
    				dataType : "json",  
    				type : 'post',
    				success : function(response) {
    				     console.log(response);
    					 /* if(response.success){
    					  
    						xAlert("信息提示","删除成功！");  */ 
    						queryFileData_insert(target_table,target_uid);
    					 /* }else{
    						xAlert("信息提示","删除失败，请联系管理员！");
    					}  */
    				}
    			});
	   //  m_close();
	 });
});
function m_close(){
    $("#xmgk-save").css("display","none");
	$("#xmgk-save").attr("aria-hidden","true");
	$("#xmgk-save").attr("class","modal");
	/**页面框的背景 样式去除**/
	$(".modal-backdrop").attr("class",""); 
};

</script>