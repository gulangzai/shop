
/**
 * 表格生成类
 */
var JqgridManage  = new Object();	
/**
 * tableid： jqgrid的table
 * queryformid：查询条件的formid
 * */
JqgridManage.initJqgrid=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }
		$(jqgridtableid).each(function(){
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);	
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            success : function(resp) {
			    	//   alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData");
			           			
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	JqgridManage.updatePagerIcons(null);
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			   shrinkToFit: true,//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           //shrinkToFit:false, //不缩小去适应
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           rownumWidth:50,
	           rownumbers:true,//是否显示序号
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           multiboxonly: true,
	           altRows:true, 
	           jsonReader : {  
			    	root:function (obj){return obj.response.data;},
			    	total:function (obj){return obj.pages.totalpage;},
	     		    page:function (obj){return obj.pages.currentpagenum;},
	     		    records:function (obj){return obj.pages.countrows;}	   
				},
				loadComplete : function(data) {
				    var table = this;	 
					setTimeout(function(){
						//styleCheckbox(table);
						//enableTooltips(table);
						JqgridManage.updatePagerIcons(table);
					}, 0);
					if(json.loadComplete!=""&&json.loadComplete!=null){
						eval(json.loadComplete+"("+data+","+table+")");
					} 
				},
				gridComplete : function(){ 
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
					for ( var i in json.rowNameModel) {
						Merger(this.id,json.rowNameModel[i]);
					}
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}	
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				}
				
	           });

		});
		
		//公共调用方法
        function Merger(gridName, CellName) {
            //得到显示到界面的id集合
            var mya = $("#" + gridName + "").getDataIDs();
            //当前显示多少条
            var length = mya.length;
            for (var i = 0; i < length; i++) {
                //从上到下获取一条信息
                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
                //定义合并行数
                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {
                    //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', { display: 'none' });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }
	
};

/**
 * tableid： jqgrid _tree
 * */
JqgridManage.initJqgridTree=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }
		$(jqgridtableid).each(function(){
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);	
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            success : function(resp) {
			    	//   alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData");
			           			
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	updatePagerIcons(null);
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			    rownumbers : false,
			    rownumWidth : 50,
			    tree_root_level : 1,
				treeGrid : true,
				treeGridModel : "adjacency",
				ExpandColumn : json.ExpandColumn,
				treeIcons : {
				 	plus : '#ace-icon fa fa-chevron-circle-down',
					minus : '#ace-icon fa fa-chevron-circle-up',
					leaf : 'glyphicon glyphicon-list'
				},
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			   height: "false",//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           multiselect : false,
			   multiboxonly : false,
	           //shrinkToFit:false, //不缩小去适应
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           altRows:true,
	           jsonReader : {
									root : function(obj) {
										//console.info(obj);
										return obj;
									}
								/**      root:function (obj){return obj.response.data;},
								      total:function (obj){return obj.pages.totalpage;},
								      page:function (obj){return obj.pages.currentpagenum;},
								      records:function (obj){return obj.pages.countrows;}**/
								},
				loadComplete : function() {
									var table = this;
									setTimeout(function() {
										updatePagerIcons(table);
									}, 0);
								},
				gridComplete : function(){
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
					for ( var i in json.rowNameModel) {
						Merger(this.id,json.rowNameModel[i]);
					}
			        
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}	
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				}
				
	           });

		});
		
		//公共调用方法
        function Merger(gridName, CellName) {
            //得到显示到界面的id集合
            var mya = $("#" + gridName + "").getDataIDs();
            //当前显示多少条
            var length = mya.length;
            for (var i = 0; i < length; i++) {
                //从上到下获取一条信息
                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
                //定义合并行数
                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {
                    //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', { display: 'none' });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }
	
};
/**
 * tableid： jqgrid的table
 * queryformid：查询条件的formid
 * */
JqgridManage.initJqgrid01=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }
		$(jqgridtableid).each(function(){
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);	
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            success : function(resp) {
			    	//   alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData");
			           			
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	JqgridManage.updatePagerIcons(null);
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			   height: "false",//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           //shrinkToFit:false, //不缩小去适应
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           //rownumbers:true,//是否显示序号
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           multiboxonly: true,
	           altRows:true,
	           jsonReader : { 
			    	root:function (obj){return obj.response.data;},
			    	total:function (obj){return obj.pages.totalpage;},
	     		    page:function (obj){return obj.pages.currentpagenum;},
	     		    records:function (obj){return obj.pages.countrows;}	   
				},
				loadComplete : function(data) {
					var table = this;				
					setTimeout(function(){
						//styleCheckbox(table);
						//enableTooltips(table);
						JqgridManage.updatePagerIcons(table);
					}, 0);
					if(json.loadComplete!=""&&json.loadComplete!=null){
						eval(json.loadComplete+"("+data+","+table+")");
					}
				},
				gridComplete : function(){
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
					for ( var i in json.rowNameModel) {
						Merger(this.id,json.rowNameModel[i]);
					}
			       
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}	
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				}
				
	           });

		});
		
		//公共调用方法
        function Merger(gridName, CellName) {
            //得到显示到界面的id集合
            var mya = $("#" + gridName + "").getDataIDs();
            //当前显示多少条
            var length = mya.length;
            for (var i = 0; i < length; i++) {
                //从上到下获取一条信息
                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
                //定义合并行数
                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {
                    //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', { display: 'none' });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }
	
};

/**
 * 不缩小匹配的表格
 * @param {} tableid
 * @param {} queryformid
 * @param {} gridwidth
 */
JqgridManage.initJqgrid2=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }
		$(jqgridtableid).each(function(){
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);	
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            beforeSend: function(XMLHttpRequest) {
			                //清空数据
			            	jQuery("#"+jqgridtableid.id).jqGrid("clearGridData");
			            	//产生缓冲图标
			            	var loadtext = "<div style='position: absolute;left:45%;top:50px;width:100px;height: 100px;color:grey;text-align: center;'><i style='font-size:50px;' class='ace-icon fa fa-circle-o-notch fa-spin'></i><h4>&nbsp;&nbsp;&nbsp;Loading...</h4></div>";
					 		$("#loadInfo").html(loadtext); 
			            }, 
			            success : function(resp) {
			            	//删除缓冲图标
			            	$("#loadInfo").html("");
			    	        //alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData"); 
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	JqgridManage.updatePagerIcons();
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			 //height: "auto",//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           shrinkToFit:false, //不缩小去适应	        
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           rownumWidth:50,
	           //rownumbers:true,//是否显示序号
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	          //footerrow: true , // 分页上添加一行，用于显示统计信息
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           multiboxonly: true,
	           altRows:true,
	           jsonReader : { 
			    	root:function (obj){return obj.response.data;},
			    	total:function (obj){return obj.pages.totalpage;},
	     		    page:function (obj){return obj.pages.currentpagenum;},
	     		    records:function (obj){return obj.pages.countrows;}	   
				},
				loadComplete : function(data) {
					var table = this;				
					setTimeout(function(){
						//styleCheckbox(table);
						//enableTooltips(table);
						JqgridManage.updatePagerIcons(table);
					}, 0);
					if(json.loadComplete!=""&&json.loadComplete!=null){
						eval(json.loadComplete+"("+data+","+table+")");
					}
				},
				gridComplete : function(){
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
					for ( var i in json.rowNameModel) {
						Merger(this.id,json.rowNameModel[i]);
					}
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}	
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				}
				
	           });

		});
		
		//公共调用方法
        function Merger(gridName, CellName) {
            //得到显示到界面的id集合
            var mya = $("#" + gridName + "").getDataIDs();
            //当前显示多少条
            var length = mya.length;
            for (var i = 0; i < length; i++) {
                //从上到下获取一条信息
                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
                //定义合并行数
                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {
                    //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', { display: 'none' });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }
	
};

/**
 * tableid： jqgrid _tree
 * */
JqgridManage.initJqgridTree1=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }
		$(jqgridtableid).each(function(){
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);	
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            async:false,
			            success : function(resp) {
			    	//   alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			    	   		console.info(b);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData");
			           			
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	updatePagerIcons(null);
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			    rownumbers : false,
			    rownumWidth : 50,
			    tree_root_level : 1,
				treeGrid : true,
				treeGridModel : "adjacency",
				ExpandColumn : json.ExpandColumn,
				treeIcons : {
				 	plus : '#ace-icon fa fa-chevron-circle-down',
					minus : '#ace-icon fa fa-chevron-circle-up',
					leaf : 'glyphicon glyphicon-list'
				},
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			   height: "false",//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           multiselect : false,
			   multiboxonly : false,
	           //shrinkToFit:false, //不缩小去适应
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           altRows:true,
	           jsonReader : { 	 
							    root:function (obj){return obj.response.data;},
								      total:function (obj){return obj.pages.totalpage;},
								      page:function (obj){return obj.pages.currentpagenum;},
								      records:function (obj){return obj.pages.countrows;} 
								},
				loadComplete : function() {
									var table = this;
									setTimeout(function() {
										updatePagerIcons(table);
									}, 0);
								},
				gridComplete : function(){
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
					for ( var i in json.rowNameModel) {
						Merger(this.id,json.rowNameModel[i]);
					}
			        
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}	
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				}
				
	           });

		});
		
		//公共调用方法
        function Merger(gridName, CellName) {
            //得到显示到界面的id集合
            var mya = $("#" + gridName + "").getDataIDs();
            //当前显示多少条
            var length = mya.length;
            for (var i = 0; i < length; i++) {
                //从上到下获取一条信息
                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
                //定义合并行数
                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {
                    //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', { display: 'none' });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }
	
};

/**
 * 带双击事件的表格
 * @param {} tableid
 * @param {} queryformid
 * @param {} gridwidth
 */
JqgridManage.initHaveDblClickJqgrid=function(tableid,queryformid,gridwidth){
//alert("tableid==="+tableid+"======queryformid==="+queryformid);
	var jqgridtableid;
	if(tableid && typeof(tableid) == "object"){   
		jqgridtableid = tableid;
    }else if(tableid){
        jqgridtableid = $("#"+tableid);
    }

		$(jqgridtableid).each(function(){	
			var grid_id_selector="#"+this.id;
			var json=JqgridManage.jqgridconfig(this.id);		
			
			$(grid_id_selector).jqGrid({ 
			/**   url:json.url, 
			   datatype: "json",
			   mtype:'POST',//请求方式
			**/   
			   datatype : function(postdata) {
			 		
			 		var formatjson = combineQuery.getQueryCombineData(queryformid, null, this.id);
			   		var datajson = {
			   			msg : formatjson
			   		//	columnNames:json.columnNames,
			   		//	columnComments:json.columnComments
			   		};
			       jQuery.ajax({   
			            type : 'POST',   
			            url : json.url,   
			            data: datajson,
			            dataType:'json',
			            cache:false,
			            success : function(resp) {
			    	//   alert(resp.msg);
			    	   		var b = convertJson.string2json1(resp.msg);
			           		if(resp.msg==""||resp.msg=="0"){
			            		// jQuery("#"+json.pageid).jqGrid("clearGridData");
			           			
			            		 jQuery(grid_id_selector).clearGridData();
			            		 return; 
			            	}
			            	var thegrid = jQuery(grid_id_selector)[0];   
			            		thegrid.addJSONData(b);
			            	JqgridManage.updatePagerIcons(null);
			            }
			        }); 
			        //jqgrid宽度自适应
			        //$(grid_id_selector).jqGrid( 'setGridWidth', gridwidth);
			    },	   
			   colNames:json.colNames,
			   colModel:json.colModel, 
			   height: json.jqgridheight,//高度
			 //height: "auto",//不出现滚动条
	           rowNum:json.rownum,//初始请求行数      
	           rowList:json.rowList,//分页行数
	           
	           pager:'#'+json.pageid,//分页的地址
	           viewrecords: true,//是否要显示总记录数
	           sortname:json.sortname,//默认排序id    
	           sortorder:json.sortorder,//排序标准
	           caption:json.caption,//表格标题
	           postData:json.postData,//附加参数
	           rownumWidth:50,
	           rownumbers:true,//是否显示序号
	           //autowidth:true,//如果为ture时，则当表格在首次被创建时会根据父元素比例重新调整表格宽度
	           multiselect: json.multiselect,
			 //multiselectWidth:20,
			 //multikey: "ctrlKey",
	           multiboxonly: true,
	           altRows:true,
	           jsonReader : { 
			    	root:function (obj){return obj.response.data;},
			    	total:function (obj){return obj.pages.totalpage;},
	     		    page:function (obj){return obj.pages.currentpagenum;},
	     		    records:function (obj){return obj.pages.countrows;}	   
				},
				loadComplete : function(data) {
					var table = this;				
					setTimeout(function(){
						//styleCheckbox(table);
						//enableTooltips(table);
						JqgridManage.updatePagerIcons(table);
					}, 0);
					if(json.loadComplete!=""&&json.loadComplete!=null){
						eval(json.loadComplete+"("+data+","+table+")");
					}
				},
				gridComplete : function(){
					if(json.gridComplete!=""&&json.gridComplete!=null){
						eval(json.gridComplete+"()");
					}
				},
				onSelectRow : function(row_id,status){ 
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectRow+"("+row_id+","+status+")");
					}
					
				},
				onSelectAll : function(row_ids,status){
					if(json.onSelectRow!=""&&json.onSelectRow!=null){
						eval(json.onSelectAll+"("+row_id+","+status+")");
					}
				},
				ondblClickRow:function(){
					$("#confirm").click();
				}
				
	           });

		});
	
};

JqgridManage.updateTreePage =  function(json,obj){
	alert(json.pageid);
	console.info(obj);  
	var   total =  obj.pages.totalpage; 
	var   page = obj.pages.currentpagenum; 	 
	var html = '<tr>'
	+'<td class="ui-pg-button ui-corner-all ui-state-disabled" id="first_grid_table_page63208"><span class="ui-icon ace-icon fa fa-angle-double-left bigger-140"></span></td><td class="ui-pg-button ui-corner-all ui-state-disabled" id="prev_grid_table_page63208"><span class="ui-icon ace-icon fa fa-angle-left bigger-140"></span></td>'
	+'<td style="width:4px;" class="ui-pg-button ui-state-disabled"><span class="ui-separator"></span></td>'
	+'<td dir="ltr"><input type="text" role="textbox" value="'+page+'" maxlength="7" size="2" class="ui-pg-input"> 共 <span id="sp_1_grid_table_page63208">'+total+'</span> 页</td>'
	+'<td style="width:4px;" class="ui-pg-button ui-state-disabled"><span class="ui-separator"></span></td>'
	+'<td class="ui-pg-button ui-corner-all" id="next_grid_table_page63208"><span class="ui-icon ace-icon fa fa-angle-right bigger-140"></span></td>'
	+'<td class="ui-pg-button ui-corner-all" id="last_grid_table_page63208"><span class="ui-icon ace-icon fa fa-angle-double-right bigger-140"></span></td>'
	+'<td dir="ltr">'
	+'<select role="listbox" class="ui-pg-selbox">'
	+'<option value="10" role="option">10</option>'
	+'<option value="50" role="option">50</option>'
	+'<option value="100" role="option">100</option>'
	+'</select></td>'
	+'</tr>';
	var $tr = $(html);
	$("#"+json.pageid+"_center .ui-pg-table").append($tr);
};
//replace icons with FontAwesome icons like above  翻页图标
JqgridManage.updatePagerIcons=function(table) {
		  
	var replacement = {
		'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
		'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
		'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
		'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
	};
	$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
		var icon = $(this);
		var $class = $.trim(icon.attr('class').replace('ui-icon', ''));	
		if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
	})

};

		
JqgridManage.jqgridconfig=function(id){
	if($("#"+id).length==1){
		
		var pagems=$("#"+id).attr("page");//排序字段
		if(pagems==undefined){
			var pageid=id+"_page"+Math.floor(Math.random()*(123456+1));
			$('#'+id).after('<div id="'+pageid+'"></div>');	
		}

		var json={url:$("#"+id).attr("action"), 
				  pageid:pageid,
				  caption:$("#"+id).attr("caption")};
		
		var sortname=$("#"+id).attr("sortname");//排序字段
		if(!(sortname!=null && sortname!="")){
			sortname="id";
			}
		json.sortname=sortname;
		
		var sortorder=$("#"+id).attr("sortorder");
		if(!(sortorder=="asc" || sortorder=="desc")){
			sortorder="asc";
			}
		json.sortorder=sortorder;//排序方式
		
		var multiselect=$("#"+id).attr("multiselect");	//多选
		if(multiselect=='true'){			
			json.multiselect=true;
		}else{
			json.multiselect=false;
		}
		
		var jqgridheight=$("#"+id).attr("jqgridheight");//高度
		if(!(jqgridheight!=null && jqgridheight!="")){
			jqgridheight=g_tableHeight;		
		}
		json.jqgridheight=jqgridheight;

		var rownum=$("#"+id).attr("rownum");//高度
		if(!(rownum!=null && rownum!="")){
			rownum=10;		
		}
		json.rownum=rownum;
		json.rowList = [rownum,50,100];
	
		var loadComplete=$("#"+id).attr("loadComplete");
		if(typeof(loadComplete)=='undefined'||loadComplete==null){
			loadComplete="";
		}
		json.loadComplete=loadComplete;
		
		var gridComplete=$("#"+id).attr("gridComplete");
		if(typeof(gridComplete)=='undefined'||gridComplete==null){
			gridComplete="";
		}
		json.gridComplete=gridComplete;

		var onSelectRow=$("#"+id).attr("onSelectRow");
		if(typeof(onSelectRow)==undefined||onSelectRow==null){
			onSelectRow="";
		}
		json.onSelectRow=onSelectRow;	
			
		var onSelectAll=$("#"+id).attr("onSelectAll");
		if(typeof(onSelectAll)==undefined||onSelectAll==null){
			onSelectAll="";
		}
		json.onSelectAll=onSelectAll;	
		
		var ExpandColumn=$("#"+id).attr("ExpandColumn");
		if( ExpandColumn != ""){
		json.ExpandColumn=ExpandColumn;//tree 显示的列名称
		}
		
		json.colNames=[];
		json.colModel=[];
		json.rowNameModel=[];
		var columnNames="";
		var columnComments="";
		$("#"+id+" th").each(function(i){
			json.colNames[i]=$.trim($(this).text());
			var name=$(this).attr("name");
			var index=$(this).attr("index");
			
			if(typeof(index)=='undefined'){
				index=name;
			}
			
			var col={};
            if($(this).attr("rowspan")=="true"){
            	json.rowNameModel[i]=name;
            	 col={classes:$(this).attr("css"),name:name,index:index,width:$(this).attr("width"),align:($(this).attr("align")!=null?$(this).attr("align"):'left'),
            	 //sortable:($(this).attr("sortable")!=null?$(this).attr("sortable"):true),
            	 sortable:false,
            			 cellattr:function(rowId,tv,rawObject,cm,rdata){
            				 return "id=\""+name+rowId+"\"";
            				 }};
			}else{
				 col={classes:$(this).attr("css"),name:name,index:index,width:$(this).attr("width"),align:($(this).attr("align")!=null?$(this).attr("align"):'left'),
				 //sortable:($(this).attr("sortable")!=null?$(this).attr("sortable"):true)
				 sortable:false
				 };	
			}
			
				
			var formatter=$(this).attr("formatter");
			
			if(formatter!=null && formatter!=""){
				try{
				//	col.formatter=$.parseObj(formatter));
					col.formatter=eval(formatter);
				}catch(e){
					//alert(name+"行回调失败"+e);
				}
			}
			var key=$(this).attr("key");
			if(key!=null && key!=''){
				col.key=true;
			}
			
			var hidden=$(this).attr("hidden");
	//alert(hidden);
			if(hidden!=null&&hidden!=''){
				col.hidden=true;
			}
			
			//fixed:true;
			var fixed=$(this).attr('fixed'); 
			if(fixed!=null&&fixed!=''){
				col.fixed=true;
			}
				
			json.colModel[i]=col;
			
			if(typeof(name)!='undefined'){
				columnNames+=name+",";	
				columnComments+=$.trim($(this).text())+",";
			}	
			
		});

		json.columnNames=columnNames.substring(0,columnNames.length-1);
		json.columnComments=columnComments.substring(0,columnComments.length-1);
//alert(columnNames+"-----------"+columnComments);
		$("#"+id).html("").show(0);
		
		return json;
	}
};

//影藏列
JqgridManage.hideRow = function (tableId){
	var ths = $(".ui-jqgrid-htable").find('th');
	var msg = "<div class=\"row\">  " +
    		  "<div class=\"col-md-12\" style=\"height: 400px; overflow-y: scroll ;\"> " +
       		  "<form class=\"form-horizontal\"> " +
    		  "<div class=\"form-group\"> " +
    		  "<div class=\"col-md-12\"> " ;
    $.each(ths, function() {
    	var id = $(this).attr('id'); 
		id = id.substring(11,id.length); 
	    var txt = $(this).text(); 
	    if(id!='rn'){
	    	msg += "<div class=\"checkbox\"> <label > <input type=\"checkbox\" checked=\"checked\"  name=\"selectRow\"  value=\""+id+"\"> "+txt+"</label> </div> ";
		}		
     });
      msg += "</div> </div>" +
      "</form> </div>  </div>";
	  bootbox.dialog({
			title: "请选择显示列",
			message: msg,
			buttons: {
			     success: {
			     label: "确定",
			     className: "btn-success",
			     callback: function () {
		            //获取未选中的列并隐藏
			         $("input[name='selectRow']").not("input:checked").each(function() {
			          	jQuery('#'+tableId).hideCol($(this).val()).trigger('reloadGrid'); 
			         });
			 
			       }
			     },
			     close:{
			        label: "关闭",
			        className: "btn-close"
				     }
			     }
			  }
		);

}

//影藏行
JqgridManage.hiddenLine = function(Col,storeId,slected){
	//var storeId = document.getElementById("\""+tableId+"\"");//获取table的id标识
	var rowsLength = storeId.rows.length;//表格总共有多少行

	var searchCol = Col;//要搜索的哪一列，这里是第一列，从0开始数起
		
	var str = $('#'+slected).val();
	var arr = str.split(",");
	
	var msg = "<div class=\"row\">  " +
		  "<div class=\"col-md-12\" style=\"height: 400px; overflow-y: scroll ;\"> " +
			  "<form class=\"form-horizontal\"> " +
		  "<div class=\"form-group\"> " +
		  "<div class=\"col-md-12\"> " ;
	for(var i=1;i<rowsLength;i++){//按表的行数进行循环，本例第一行是标题，所以i=1，从第二行开始筛选（从0数起）
		var searchText = storeId.rows[i].cells[searchCol].innerHTML;//取得table行，列的值
		if(JqgridManage.contains(arr,i)){
			msg += "<div class=\"checkbox\"> <label > <input type=\"checkbox\"    name=\"selectLine\"  value=\""+i+"\"> "+searchText+"</label> </div> ";
		}else{
			msg += "<div class=\"checkbox\"> <label > <input type=\"checkbox\" checked=\"checked\"  name=\"selectLine\"  value=\""+i+"\"> "+searchText+"</label> </div> ";
		}
				 
	}
			
	msg += "</div> </div>" +
	"</form> </div>  </div>";
	bootbox.dialog({
		title: "请选择显示列",
		message: msg,
		buttons: {
				success: {
					label: "确定",
					className: "btn-success",
					callback: function () {
				 		  var v = "";
						  $("input[name='selectLine']").not("input:checked").each(function() {
						      storeId.rows[$(this).val()].style.display='none';//隐藏行操作
						      v += $(this).val()+",";
						  });
						  $("#"+slected).val(v);	
			  		}
				},
				close:{
			   		label: "关闭",
			   		className: "btn-close"
				}
			}
		}
			  
	);
	
}
//判断某个元素是否在指定的数组中存在
JqgridManage.contains = function (array ,element){
	for (var i = 0; i < array.length; i++) { 
    	if (array[i] == element) { 
    		return true; 
    	} 
    } 
}
		

//去重
JqgridManage.sortUnique =  function(arr) {
	arr.sort(function(a, b){
		a = JqgridManage.adjustCase(a);
		b = JqgridManage.adjustCase(b);	
		if (a == b) return 0;
		return a > b ? 1 : -1;
	});
			
	var ret = [arr[0]];
	for (var i = 1; i < arr.length; i++) { // start loop at 1 as element 0 can never be a duplicate
		if (JqgridManage.adjustCase(arr[i-1]) !== JqgridManage.adjustCase(arr[i])) {
			ret.push(arr[i]);
		}
	}
	return ret;
}


JqgridManage.adjustCase = function(val) {
	return  val.toLowerCase();
}

/**
 * 自动补全
 * @param {} inputId 需要自动补全的文本框id
 * @param {} Url 查询url
 */
JqgridManage.Autocomplete = function(inputId, Url) {
	$('#' + inputId).typeahead({
		source: function(query, process) {
			var parameter = {
				keyWord: query
			};
			$.post(Url, parameter, function(data) {
				var json = jQuery.parseJSON(data);
				var array = new Array();
				for (var i = 0; i < json.obj.length; i++) {
					array.push(json.obj[i].VO);
				}
				process(array);
			});
		}
	});
}
/***
 * 页面添加
		<table  id="grid_table" 
		 		action="${base}/manage/ajaxController/100000/query"
		 		sortname="ID" sortorder="asc" multiselect=true 
				 >
			<tr>
				<th name="ID" key=true width="25">ID</th>
				<th name="ACCOUNT" width="90" >帐号</th>
				<th name="NICKNAME" width="100" >Name</th>
				<th name="EMAIL" hidden width="50">EMAIL</th>	
				<th formatter="jqgridactions" width="30">操作</th>	
			</tr>
		</table> 

类型	          属性名	          备注
table   id          id 唯一识别号
table	sortname	排序字段名称
table   sortorder	排序类型,如 desc or asc
table	action	          请求数据地址
table	multiselect	是否可以多选
table	loadComplete   回调函数
table	gridComplete   回调函数
table	onSelectRow   回调函数
table	onSelectAll   回调函数
ExpandColumn="BZJC_NAME"     initJqgridTree初始。ExpandColumn tree展开操作出现的列名称


th	name	          列名
th	width	          表格列宽度
th	formatter	行回调.二个参数.1 当前列值  2 当前行json  需要返回值.主要用作格式化使用.
th	hidden	           如果有值是则该列隐藏
th  key=true    是否主键
th  align       对齐方式 left, center, right

**/