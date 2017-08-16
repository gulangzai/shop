<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/commons/taglib.jsp"%>
<%-- <%@ include file="/jsp/commons/commons.jspf"%>   --%>
<html>
<head> 
<title>简单表格</title>

    <link id="uiThemes" rel="stylesheet" href="${ctxStatic}/css/jquery-ui-1.10.2.custom.min.css"  type="text/css" />  
	<link rel="stylesheet" href="${ctxStatic}/assets/css/jquery-ui.css"   type="text/css"/> 
	<link rel="stylesheet" href="${ctxStatic}/assets/css/ui.jqgrid.css"   type="text/css"/>  
	<link href="${ctxStatic}/assets/css/bootstrap.css" rel="stylesheet" /> 
    <link rel="stylesheet" href="${ctxStatic}/assets/css/datepicker.css" />
    <link rel="stylesheet" href="${ctxStatic}/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
    
	
	
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-sm-12"></div>
					<table id="grid-table" class="table table-striped table-hover">
						<thead>
							<tr>
								<th>编号</th>
								<th>用户名</th>
								<th>密码</th>
								<th>姓名</th>
								<th>邮箱</th>
								<th>手机号</th>
							</tr>
						</thead>
					</table>
					<div id="grid-pager"></div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="${ctxStatic}/assets/js/jquery.js"></script> 
<script type="text/javascript" src="${ctxStatic}/assets/js/bootstrap.js"></script> 
<script src="${ctxStatic}/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="${ctxStatic}/assets/js/jqGrid/jquery.jqGrid.src.js"></script>
<script src="${ctxStatic}/assets/js/jqGrid/i18n/grid.locale-en.js"></script> 
		
<script type="text/javascript">
jQuery(function($){
	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";
	$(window).on('resize.jqGrid',function(){
		$(grid_selector).jqGrid('setGridWidth',$(".page-content").width());
	});
	
	var parent_column = $(grid_selector).closest('[class*="col-"]');
	$(document).on('settings.ace.jqGrid',function(ev,event_name,collapsed){
		if(event_name==='sidebar_collapsed'||event_name==='main_container_fixed'){
		setTimeout(function(){
			$(grid_selector).jqGrid('setGridWidth',parent_column.width());
		},0);
	  }
	})
	
	var grid_data = 
			[ 
				{id:"1",name:"Desktop Computer",note:"note",stock:"Yes",ship:"FedEx", sdate:"2007-12-03"},
				{id:"2",name:"Laptop",note:"Long text ",stock:"Yes",ship:"InTime",sdate:"2007-12-03"},
				{id:"3",name:"LCD Monitor",note:"note3",stock:"Yes",ship:"TNT",sdate:"2007-12-03"},
				{id:"4",name:"Speakers",note:"note",stock:"No",ship:"ARAMEX",sdate:"2007-12-03"},
				{id:"5",name:"Laser Printer",note:"note2",stock:"Yes",ship:"FedEx",sdate:"2007-12-03"},
				{id:"6",name:"Play Station",note:"note3",stock:"No", ship:"FedEx",sdate:"2007-12-03"},
				{id:"7",name:"Mobile Telephone",note:"note",stock:"Yes",ship:"ARAMEX",sdate:"2007-12-03"},
				{id:"8",name:"Server",note:"note2",stock:"Yes",ship:"TNT",sdate:"2007-12-03"},
				{id:"9",name:"Matrix Printer",note:"note3",stock:"No", ship:"FedEx",sdate:"2007-12-03"},
				{id:"10",name:"Desktop Computer",note:"note",stock:"Yes",ship:"FedEx", sdate:"2007-12-03"},
				{id:"11",name:"Laptop",note:"Long text ",stock:"Yes",ship:"InTime",sdate:"2007-12-03"},
				{id:"12",name:"LCD Monitor",note:"note3",stock:"Yes",ship:"TNT",sdate:"2007-12-03"},
				{id:"13",name:"Speakers",note:"note",stock:"No",ship:"ARAMEX",sdate:"2007-12-03"},
				{id:"14",name:"Laser Printer",note:"note2",stock:"Yes",ship:"FedEx",sdate:"2007-12-03"},
				{id:"15",name:"Play Station",note:"note3",stock:"No", ship:"FedEx",sdate:"2007-12-03"},
				{id:"16",name:"Mobile Telephone",note:"note",stock:"Yes",ship:"ARAMEX",sdate:"2007-12-03"},
				{id:"17",name:"Server",note:"note2",stock:"Yes",ship:"TNT",sdate:"2007-12-03"},
				{id:"18",name:"Matrix Printer",note:"note3",stock:"No", ship:"FedEx",sdate:"2007-12-03"},
				{id:"19",name:"Matrix Printer",note:"note3",stock:"No", ship:"FedEx",sdate:"2007-12-03"},
				{id:"20",name:"Desktop Computer",note:"note",stock:"Yes",ship:"FedEx", sdate:"2007-12-03"},
				{id:"21",name:"Laptop",note:"Long text ",stock:"Yes",ship:"InTime",sdate:"2007-12-03"},
				{id:"22",name:"LCD Monitor",note:"note3",stock:"Yes",ship:"TNT",sdate:"2007-12-03"},
				{id:"23",name:"Speakers",note:"note",stock:"No",ship:"ARAMEX",sdate:"2007-12-03"}
			];
	
	
	$(grid_selector).jqGrid({
		url:'${ctx}/productCtrl/getProductList.do', 
 		datatype:'json', 
		height:250,
		colNames:['','id','name','productDesc'],
		colModel:[
		{   name:'myac',index:'',width:80,fixed:true,sortable:false,resize:false,
			formatter:'actions',
			formatoptions:{
				key:true,
				delOptions:{recreateForm:true,beforeShowForm:beforeDeleteCallback}
			}
		},
		{name:'id',index:'id',width:60,sorttype:"string"},
		{name:'name',index:'name',width:90,editable:true,editoptions:{size:"20",maxlength:"30"}},
		{name:'productDesc',index:'productDesc',width:60,editable:true}
		],
		viewrecords:true,
		rowNum:10,
		rowList:[10,20,30],
		pager:pager_selector,
		altRows:true,
		multiselect:true,
		multiboxonly:true,
		loadComplete:function(){
			var table = this;
			setTimeout(function(){
				styleCheckbox(table);
				updateActionIcons(table);
				updatePagerIcons(table);
				enableTooltips(table);
			},0);
		},
		editurl:"/edit.html",
		caption:'jqGrid with inline editing '
	});
	$(window).triggerHandler('resize.jqGrid');
	
	function updateActionIcons(table){}
	function updatePagerIcons(table){}
	function enableTooltips(table){}
	function styleCheckbox(table) {
		/**
			$(table).find('input:checkbox').addClass('ace')
			.wrap('<label />')
			.after('<span class="lbl align-top" />')
	
	
			$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
			.find('input.cbox[type=checkbox]').addClass('ace')
			.wrap('<label />').after('<span class="lbl align-top" />');
		*/
		}
	
	function beforeDeleteCallback(e){
		var form=$(e[0]);
		if(form.data('styled')) return false;
		form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').warpInner('<div class="widget-header"/>');
	    //style_delete_form(form);
	    form.data('styled',true);
	}
	function aceSwitch(cellvalue,options,cell){
		setTimeout(function(){
			$(cell).find('input[type=checkbox]')
			.addClass('ace ace-switch ace-switch-5')
			.after('<span class="lbl"></span>');
		});
	}
	
	function pickDate(cellvalue,options,cell){
		setTimeout(function(){
			$(cell).find('input[type=text]')
			.datepicker({format:'yyyy-mm-dd',autoclose:true});
		},0);
	}
	
	jQuery(grid_selector).jqGrid('navGrid',pager_selector,{
		edit:true,
		editioncon:'ace-icon fa fa'
	},
	{
		recreateForm:true,
	    beforeShowForm:function(e){
		  var form = $(e[0]);
		  form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header"/>');
	      style_edit_form(form);
	    }
	}
	);
	
	function style_edit_form(form){
	  form.find('input[name=sdate]').datepicker({format:'yyyymm-dd',autoclose:true});	
	  alert('style_edit_form');
	}
	
	function updatePagerIcons(table){
		var replacement = 
			{
				'ui-icon-seek-first':'ace-icon fa fa-angle-double-left bigger-140'
			};
		$('.ui-pg-table:not(.navtable)>tbody>tr>.ui-pg-button>.ui-icon').each(function(){
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon',''));
			if($class in replacement) icon.attr('class','ui-icon'+replacement[$class]);
		});
	}
	
	$(document).one('ajaxloadstart.page',function(e){
		$(grid_selector).jgGrid('GridUnload');
		$('.ui-jqdialog').remove();
	});
}); 
</script>


		
</html>