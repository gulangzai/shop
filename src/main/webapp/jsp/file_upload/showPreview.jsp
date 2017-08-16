<!DOCTYPE html>
<html>
	<head>
		<%@ page language="java" pageEncoding="GBK"%>
		<%@ include file="/jsp/framework/common/taglibs.jsp" %>


<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctx}/assets/js/jquery.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery1x.min.js'>"+"<"+"/script>");
		</script>
		<![endif]-->
		
		<title>Preview</title>
		<style>
			body{
				margin:0px;
				widht:100%;
				height:100%;
			}
			.iframe{
				widht:100%;
				height:100%;
			}
		</style>
		<script type="text/javascript" charset="utf-8">
			$(function(){
				doInit();
			});
			function doInit(){
				var obj = $(window.opener.document).find("#previewFileid");
				var fileid = obj.val();
				var type = $(window.opener.document).find("#previewMethod");
				var actionUrl = "";
				if(type.val()=="history"){
					var fileName = encodeURI($(window.opener.document).find("#previewName").val());
					var fileType = encodeURI($(window.opener.document).find("#previewType").val());
					actionUrl = "${pageContext.request.contextPath }/PubWS.do?getOldFjAction&filename="+fileName+"&filepath=FlowApply&filenametype="+fileType;
				}else{
					actionUrl = "${pageContext.request.contextPath }/fileUploadUtilController?doPreview&fileid="+fileid;
				} 
				$.ajax({
					url:actionUrl,
					data:"",
					dataType:"json",
					async:false,
					success:function(result){
						var res = result.msg;
						if(res!=""){
							var flag = false;
							if(res.lastIndexOf(".jpg")){
								flag = true;
							}
							if(res.lastIndexOf(".png")){
								flag = true;
							}
							if(flag){
								window.location.href=res;
							}else{
								$("#showPreviewFrame").attr("src",res);
							}
						}
					}
				});
			}
		</script>
	</head>
	<body >
		<iframe id="showPreviewFrame" frameborder="0" style="width:100%;height:98%;overflow:auto;">
		
		</iframe>
	</body>
</html>
