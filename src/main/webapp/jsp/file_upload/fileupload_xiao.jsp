<!DOCTYPE HTML>
<%@page import="com.lanbao.util.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% 
String root = request.getScheme()+"://"+request.getServerName()+":8080"+"/file";
%>

<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/css/jquery.fileupload-ui.css" />
<!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>-->
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->

<!--<script src="http://blueimp.github.com/JavaScript-Templates/tmpl.min.js"></script>-->
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<!--<script src="http://blueimp.github.com/JavaScript-Load-Image/load-image.min.js"></script>-->
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<!--<script src="http://blueimp.github.com/JavaScript-Canvas-to-Blob/canvas-to-blob.min.js"></script>-->
<!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
<!--<script src="http://blueimp.github.com/cdn/js/bootstrap.min.js"></script>-->
<!--<script src="http://blueimp.github.com/Bootstrap-Image-Gallery/js/bootstrap-image-gallery.min.js"></script>-->

<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/jquery.fileupload.js"></script>
<!-- The File Upload file processing plugin -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/jquery.fileupload-fp.js"></script>
<!-- The File Upload user interface plugin -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/jquery.fileupload-ui.js"></script>
<!-- The localization script -->
<script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/locale.js"></script>

<!-- The main application script -->

<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
<!--[if gte IE 8]><script src="${pageContext.request.contextPath }/assets/sys_resources/plugins/fileupload/js/cors/jquery.xdr-transport.js"></script><![endif]-->




<div class="row-fluid">
    <!-- The file upload form used as target for the file upload widget -->

    <div id="fileupload">   
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar"  style="display:none;">
            <div class="span7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="icon-plus icon-white"></i>
                    <span>Add files...</span>
                    <input id="fileupload_btn" type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="icon-upload icon-white"></i>
                    <span>Start upload</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="icon-ban-circle icon-white"></i>
                    <span>Cancel upload</span>
                </button>
                <button type="button" class="btn btn-danger delete">
                    <i class="icon-trash icon-white"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" class="toggle">
            </div>
            <!-- The global progress information -->
            <div class="span5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="bar" style="width:0%;"></div>
                </div>
                <!-- The extended global progress information -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The loading indicator is shown during file processing -->
        <div class="fileupload-loading"></div>
        <br>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
   </div>

</div>
<!-- modal-gallery is the modal dialog used for the image gallery -->
<div id="modal-gallery" class="modal modal-gallery hide fade" data-filter=":odd">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">&times;</a>
        <h3 class="modal-title"></h3>
    </div>
    <div class="modal-body"><div class="modal-image"></div></div>
    <div class="modal_footer">
        <a class="btn modal-download" target="_blank">
            <i class="icon-download"></i>
            <span>Download</span>
        </a>
        <a class="btn btn-success modal-play modal-slideshow" data-slideshow="5000">
            <i class="icon-play icon-white"></i>
            <span>Slideshow</span>
        </a>
        <a class="btn btn-info modal-prev">
            <i class="icon-arrow-left icon-white"></i>
            <span>Previous</span>
        </a>
        <a class="btn btn-primary modal-next">
            <span>Next</span>
            <i class="icon-arrow-right icon-white"></i>
        </a>
    </div>
</div>
<div style="display:none;" class="myKeyValueDiv">
	<input type="hidden" cond="true" condName="target_uid">
	<input type="hidden" cond="true" condName="target_table">
	<input type="hidden" cond="true" condName="target_col">
	<input type="hidden" cond="true" condName="file_type_name">
	<input id="file_type" type="hidden" cond="true" condName="file_type">
	<input type="hidden" cond="true" condName="create_user" value="">
	<input type="hidden" id="previewFileid">
</div>


   
<script type="text/javascript" charset="utf-8">


var g_nameMaxlength = 12;
//----------------------------------------
//-点击表格中“添加文件”按钮的事件
//----------------------------------------	
function doSelectFile(obj){
	var inputArr = $(".myKeyValueDiv input");
	for(var xx=0;xx<inputArr.length;xx++){
		if(inputArr[xx].getAttribute("cond")=="true"){
			if(inputArr[xx].getAttribute("condName")=="fjlb"){
				inputArr[xx].value=$(obj).attr("fjlb");
			}
		}
	}
	document.getElementById("fileupload_btn").click();
}
function optionsHandler(obj){
	var imageType = "true";
	$(".showFileTab").each(function(i){
		var fjlb = $(this).attr("fjlb");
		if(fjlb=="image"){
			obj.acceptFileTypes = /(\.|\/)(gif|jpe?g|png)$/i;
		}else if(fjlb=="video"){
			obj.acceptFileTypes = /(\.|\/)(mp4)$/i;
		}else if(fjlb=="audio"){
			obj.acceptFileTypes = /(\.|\/)(mp3)$/i;
		}else if(fjlb=="media"){
			obj.acceptFileTypes = /(\.|\/)(gif|jpe?g|png|mp4|mp3|aac)$/i;
		}
		else{
			obj.acceptFileTypes = /.+$/i;
		}
	});
	
	return obj;
}
function setTargetUid(){				
	$.ajax({
		url:"${pageContext.request.contextPath }/fileUploadUtilController?getTargetUid",
		data:"",
		dataType:"json",
		async:false,
		success:function(result){
			var target_uid = result.msg;
			
			var inputArr = $(".myKeyValueDiv input");
			if($("#target_uid").val()==undefined || $("#target_uid").val()==""){
				$("#target_uid").val(target_uid);
				for(var xx=0;xx<inputArr.length;xx++){
					if(inputArr[xx].getAttribute("cond")=="true"){
						if(inputArr[xx].getAttribute("condName")=="target_uid"){
							inputArr[xx].value=$("#target_uid").val();
						}
					}
				}
			}
		}
	});
}
var scripts1 = [null]

$(function() {
 var url = '${pageContext.request.contextPath }/UploadUtilServlet';
    //初始化业务ID
 setTargetUid();		    
    //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
 $('#fileupload').fileupload({
						    
        autoUpload: true,//是否自动上传
		maxFileSize: 200000000,//大小限制，20M
        url: url,//上传地址
        dataType: 'json',
        maxNumberOfFiles: 9999,//允许最多上传数量，用户要求不要限制，这里直接给个大点的数值
        done: function (e, data) {//设置文件上传完毕事件的回调函数
            var that = $(this).data('fileupload'),
                template;
            if (data.context) {
                data.context.each(function (index) {
                    var file = ($.isArray(data.result) &&
                            data.result[index]) || {error: 'emptyResult'};
                    if (file.error) {
                        that._adjustMaxNumberOfFiles(1);
                    }
                    that._transition($(this)).done(
                        function () {
                            var node = $(this);
                            template = that._renderDownload([file])
                                .replaceAll(node);
                            that._forceReflow(template);
                            that._transition(template).done(
                                function () {
                                    data.context = $(this);
                                    that._trigger('completed', e, data);
                                }
                            );
                        }
                    );
                });
            } else {
                if ($.isArray(data.result)) {
                    $.each(data.result, function (index, file) {
                        if (data.maxNumberOfFilesAdjusted && file.error) {
                            that._adjustMaxNumberOfFiles(1);
                        } else if (!data.maxNumberOfFilesAdjusted &&
                                !file.error) {
                            that._adjustMaxNumberOfFiles(-1);
                        }
                    });
                    data.maxNumberOfFilesAdjusted = true;
                }
                template = that._renderDownload(data.result)
                    .appendTo(that.options.filesContainer);
                that._forceReflow(template);
                that._transition(template).done(
                    function () {
                        data.context = $(this);
                        that._trigger('completed', e, data);
                    }
                );
            }
            
        	insertFileTab(JSON.stringify(data.result));//不再向download模版里面画结果，画到自己的table里
        },
        progressall: function (e, data) {//设置上传进度事件的回调函数
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('.progress-success .bar').css(
                'width',
                progress + '%'
            );
        }
        
  });

});



//----------------------------------------
//-清空附件列表
//----------------------------------------
function clearFileTab(n){
	
	$(".showFileTab").each(function(){
		
		if($(this).attr("notClear")=="true"){
			//doNothing
		}else{
			$(this).empty();
		}
	});
	if(n=="query"){
		//do nothing
	}else{
		var inputArr = $(".myKeyValueDiv input");
		for(var xx=0;xx<inputArr.length;xx++){
			if(inputArr[xx].getAttribute("cond")=="true"){
				if(inputArr[xx].getAttribute("condName")=="target_uid"){
					inputArr[xx].value="";
				}else if(inputArr[xx].getAttribute("condName")=="target_table"){
					inputArr[xx].value="";
				}else if(inputArr[xx].getAttribute("condName")=="target_col"){
					inputArr[xx].value="";
				}else if(inputArr[xx].getAttribute("condName")=="file_type_name"){
					inputArr[xx].value="";
				}else if(inputArr[xx].getAttribute("condName")=="file_type"){
					inputArr[xx].value="0";
				}
			}
		}
	}
}

function insertFileTab(result){
	var files = eval('(' + result + ')');
	//console.log(result);
	if(g_nameMaxlength==undefined){
		g_nameMaxlength=12;
	}
	var tab_width = 0;
	$(".showFileTab").each(function(i){
		tab_width = $(this).parent().parent().width();
		$(this).parent().addClass("nomargin");
		var showType = $(this).attr("showType");
	
		if(showType!=undefined){
			insertimageDetailTabtab($(this),files,tab_width);
		}else{
			insertDetailTab($(this),files,tab_width);
		}
	});
}
//----------------------------------------
//-预览图片
//----------------------------------------
function showPreview(n){

	$("#previewFileid").val(n);
	
	window.open(encodeURI("${pageContext.request.contextPath }/jsp/file_upload/showPreview.jsp"));
}
//----------------------------------------
//-删除附件数据,只能删除附件状态为0的数据
//-@param targetTable 对应表名
//-@param targetUid 对应表uid
//-@param fileType	文件类型
//----------------------------------------
function deleteFileData(targetTable,targetUid,fileType){
	var obj = new Object();
	obj.TARGET_TABLE = targetTable;
	obj.TARGET_UID = targetUid;
	obj.FILE_TYPE = fileType;
	obj.ENABLED = "0";
	var data = JSON.stringify(obj);
		var data1 = defaultJson.packSaveJson(data);
		$.ajax({
		url : "${pageContext.request.contextPath }/fileUploadOldController?deleteFile",
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",
		success : function(result) {
		}
	});
}

//----------------------------------------
//-对关键字段进行赋值操作，保证新增的记录数据完整
//-@param targetTable 对应表名
//-@param targetCol 对应列名
//-@param targetUid 对应表uid
//-@param fileType	文件类型
//-@param fileType	文件类型名称
//----------------------------------------	
function setFileData(targetTable,targetCol,targetUid,fileType){
	var inputArr = $(".myKeyValueDiv input");
	
	//alert(targetCol);
	//alert(targetUid);
	
	if($("#target_uid").val()==undefined || $("#target_uid").val()==""){
		$("#target_uid").val(targetUid); 
	}
	
	for(var xx=0;xx<inputArr.length;xx++){
		if(inputArr[xx].getAttribute("cond")=="true"){
			if(inputArr[xx].getAttribute("condName")=="target_table"){
				inputArr[xx].value=targetTable;
			}else if(inputArr[xx].getAttribute("condName")=="target_uid"){
				inputArr[xx].value=targetUid;
				
			}else if(inputArr[xx].getAttribute("condName")=="file_type"){
				inputArr[xx].value=fileType;
			}else if(inputArr[xx].getAttribute("condName")=="target_col"){
				inputArr[xx].value=targetCol;
			}
		}
	}
}
//----------------------------------------
//-返回某个上传表格中的附件数量
//-@param  fjlb 附件类别，为空的话查询所有的表格
//----------------------------------------
function getFileCounts(fjlb){
	var tabArr = $(".showFileTab");
	var counts = 0;
	if(fjlb==undefined){
		$(".showFileTab").each(function(i){
			$(this).find("tr[class='template-download']").each(function(j){
				counts++;
			});
		});
	}else{
		$(".showFileTab").each(function(i){
			var tempFjlb = $(this).attr("fjlb");
			if(tempFjlb==fjlb){
				$(this).find("tr[class='template-download']").each(function(j){
					counts++;
				});
			}
		});
	}
	return counts;
}
//----------------------------------------
//-查询文件信息，并插入到表格
//-@param targetTable 对应表名
//-@param targetUid 对应表uid
//-@param fileType	文件类型

//----------------------------------------
function queryFileData(targetTable,targetUid){
	var obj = new Object();
	obj.TARGET_TABLE = targetTable;
	obj.TARGET_UID = targetUid;
	
	//obj.FILE_TYPE = fileType;
	var data = JSON.stringify(obj);
		var data1 = defaultJson.packSaveJson(data);
		$.ajax({
		url : "${pageContext.request.contextPath }/fileUploadUtilController?queryFileList",
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",
		success : function(result) {
			clearFileTab("query");
			insertFileTab(result.msg);
		}
	});
}

function queryFileData_insert(targetTable,targetUid){
	var obj = new Object();
	obj.TARGET_TABLE = targetTable;
	obj.TARGET_UID = targetUid;
	
	//obj.FILE_TYPE = fileType;
	var data = JSON.stringify(obj);
		var data1 = defaultJson.packSaveJson(data);
		$.ajax({
		url : "${pageContext.request.contextPath }/fileUploadUtilController?queryFileData_insert",
		data : data1,
		cache : false,
		async :	false,
		dataType : "json",
		success : function(result) {
			clearFileTab("query");
			insertFileTab(result.msg);
		}
	});
}
//----------------------------------------
//-查询文件信息，并插入到表格 
//-@param targetTable 对应表名
//-@param targetUid 对应表uid
//-@param fileType	文件类型
//----------------------------------------
function queryImageData(targetTable,targetUid,fileType){
	var obj = new Object();
	obj.TARGET_TABLE = targetTable;
	obj.TARGET_UID = targetUid;
	obj.FILE_TYPE = fileType;
	var data = JSON.stringify(obj);
		var data1 = defaultJson.packSaveJson(data);
		$.ajax({
		url : "${pageContext.request.contextPath }/fileUploadUtilController?queryFileList",
		data : data1,
		cache : false,
		async :	true,
		dataType : "json",
		success : function(result) {
			clearFileTab("query");
			insertImageTab(result.msg);
		}
	});
}

function insertDetailTab(obj,files,tab_width){
	var file_type = obj.attr("file_type");
	for(var i=0;i<files.length;i++){
		var showHtml = "";
		var file = files[i];
		
		//上传附件之后 返回 当前附件的 信息
		var objUrl = file.url;
		var xmFileType = file.FILE_TYPE;
		/**说明是项目信息展示页面  所以要 限定显示的 图片类型**/
		if(xmFileType == "10001" && $("#xmShowTP").val() == "1" && objUrl != null  ){
		   $("#showPICTURES").attr("src",objUrl);
		}
		
		
		//对关键字段赋值
		$("#target_uid").val(file.TARGET_UID);
		var inputArr = $(".myKeyValueDiv input");
		for(var xx=0;xx<inputArr.length;xx++){
			if(inputArr[xx].getAttribute("cond")=="true"){
				if(inputArr[xx].getAttribute("condName")=="target_uid"){
					inputArr[xx].value=file.TARGET_UID;
				}
			}
		}
		var number = 0;
		
		//如果table没有附件类别，那么插入所有数据，否则只插入附件类别相匹配的数据
		if(file_type==undefined || file_type==file.FILE_TYPE){
			showHtml +="<tr class='template-download'   rowid='"+file.FILE_UID+"'>";
			showHtml +="<td class='name' style='border:0;padding:0px;'>";
			//名字长度过长，折行处理
			if(file.FILE_NAME.length>30){
				showHtml +="<span class='my-showPreview-btn nameSpan' style='cursor:hand' fileid='"+file.FILE_UID+"'><abbr title='"+file.FILE_NAME+"'>"+file.FILE_NAME.substring(0,g_nameMaxlength)+"...</abbr></span>"
			}else{
				showHtml +="<span class='my-showPreview-btn nameSpan' style='cursor:hand' fileid='"+file.FILE_UID+"' target='_blank'>"+file.FILE_NAME+"</span>"
			}
			showHtml +="</td>";
			if(obj.attr("showSize")!="false"){
				showHtml +="<td class='size ' style='border:0;padding:0px;'>"+file.FILE_SIZE/1000+"KB</td>";
			}
			//if(obj.attr("showLrr")!="false" && obj.attr("showLrr")!=undefined){
			//	showHtml +="<td class='size ' style='border:0;padding:0px;text-align:right;'>"+file.lrr+"</td>";
			//}
			//if(obj.attr("showLrsj")!="false" && obj.attr("showLrsj")!=undefined){
			//	showHtml +="<td class='size ' style='border:0;padding:0px;'>"+file.lrsj+"</td>";
			//}

			showHtml +="<td class='delete ' style='border:0;padding:0px;'>";
			
			if(obj.attr("onlyView")=="true"){
					//如果是只读表格，那么不需要删除按钮
				if(obj.attr("deleteUser")!=undefined && obj.attr("deleteUser")==file.lrrCode){
// 								showHtml +="<td class='delete ' style='border:0;padding:0px;'>";
						showHtml +="<button class='btn btn-link my-del-btn' data-type='"+file.delete_type+"' data-url='"+file.delete_url+"' >";
						showHtml +="<i class='icon-trash'></i>";
						showHtml +="<span>删除</span>";
						showHtml +="</button>";
						//showHtml +="<input type='checkbox' name='delete' value='1'>"
// 								showHtml +="</td>"
// 								showHtml +="<td class='myPreview' style='border:0;padding:0px;'>";
					}else{
// 								showHtml +="<td class='myPreview' style='border:0;text-align:center;padding:0px;'>";
					}
			}else{
					showHtml +="<button class='btn btn-link my-del-btn' data-type='"+file.delete_type+"' data-url='"+file.delete_url+"&FILE_UID="+file.FILE_UID+"' >";
					showHtml +="<i class='icon-trash'></i>";
					showHtml +="<span>删除</span>";
					showHtml +="</button>";
				}
	
			showHtml +="<a href='"+file.url+"' class='btn btn-link' fileid='"+file.FILE_UID+"' download='"+file.FILE_NAME+"'>";
			showHtml +="<i class='icon-download-alt'></i>";
			showHtml +="<span>下载</span>";
			showHtml +="</a>&nbsp;";
		
			showHtml +="</td>";
			showHtml +="</tr>";
			var showHtmlHead = "";

			showHtmlHead += showHtml;
			obj.append(showHtmlHead);
		}
	}

}

function  insertimageDetailTabtab(obj,files,tab_width){
    var file_type = obj.attr("file_type");
	var showType = obj.attr("showType");
	var stArr = showType.split(";");
	var _height = "";
	var _heights = "";
	var _width = "";
	var _heightss="";
	var _quanxian="true";//查看页面false,不显示删除
	var _del = "true";		//多张图片时，是否自动删除旧数据
	var _attr = "single";	//单张图片还是多张图片
	var _noborder = "false";//是否有边框
	var _maxnum = "9999";	//控制图片最多显示的数量
	var _imgalign = "left";
	var _preview = "false";
	var _miaoshu ="";//判断图片是否有描述
	for(var stx=0;stx<stArr.length;stx++){
		var attrArr = stArr[stx].split(":");
		for(var attx=0;attx<attrArr.length;attx++){
			if(attrArr[0]=="width"){
				_width = "width:"+attrArr[1]+";";
			}else if(attrArr[0]=="height"){
				_height = "height:"+attrArr[1]+";";
			}else if(attrArr[0]=="heights"){
				_heights = "heights:"+attrArr[1]+";";
			}else if(attrArr[0]=="heightss"){
				_heightss = "heightss:"+attrArr[1]+";";
			}else if(attrArr[0]=="quanxian"){
				_quanxian = attrArr[1];
			}
			else if(attrArr[0]=="del"){
				_del = attrArr[1];
			}else if(attrArr[0]=="attr"){
				_attr = attrArr[1];
			}else if(attrArr[0]=="noborder"){
				_noborder = attrArr[1];
			}else if(attrArr[0]=="maxnum"){
				_maxnum = attrArr[1];
			}else if(attrArr[0]=="i-align"){
				_imgalign = attrArr[1];
			}else if(attrArr[0]=="preview"){
				_preview = attrArr[1];
			}else if(attrArr[0]=="miaoshu"){
				_miaoshu = attrArr[1];
			}
		}
	}

  

	var imgNum = 0;
	for(var i=0;i<files.length;i++){
		var showHtml = "";
		var file = files[i];
		$("#target_uid").val(file.TARGET_UID);
		var inputArr = $(".myKeyValueDiv input");
		for(var xx=0;xx<inputArr.length;xx++){
			if(inputArr[xx].getAttribute("cond")=="true"){
				if(inputArr[xx].getAttribute("condName")=="target_uid"){
					inputArr[xx].value=file.TARGET_UID;
				}
			}
		}
		var FILE_NAME=file.FILE_NAME;
		var filee = FILE_NAME.split(".");	
		filee[1] = filee[1].toLowerCase();
			//如果table没有附件类别，那么插入所有数据，否则只插入附件类别相匹配的数据
			if(file_type==undefined || file_type==file.FILE_TYPE){
					imgNum++;
					var showHtml="";
					showHtml +="<div  class='template-download' style='"+_width+"height:80px;float:left;'>";
						if(_quanxian=="true"){
							showHtml+="<div   style='"+_width+"height:80px;float:left; position: relative;'>"
							if(filee[1]=="rar"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/rar.png' class='hierarchy' />"
							}else if(filee[1]=="txt"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/txt.png' class='hierarchy' />"
							}else if(filee[1]=="pdf"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/pdf.png' class='hierarchy' />"
							}else if(filee[1]=="ppt" || filee[1]=="pptx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/ppt.png' class='hierarchy' />"
							}else if(filee[1]=="xls" || filee[1]=="xlsx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/excel.png' class='hierarchy' />"
							}else if(filee[1]=="doc" || filee[1]=="docx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/word.png' class='hierarchy' />"
							}else if(filee[1]=="mp3"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/mp3.png' class='hierarchy' />"
							}else if(filee[1]=="mp4"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/mp4.png' class='hierarchy' />"
							}else if(filee[1]=="rm"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/rm.png' class='hierarchy' />"
							}else if(filee[1]=="wmv"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/wmv.png' class='hierarchy' />"
							}else if(filee[1]=="html"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/html.png' class='hierarchy' />"
							}else if(filee[1]=="psd"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/psd.png' class='hierarchy' />"
							}else if(filee[1]=="avi"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/avi.png' class='hierarchy' />"
							}else if(filee[1]=="dwg"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/dwg.png' class='hierarchy' />"
							}else{
							   if(file.MIME_TYPE.indexOf("image")!=-1 ||filee[1]=="bmp"){
							      showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/jpg.png' class='hierarchy' />"
							   }else{
							    showHtml+="<img style='"+_width+"height:80px'' src='${pageContext.request.contextPath }/assets/img/wendang3/qita.png' class='hierarchy' />"
                               }
							}
							/* showHtml+="<p class='ImgTitle'>"+file.FILE_NAME+"</p>" */
							showHtml+="<div class='formText' title='"+file.FILE_NAME+"'>"
							showHtml+="<div class='formInner'>"
							showHtml+="<a href='"+file.url+"' title=\"下载\">"
							showHtml+="<i class='ace-icon fa fa-cloud-download'></i></a>"
							if(_del=='true'){  
							showHtml+="<a class='my-del-btn' title=\"删除\" data-type='"+file.delete_type+"' data-url='"+file.delete_url+"&FILE_UID="+file.FILE_UID+"'>"
							showHtml+="<i class='glyphicon fontS16 glyphicon-trash'></i></a>"
							}
							showHtml+="</div>"
							/* if(file.MIME_TYPE.indexOf("image")!=-1){
							        if(file.DESCRIPTION==undefined){
										showHtml+=" <p class='jiao'></p><div class='describe'><input type='hidden'  fieldname='f_FILE_UID'  value='"+file.FILE_UID+"'/><textarea  fieldname='f_DESCRIPTION'  placeholder='描述'  ></textarea></div>"
									}else{
									    showHtml+=" <p class='jiao'></p><div class='describe'><input type='hidden'  fieldname='f_FILE_UID'  value='"+file.FILE_UID+"'/><textarea  fieldname='f_DESCRIPTION'  placeholder='描述' >"+file.DESCRIPTION+"</textarea></div>"
									}
						    }else{
						            showHtml+=" <p class='jiao' style='display:none;'></p><div class='describe' style='display:none;'><input type='hidden'  fieldname='f_FILE_UID'  /><div class='describe'><input type='hidden'  fieldname='f_DESCRIPTION'  /></div>"
						    } */
						}else {
					
							showHtml+="<div   style='"+_width+"height:80px;float:left; position: relative;'>"
							if(filee[1]=="rar"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/rar.png' class='hierarchy' />"
							}else if(filee[1]=="txt"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/txt.png' class='hierarchy' />"
							}else if(filee[1]=="pdf"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/pdf.png' class='hierarchy' />"
							}else if(filee[1]=="ppt" || filee[1]=="pptx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/ppt.png' class='hierarchy' />"
							}else if(filee[1]=="xls" || filee[1]=="xlsx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/excel.png' class='hierarchy' />"
							}else if(filee[1]=="doc" || filee[1]=="docx"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/word.png' class='hierarchy' />"
							}else if(filee[1]=="mp3"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/mp3.png' class='hierarchy' />"
							}else if(filee[1]=="mp4"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/mp4.png' class='hierarchy' />"
							}else if(filee[1]=="rm"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/rm.png' class='hierarchy' />"
							}else if(filee[1]=="wmv"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/wmv.png' class='hierarchy' />"
							}else if(filee[1]=="html"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/html.png' class='hierarchy' />"
							}else if(filee[1]=="psd"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/psd.png' class='hierarchy' />"
							}else if(filee[1]=="avi"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/avi.png' class='hierarchy' />"
							}else if(filee[1]=="dwg"){
							showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/dwg.png' class='hierarchy' />"
							}else{
							   if(file.MIME_TYPE.indexOf("image")!=-1 ||filee[1]=="bmp"){
							      showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/jpg.png' class='hierarchy' />"
							   }else{
							    showHtml+="<img style='"+_width+"height:80px' src='${pageContext.request.contextPath }/assets/img/wendang3/qita.png' class='hierarchy' />"
                               }
							}
							/* showHtml+="<p class='ImgTitle'>"+file.FILE_NAME+"</p>"; */
							showHtml+="<div class='formText' title='"+file.FILE_NAME+"'>";
							showHtml+="<div class='formInner'>";
							showHtml+="<a href='"+file.url+"'title=\"下载\">";
							showHtml+="<i class='ace-icon fa fa-cloud-download'></i></a>";
							showHtml+="</div>";
						}
					showHtml +="</div>";
						
				    
					

				
					var showHtmlHead=""
					showHtmlHead +="<tr class='fu_cellTr'>";
					showHtmlHead +="<td class='fu_cellTd'  colspan='3'  style='border:0px;padding:0px;'>";
					showHtmlHead +="<div class='p_container form_scY' style='border:10px;padding:10px;'>";
					showHtmlHead += showHtml;
					showHtmlHead +="</div>";
					showHtmlHead +="</td>";
					showHtmlHead +="</tr>";
					
					if(_attr=="multi"){
						//如果是多张图片，那么继续画表格
						if(imgNum>Number(_maxnum)){
							break;
						}else{
							var templateObj = obj.find(".fu_cellTr").find(".fu_cellTd").find(".p_container");//;
							
							if(templateObj.attr("class")!=undefined){
								templateObj.append(showHtml);	
								
							}else{		
								obj.append(showHtmlHead);					
							}
						}
					}else{
						//alert(showHtml);
						obj.append(showHtml);
						break;
					}
			} 
	}	
}

function insertImageTab(obj,files,tab_width){
	var file_type = obj.attr("file_type");
	
	var showType = obj.attr("showType");
	var stArr = showType.split(";");
	var _height = "";
	var _width = "";
	var _del = "true";		//多张图片时，是否自动删除旧数据
	var _attr = "single";	//单张图片还是多张图片
	var _noborder = "false";//是否有边框
	var _maxnum = "9999";	//控制图片最多显示的数量
	var _imgalign = "left";
	var _preview = "false";
	for(var stx=0;stx<stArr.length;stx++){
		var attrArr = stArr[stx].split(":");
		for(var attx=0;attx<attrArr.length;attx++){
			if(attrArr[0]=="width"){
				_width = "width:"+attrArr[1]+";";
			}else if(attrArr[0]=="height"){
				_height = "height:"+attrArr[1]+";";
			}else if(attrArr[0]=="del"){
				_del = attrArr[1];
			}else if(attrArr[0]=="attr"){
				_attr = attrArr[1];
			}else if(attrArr[0]=="noborder"){
				_noborder = attrArr[1];
			}else if(attrArr[0]=="maxnum"){
				_maxnum = attrArr[1];
			}else if(attrArr[0]=="i-align"){
				_imgalign = attrArr[1];
			}else if(attrArr[0]=="preview"){
				_preview = attrArr[1];
			}
		}
	}
	var imgNum = 0;
	for(var i=0;i<files.length;i++){
		var showHtml = "";
		var file = files[i];
		$("#target_uid").val(file.TARGET_UID);
		var inputArr = $(".myKeyValueDiv input");
		for(var xx=0;xx<inputArr.length;xx++){
			if(inputArr[xx].getAttribute("cond")=="true"){
				if(inputArr[xx].getAttribute("condName")=="target_uid"){
					inputArr[xx].value=file.TARGET_UID;
				}
			}
		}
		//如果table没有附件类别，那么插入所有数据，否则只插入附件类别相匹配的数据
		if(file_type==undefined || file_type==file.FILE_TYPE){
			if(file.fileType.indexOf("image")!=-1){
				imgNum++;
				if(_attr=="multi"){
					//多张图片就不需要删除了
					if(_noborder=="true"){
						showHtml +="<table class='fu_blockTable_half' cellspacing='0' cellpadding='0' style='border:0;text-align:center;'>";
					}else{
						showHtml +="<table class='fu_blockTable_half' cellspacing='0' cellpadding='0'>";
					}
				}else{
					var delBtn = obj.find("tr").find("td").find(".my-del-btn");
					if(delBtn.attr("class")!=undefined){
						delBtn.click();
					}
				}
				//showHtml +="<table class='fu_blockTable_full' style='background:#FFFFFF;text-align:center;padding:0px;border:0px;' cellspacing='0' cellpadding='0'>";
				showHtml +="<tr class='template-download fu_blockTable_full' style='text-align:center;'>";
				
				showHtml +="<td style='background:#FFFFFF;text-align:center;padding:0px;border:0px;'>";
				//showHtml +="<a data-gallery='gallery' href='"+file.url+"' title='"+file.name+"' rel='gallery'><img src='"+file.thumbnail_url+"' width='70px' height='30px'></a>";
				if(_preview=="true"){
					showHtml +="<a href='javascript:void(0)' class='my-showPreview-btn nameSpan' fileid='"+file.FILE_UID+"'><img src='"+file.url+"' style='"+_width+_height+"'></a>";
				}else{
					showHtml +="<img src='"+file.url+"' style='"+_width+_height+"'>";
				}
				showHtml +="</td>"
				showHtml +="<td class='delete' style='border:0;padding:0px;display:none;'>";
				if(_del=="true"){
					showHtml +="<button class='btn btn-link my-del-btn' data-type='"+file.delete_type+"' data-url='"+file.delete_url+"' >";
				}else{
					showHtml +="<button class='btn btn-link my-del-btn' data-type='"+file.delete_type+"' data-url='"+file.modifyflag_url+"' >";
				}
				showHtml +="<i class='icon-trash'></i>";
				showHtml +="<span>删除</span>";
				showHtml +="</button>";
				showHtml +="</td>"
				showHtml +="</tr>";
				if(_attr=="multi"){
					showHtml +="</table>";
				}
				var showHtmlHead = "";
				showHtmlHead +="<tr class='fu_cellTr'>";
				showHtmlHead +="<td class='fu_cellTd' style='border:0px;padding:0px;'>";
				showHtmlHead +="<div class='p_container' style='border:0px;padding:0px;'>";
				showHtmlHead += showHtml;
				showHtmlHead +="</div>";
				showHtmlHead +="</td>";
				showHtmlHead +="</tr>";
				if(_attr=="multi"){
					//如果是多张图片，那么继续画表格
					if(imgNum>Number(_maxnum)){
						break;
					}else{
						var templateObj = obj.find(".fu_cellTr").find(".fu_cellTd").find(".p_container");//;
						if(templateObj.attr("class")!=undefined){
							templateObj.append(showHtml);
						}else{
							obj.append(showHtmlHead);
						}
					}
				}else{
					obj.append(showHtml);
					break;
				}
			}else{
				continue;
			}
		}
	}
	
}

</script>

<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="preview"><span class="fade"></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary">
                    <i class="icon-upload icon-white"></i>
                    <span>{%=locale.fileupload.start%}</span>
                </button>
            {% } %}</td>
        {% } else { %}
            <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i>
                <span>{%=locale.fileupload.cancel%}</span>
            </button>
        {% } %}</td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
            <td></td>
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else { %}
            <td class="preview">{% if (file.thumbnail_url) { %}
                <a href="{%=file.url%}" title="{%=file.name%}" rel="gallery" download="{%=file.name%}"><img src="{%=file.thumbnail_url%}"></a>
            {% } %}</td>
            <td class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i>
                <span>{%=locale.fileupload.destroy%}</span>
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
    </tr>
{% } %}
</script>
    <script type="text/javascript">
            $(function(){
                $("#img1").click(function(){
                    var width = $(this).width();
                    if(width==100)
                    {
                        $(this).width(200);
                        $(this).height(300);
                    }
                    else
                    {
                        $(this).width(100);
                        $(this).height(150);
                    }
                });
            });
    </script>
</html>
