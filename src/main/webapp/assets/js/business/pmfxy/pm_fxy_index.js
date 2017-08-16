controllernameUrl = controllernameUrl+"pmfxy/pmFxyController";
var scripts =[null];
var gridwidth;
var setHeight; 

ace.load_ajax_scripts(scripts, function() {  
    initPara();
    beforeTable();
    initTable(); 
    top.hangge();
    afterTable();
    initListener(); 
   	var editFlag = true; //checkAuthority($("#project_uid").val(),$("#projectUserId").val(),"030101");
	if(!editFlag){
		$("#newAdd").hide();
		$("#grid_table").hideCol("operation").trigger("reloadGrid");
		$("#grid_table").jqGrid('setGridWidth',$("#inside").width());
	}
}); 



function initPara(){ 
    DatePicker.datepicker(".REPORT_DATE1");
    DatePicker.datepicker(".REPORT_DATE2"); 
    DatePicker.datepicker("#BEGIN_DATE");
    DatePicker.datepicker("#END_DATE");
    //setStyle($("#queryForm"));
	$("#PROJECT_UID").val($("#project_uid").val());  
}

function beforeTable(){
	gridwidth=$("#inside").width(); 
	setHeight = $(window).height()-220; 
	var rownum=10;//默认行数
    var rowHeight=60;//默认高度
	
	
	/*if(navigator.userAgent.indexOf("Firefox") > -1){
	   setHeight = setHeight+50;
	} 
	$("#grid_table").attr('jqgridheight',setHeight);
	if( setHeight % rowHeight == '0'){
		rownum = setHeight / rowHeight; 
	}else{ 
		rownum = ( setHeight - ( setHeight % rowHeight ) ) / rowHeight ; 
	} 
	*/ 
    setHeight = parseInt(setHeight);
	$("#grid_table").attr('jqgridheight',setHeight); 
    if(setHeight%rowHeight==0){
    	rownum = setHeight/rowHeight; 
    }else{
    	rownum = setHeight/rowHeight-1;
    }
    rownum = parseInt(rownum);
	$("#grid_table").attr('rownum',rownum);  
	//删除多余的 div 避免弹出图片时出现多层
	var div1 = $(".jquery-lightbox-overlay").eq(0);
	var div2 = $(".jquery-lightbox-move").eq(0); 
	$(".jquery-lightbox-overlay").remove();
	$(".jquery-lightbox-move").remove();
	$("body").append(div1);
	$("body").append(div2); 
	
	
}

function initTable(){
	JqgridManage.initJqgrid(grid_table,queryForm,gridwidth);
	//$("#grid_table").setGridHeight(setHeight - 320); 
	 //改变浏览器大小自适应
	 $(window).on(
				'resize.jqGrid',
				function() {
					$("#grid_table").jqGrid(    //jqGridtable 自适应width
							'setGridWidth',
							$("#inside").width());
				});
		$(window).triggerHandler('resize.jqGrid'); 
}

function afterTable(){
	$('#gview_grid_table').width((gridwidth-20));
	$('#grid_table_page66749').width(gridwidth-20);
	//$(".ui-pg-selbox").hide();
	//console.info($(".ui-pg-selbox"));
}


function initListener(){
		 $(document).keypress(function(e) {  
		    // 回车键事件  
	       if(e.which == 13) {  
	           jQuery("#grid_table").jqGrid().trigger("reloadGrid");
	       }  
		 }); 
		     
	    //查询按钮 (报表)
		$("#searchForPlan").click(function(){ 
		    jQuery("#grid_table").jqGrid().trigger("reloadGrid");
		}); 
		
		
		$('#newAdd').click(function() {
		$('#newAdd').attr("data-target","table-input");
			$('#table-input').removeData("bs.modal");
			$("#table-input").empty();
			$('#table-input').modal({
				backdrop: 'static'
			});
			
			$.get(ctx+"/page/business/pmfxy/pm_fxy_add",function(data) {
				$("#table-input").empty();
				$("#table-input").html("");
				$("#table-input").html(data);
			}); 
		});
		
		 $('#grid_table').on('mouseenter','.tt',function(event){ 
			    var  GZJL_FILE_NAMES = $(this).attr("title");
			 	var gzjl_file_names_array =GZJL_FILE_NAMES.split(";"); //字符分割  
		    
		       $("#showFileContents").empty(); 
		       $("#showFileContents").append("<tr><th>文件名</th><th>上传时间</th></tr>");
			   for (var i=0;i<gzjl_file_names_array.length ;i++ ) { 
			        var tr = $("<tr>");
			        console.info("--"+gzjl_file_names_array[i]);
			        var tds =gzjl_file_names_array[i].split(","); 
			        for (var j=0;j<tds.length ;j++ ) {
			            console.info("td"+tds[j]);
			           // alert(tds[j]);
			            var td = $("<td>").append(tds[j]);  
			      	    tr.append(td);
			        } 
			        $("#showFileContents").append(tr); 
			   }
		    
			$('.workBox').css({
					position: 'fixed',
					right: ($(window).width() - event.pageX ) + 'px',
					top: event.pageY - 5 + 'px',
					display:'block'
				});
			});
			$('.workBox').on('mouseleave',function(event){
				$('.workBox').css('display','none');

			}); 
}

 

function fxyTypeFormat(cellvalue, opts, rowObject){
    var FXY_TYPE = rowObject.FXY_TYPE;
    var WXYS = rowObject.WXYS;
	var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var FXY_UID = rowObject.FXY_UID;
	var showHtml =""; 
	showHtml +="<a class=\"h_black\" title=\"查看风险源信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
	showHtml +="onclick=\"showFileList('"+FXY_UID+"','"+PROJECT_UID+"');\">" ;
	showHtml +=WXYS+"</a>&nbsp;"; 	
	return 	showHtml;
}

function doUpdate(cellvalue, opts, rowObject){
	var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var FXY_UID = rowObject.FXY_UID;
	var showHtml ="<div class='hidden-sm hidden-xs action-buttons'>";
  
	//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"12090002")){
		showHtml +="<a class=\"blue\" title=\"修改风险源信息\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"eidtLlog('"+FXY_UID+"','"+PROJECT_UID+"');\">";
		showHtml +="<span class=\"glyphicon glyphicon-edit bigger-110\"></i>";
		showHtml +="</a> &nbsp;";
	//}
	//if(checkTabAuthority($("#project_uid").val(),$("#projectUserId").val(),"12090003")){
		showHtml +="<a class=\"blue\" title=\"删除\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +=	" onclick=\"removeData('"+FXY_UID+"');\">";
		showHtml +="<span class=\"glyphicon colorshow1 glyphicon-trash bigger-110\"></i>";
		showHtml +="</a>&nbsp;";
	//}  
	return 	showHtml;
}

function yjyaFotmatter(cellvalue, opts, rowObject){
	var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var FXY_UID = rowObject.FXY_UID;
	var showHtml ="";  
	
	var YJYA_FILE_NAMES = rowObject.YJYA_FILE_NAMES;   
	if(YJYA_FILE_NAMES!=''){ 
		showHtml +="<a class=\"blue\" title=\"应急预案\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +="onclick=\"showFileList('"+FXY_UID+"','"+PROJECT_UID+"');\">" ;
		showHtml +="<span class=\"glyphicon bigger-110\"><img src='"+ctx+"/assets/img/yingji.png'></span>" ;
		showHtml +="</a>&nbsp;"; 
	}
	return 	showHtml;
}

function wjqdFotmatter(cellvalue, opts, rowObject){
	var log_uid = rowObject.PROJECT_LOG_UID;
	var PROJECT_UID = rowObject.PROJECT_UID; 
	var FXY_UID = rowObject.FXY_UID;
	var GZJL_FILE_NAMES = rowObject.GZJL_FILE_NAMES;   
	var showHtml ="";  
	if(GZJL_FILE_NAMES!=''){ 
		showHtml +="<a class=\"blue\" title=\""+GZJL_FILE_NAMES+"\" data-target=\"content_view\"  href=\"javascript:void(0);\"" ;
		showHtml +="onclick=\"showFileList('"+FXY_UID+"','"+PROJECT_UID+"');\">" ;
		showHtml +="<span class=\"glyphicon bigger-110 tt\"   title=\""+GZJL_FILE_NAMES+"\"><img src='"+ctx+"/assets/img/gongzuo.png'></span>" ;
		showHtml +="</a>&nbsp;";
	}

	return 	showHtml;
}



function showFileList(FXY_UID,project_uid){
	$('#newAdd').attr("data-target","table-input");
	$('#table-input').removeData("bs.modal");
	$("#table-input").empty();
	$('#table-input').modal({
		backdrop: 'static'
	});
	
	$.get(ctx+"/page/business/pmfxy/pm_fxy_detail?FXY_UID="+FXY_UID+"&PROJECT_UID="+project_uid,function(data) {
		$("#table-input").empty();
		$("#table-input").html("");
		$("#table-input").html(data);
	});
}
function eidtLlog(FXY_UID,project_uid,yanshou_type){
		$('#newAdd').attr("data-target","table-input");
		$('#table-input').removeData("bs.modal");
		$("#table-input").empty();
		$('#table-input').modal({
			backdrop: 'static'
		});
		
		$.get(ctx+"/page/business/pmfxy/pm_fxy_edit?FXY_UID="+FXY_UID+"&PROJECT_UID="+project_uid,function(data) {
			$("#table-input").empty();
			$("#table-input").html("");
			$("#table-input").html(data);
		});
}

function removeData(FXY_UID){
		bootbox.confirm("确认删除吗？", function(result) {
		
		if (result) {
		 var data="{'response':{'data':[{'FXY_UID':'"+FXY_UID+"'}]}}";						
			$.ajax({
				url :controllernameUrl+'?delete',
				data : {"msg":data},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
						xAlert("信息提示","删除成功",1);
					_reload(); 
			      }
			}); 	
		} else {
			return;
		}
	});
}

function _reload(){
	jQuery("#grid_table").jqGrid().trigger("reloadGrid");
	afterTable();
}