var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var contextPath = pathName.substr(0,index+1);
	
	var g_sAppName 		=	contextPath; //工程路径
	var g_sImgPath      =   g_sAppName+"/images/default/";        // 图片文件的路径
	var g_sDicPath      =   contextPath+"/dic/"; 
	
	var g_winHeight     =   jQuery(window).height();
	var g_winWidth      =   jQuery(window).width();
	var g_tableHeight   =   (g_winHeight-365)>0?g_winHeight-365:100;
	var g_tableWidth    =   g_winWidth-200;

	/**
	 * 替换jqgrid的分页样式
	 * @author Leo.liu
	 */
	function updatePagerIcons(table) {
		var replacement = {
				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
		};
		$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

			if ($class in replacement)
				icon.attr('class', 'ui-icon ' + replacement[$class]);
		})
	}

	/**
	 * 替换JQGRID的图标样式
	 * @author Leo.liu
	 */
	function aceSwitch( cellvalue, options, cell ) {
		setTimeout(function(){
			$(cell) .find('input[type=checkbox]')
					.wrap('<label class="inline" />')
				.addClass('ace ace-switch ace-switch-5')
				.after('<span class="lbl"></span>');
		}, 0);
	}
	
	Date.prototype.format =function(format){
		var o = {
		"M+" : this.getMonth()+1, //month
		"d+" : this.getDate(), //day
		"h+" : this.getHours(), //hour
		"m+" : this.getMinutes(), //minute
		"s+" : this.getSeconds(), //second
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter
		"S" : this.getMilliseconds() //millisecond
		}
		if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
		(this.getFullYear()+"").substr(4- RegExp.$1.length));
		for(var k in o)if(new RegExp("("+ k +")").test(format))
		format = format.replace(RegExp.$1,
		RegExp.$1.length==1? o[k] :
		("00"+ o[k]).substr((""+ o[k]).length));
		return format;
	}
	
	function dateFormatter(cellvalue, options, rowObject) {
		var returnValue = "";
		if (cellvalue){
			var cellvalue1=cellvalue ;
			cellvalue1 = cellvalue1.toString().replace(new RegExp("\b","g")," ");
			//var dateValue = new Date(cellvalue1);
			//returnValue = dateValue.format("yyyy-MM-dd hh:mm:ss");
			return cellvalue1;
		}
		return returnValue;
	}
	
	function dateFormatter2(cellvalue, options, rowObject) {
		var returnValue = "";
		var dateValue="";
		var wz="";
		if (cellvalue){
			if(cellvalue.indexOf("为") < 0){
				//dateValue = new Date(cellvalue);
				//returnValue = dateValue.format("yyyy-MM-dd hh:mm:ss");
				returnValue = cellvalue.toString().replace(new RegExp("\b","g")," ");
			}else{
				
				var sj= cellvalue.split(".")[1];
				if(sj!=""){
					//dateValue = new Date(sj);
					//returnValue = dateValue.format("yyyy-MM-dd hh:mm:ss");
					returnValue = sj.toString().replace(new RegExp("\b","g")," ");
					}
				wz= cellvalue.split(".")[0];
			}
		}
		if(wz!=""){
			returnValue=wz+returnValue;
		}
		return returnValue;
	}
	function statusChange(cellvalue, options, rowObject) {
		var statusCn = '';
		if ($.trim(cellvalue).length > 0) { // 判断元素是否为空
			if (cellvalue == 1) {
				statusCn = '有效';
			} else {
				statusCn = '无效';
			}
		} else {
			statusCn = '无效';
		}
		return statusCn;
	}
	
	function xingzhiChange(cellvalue, options, rowObject) {
		var statusCn = '';
		if ($.trim(cellvalue).length > 0) { // 判断元素是否为空
			if (cellvalue == 'ZB') {
				statusCn = '总承包';
			} else if(cellvalue == 'CB'){
				statusCn = '专业承包';
			}
		} 
		return statusCn;
	}
	
	function fbfsChange(cellvalue, options, rowObject) {
		var statusCn = '';
		if ($.trim(cellvalue).length > 0) { // 判断元素是否为空
			if (cellvalue == 1) {
				statusCn = '公开招标';
			} else if (cellvalue == 2) {
				statusCn = '邀请招标';
			}else if (cellvalue == 3) {
				statusCn = '直接发包';
			}
		}
		return statusCn;
	}
	
	String.prototype.endWith=function(str){
		if(str==null||str==""||this.length==0||str.length>this.length)
		  return false;
		if(this.substring(this.length-str.length)==str)
		  return true;
		else
		  return false;
		return true;
	};
	
	//获取数字格式
	function getNumber(obj){
	   if (obj==null) return 0;
	   if (!checkFloat(obj)||obj+""==""){
	    return 0;
	   }else{
	        return parseFloat(""+obj);
	   }
	}
	//检查输入参数是否为浮点数
	function checkFloat(str){
	    var rc=true;
	    oneDecimal=false;
	    if (str+"" == "undefined" || str == null || str==''){
	    	rc=false;
		} else{
		    for(i=0;i<str.length;i++){
		        ch=str.charAt(i);
		        if(i==0 && ch=='-'){
		            continue;
		        }
		        if(ch=="." && !oneDecimal){
		        oneDecimal=true;
		            continue;
		        }
		        if(ch==","){
		            continue;
		        }
		        if ((ch< "0") || (ch >'9')){
	                rc=false;
	                break;
	            }
	        }
	    }
	    return rc;
	}

	var CommUtils = {
		//取Jqgrid的checkbox中的值 
		getJqgridSelected : function(elementId){
			var ids = [];
			var checkboxs = $(document.getElementById(elementId)).find("input[type=checkbox].ace:checked");
			$.each(checkboxs, function (index, element) {
				ids.push($(element).val());
			});
			return ids;
		},
		
		commAlert : function(modalId,msg){
//			bootbox.dialog({
//				title: "提示信息",
//				message: "<span class='bigger-110'>"+msg+"</span>",
//				buttons: 			
//				{"button" :
//					{
//					"label" : "关闭",
//					"className" : "btn-sm"
//					}
//				}
//			});
			
//			$.get(contextPath + "/jsp/framework/common/alert.jsp", {msg:msg,seconds:'3000',tips:''}, function(data){
//			  $(document.getElementById(modalId)).append(data);
//			});
			
			var alDia = $(document.getElementById(modalId));
			var diaString ="";
			diaString+="<div class=\"modal-dialog\">";
			diaString+="	<div class=\"modal-content\">";
			diaString+="		<div class=\"ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix\">";
			diaString+="			<span id=\"ui-id-26\" class=\"ui-dialog-title\">";
			diaString+="				<div class=\"widget-header widget-header-small\">";
			diaString+="					<h4 class=\"smaller\">";
			diaString+="						<i class=\"icon-ok\">提示</i>";
			diaString+="					</h4>";
			diaString+="				</div>";
			diaString+="			</span>";
			diaString+="		</div>";
			diaString+="		<div class=\"modal-body\">";
			diaString+=msg+"			<br/>";
			diaString+="		</div>";
			diaString+="		<div class=\"modal-footer\">";
			diaString+="			<button class=\"btn btn-danger btn-sm pull-right\" data-dismiss=\"modal\">关闭</button>";
			diaString+="		</div>";
			diaString+="	</div>";
			diaString+="</div>";
			
			alDia.append(diaString);
			
//			$(document.getElementById(modalId)).load(contextPath + "/jsp/framework/common/alert.jsp",{msg:msg,seconds:'3000',tips:''},
//			function(rep){alert(rep)
//				$(document.getElementById(modalId)).append(rep);
//			});
		},
		
		commModalIframe : function(modalId,conte){
			$.get(contextPath + "/jsp/framework/common/iframe.jsp", conte, function(data){
			  $(document.getElementById(modalId)).append(data);
			});
		},
		
		commDelete : function (modalId,msg,delIds,treeId){
			delIds = delIds.join(",");     
			$(document.getElementById(modalId)).load(contextPath + "/common/deleteRequest.jsp",
					{msg:msg,
					 delIds:delIds,
					 modalId:modalId,
					 treeId:treeId,
					 gridTableId:"grid-table",
					 deleteUrl:"delete",
					 seconds:'3000',
					 tips:''}
					,''
			);
		},
		
		commRefreshTree : function (elementId){
			$(document.getElementById(elementId)).jstree("refresh");
		}
		
	}
	
	//设置每页行记录数
	function getPageRowNum(){
		var num =Math.round((g_tableHeight-60)/34);
		if(num<0)
			num = 1;
		//alert(g_tableHeight+"   "+num);
		return num;
	}
	
	
//表单验证初始化 	FormValid.validbyformid(fromid);
var FormValid = new Object();	
	
	FormValid.validbyformid = function(formid){
		var v = $(formid).Validform({
					//btnSubmit:"#save_btn",
					tiptype:function(msg,o,cssctl){ 
						if(!o.obj.is("form")){
							var objt=o.obj.siblings(".info");
							if(!objt.is("div")){
								var html='<div class="info"><span class="Validform_checktip"></span><span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>';
								o.obj.after(html);//在该节点后面添加div节点
							}	
							var objtip=o.obj.siblings(".info").find(".Validform_checktip");
							cssctl(objtip,o.type);
							objtip.text(msg);
							
							var infoObj=o.obj.siblings(".info"); 
							if(o.type==2){
								infoObj.fadeOut(200);
							}else{  
								//if(infoObj.is(":visible")){return;}    
								var left0=o.obj.position().left;  
								infoObj.css({
									left:left0+"px" 
									// top:-32
								}).show().fadeOut(5000);
							}
						}
					},datatype:{
						//参数gets是获取到的表单元素值，obj为当前表单元素，curform为当前验证的表单，regxp为内置的一些正则表达式的引用;
						//注意return可以返回true 或 false 或 字符串文字，true表示验证通过，返回字符串表示验证失败，字符串作为错误提示显示，返回false则用errmsg或默认的错误提示;
						"f8-2":function(gets,obj,curform,regxp){			
							var reg1=/^[\d]{1,8}(\.[\d]{1,2})?$/;
							if(reg1.test(gets)){return true;}
							return "可以填最多8位整数加最多2位小数";
						},"f18-2":function(gets,obj,curform,regxp){
							var reg1=/^[\d]{1,18}(\.[\d]{1,2})?$/;
							if(reg1.test(gets)){return true;}
							return "可以填最多18位整数加最多2位小数";
						},"skh":function(gets,obj,curform,regxp){
							var reg1=/^[a-z0-9\u4E00-\u9FFF\(\)]+?$/;
							if(reg1.test(gets)){return true;}
							return "不能输入特殊字符";
						},"cz":function(gets,obj,curform,regxp){
							var reg1=/^([0-9\-]+)$/;
							if(reg1.test(gets)){return true;}
							return "不能输入特殊字符";
						},"dh":function(gets,obj,curform,regxp){
							var reg1=/^[\d]{3,4}(\-[\d]{8,8})?$/;
							if(reg1.test(gets)){return true;}
							return "输入的格式如:(0101)010-86551122";
						},"f16-4":function(gets,obj,curform,regxp){
							var reg1=/^[\d]{1,16}(\.[\d]{1,4})?$/;
							if(reg1.test(gets)){return true;}
							return "可以填最多16位整数加最多4位小数";
						},"idcard":function(gets,obj,curform,datatype){
							var idCard = trim(gets.replace(/ /g, ""));               //去掉字符串头尾空格                     
						    if (idCard.length == 15) {   
						        return isValidityBrithBy15IdCard(idCard);       //进行15位身份证的验证    
						    } else if (idCard.length == 18) {   
						        var a_idCard = idCard.split("");                // 得到身份证数组   
						        if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   //进行18位身份证的基本验证和第18位的验证
						            return true;   
						        }else {   
						            return false;   
						        }   
						    } else {   
						        return false;   
						    } 
						    return false;  
                     }

					}
				});
		return v;
	}
/****身份证验证辅助函数begin http://www.cnblogs.com/shenliang123/archive/2012/04/05/2432880.html****/
	var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];    // 加权因子   
	var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];            // 身份证验证位值.10代表X 
	
	/**  
	 * 判断身份证号码为18位时最后的验证位是否正确  
	 * @param a_idCard 身份证号码数组  
	 * @return  
	 */  
	function isTrueValidateCodeBy18IdCard(a_idCard) {   
	    var sum = 0;                             // 声明加权求和变量   
	    if (a_idCard[17].toLowerCase() == 'x') {   
	        a_idCard[17] = 10;                    // 将最后位为x的验证码替换为10方便后续操作   
	    }   
	    for ( var i = 0; i < 17; i++) {   
	        sum += Wi[i] * a_idCard[i];            // 加权求和   
	    }   
	    valCodePosition = sum % 11;                // 得到验证码所位置   
	    if (a_idCard[17] == ValideCode[valCodePosition]) {   
	        return true;   
	    } else {   
	        return false;   
	    }   
	}   
	/**  
	  * 验证18位数身份证号码中的生日是否是有效生日  
	  * @param idCard 18位书身份证字符串  
	  * @return  
	  */  
	function isValidityBrithBy18IdCard(idCard18){   
	    var year =  idCard18.substring(6,10);   
	    var month = idCard18.substring(10,12);   
	    var day = idCard18.substring(12,14);   
	    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	    // 这里用getFullYear()获取年份，避免千年虫问题   
	    if(temp_date.getFullYear()!=parseFloat(year)   
	          ||temp_date.getMonth()!=parseFloat(month)-1   
	          ||temp_date.getDate()!=parseFloat(day)){   
	            return false;   
	    }else{   
	        return true;   
	    }   
	}   
	  /**  
	   * 验证15位数身份证号码中的生日是否是有效生日  
	   * @param idCard15 15位书身份证字符串  
	   * @return  
	   */  
	  function isValidityBrithBy15IdCard(idCard15){   
	      var year =  idCard15.substring(6,8);   
	      var month = idCard15.substring(8,10);   
	      var day = idCard15.substring(10,12);   
	      var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	      // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
	      if(temp_date.getYear()!=parseFloat(year)   
	              ||temp_date.getMonth()!=parseFloat(month)-1   
	              ||temp_date.getDate()!=parseFloat(day)){   
	                return false;   
	        }else{   
	            return true;   
	        }   
	  }   
	//去掉字符串头尾空格   
	function trim(str) {   
	    return str.replace(/(^\s*)|(\s*$)/g, "");   
	}  
/****身份证验证辅助函数end****/	
	
	 parseObj=function(strData){//转换对象
		 if(strData!=undefined)
			 return (new Function( "return " + strData ))();
     };
		     
	function jqgridconfig(id){
		if($("#"+id).length==1){
			var pageid=id+"_page"+Math.floor(Math.random()*(123456+1));
			$('#'+id).after('<div id="'+pageid+'"></div>');

			
			var json={url:$("#"+id).attr("action"),
					caption:$("#"+id).attr("caption"),
					multiselect:$("#"+id).attr("multiselect"),
					pageid:pageid
					};
			
			var sortname=$("#"+id).attr("sortname");//排序
			if(!(sortname!=null && sortname!=""))
				sortname="id";
			json.sortname=sortname;
			
			var sortorder=$("#"+id).attr("sortorder");
			if(!(sortorder=="asc" || sortorder=="desc"))
				sortorder="asc";
			json.sortorder=sortorder;
			
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
			
			json.colNames=[];
			json.colModel=[];
			var columnNames="";
			var columnComments="";
			$("#"+id+" th").each(function(i){
				json.colNames[i]=$.trim($(this).text());
				var name=$(this).attr("name");
				var col={name:name,index:name,width:$(this).attr("width"),search:true,hidden:($(this).attr("hidden")!=null?true:false)};
				var formatter=$(this).attr("formatter");
				if(formatter!=null && formatter!=""){
					try{
						col.formatter=parseObj(formatter);
					}catch(e){
						alert(name+"行回调失败"+e);
					}
				}
				var key=$(this).attr("key");
				if(key!=null && key!=""){
					col.key=true;
				}
				json.colModel[i]=col;
				if(typeof(name)!='undefined'){
					columnNames+=name+",";	
					columnComments+=$.trim($(this).text())+",";
				}	
			});
			json.columnNames=columnNames.substring(0,columnNames.length-1);
			json.columnComments=columnComments.substring(0,columnComments.length-1);
			
		/**	if($("#"+id+" th").length>0){
				var fixedwhere=$("#"+id).attr("fixedwhere");//固定条件
				if(!(fixedwhere!=null && $.trim(fixedwhere)!=""))
					fixedwhere="1=1";
				json.postData={"filename":names.substring(0,names.length-1),fixedwhere:fixedwhere};
				
			}**/
			$("#"+id).html("").show(0);
			return json;
		}
	}

function rendJqGrid(){
    
	$(".auto_startgrid[id]").each(function(){
    		var tid = this.id
            var json=jqgridconfig(this.id);
            $("#"+this.id).jqGrid({
                datatype : function(postdata) {
 			       var data1 = combineQuery.getQueryCombineData(queryForm, null, this.id);
 			       var data = {
 			   			msg : data1,
 			   			columnNames:json.columnNames,
 			   			columnComments:json.columnComments
 			   		};
 			       jQuery.ajax({
 			           type : 'POST',   
 			           url : json.url,   
 			           data : data,
 			            dataType : 'json',
 			            cache:false,
 			            success : function(resp) {
 			            	var b = convertJson.string2json1(resp.msg);
 			            	if(resp.msg==""||resp.msg=="0"){
 			            		 
 			            		 jQuery("#"+json.pageid).jqGrid("clearGridData");
 			            		 //bootbox.alert("没有符合条件的记录！");  
 			            		 return;     		
 			            	}
 			            	var thegrid = jQuery("#"+tid)[0];
 			            	thegrid.addJSONData(b);
 			            	updatePagerIcons();
 			            }
 			            //,error : ajaxFailed   
 			        });   
 			    },
                colNames:json.colNames,
                //字段属性详解  hidden:true 是否隐藏 
                colModel:json.colModel, 
               rowNum:20,//初始请求行数
               height:"470px",//高度
               rowList:[20,50,100],//分页行数
               //mtype:"post",//请求方式
               pager: '#'+json.pageid,//分页的地址 
               //sortname:json.sortname,//默认排序id
               viewrecords: true,//是否要显示总记录数
               //sortorder:json.sortorder,//排序标准
               caption:json.caption,//表格标题
               hidegrid:false,
               //postData:json.postData,//附加参数
               rownumbers:false,//是否显示序号
               autowidth:true,
               rownumWidth:50,
               multiselect: json.multiselect,
   	           multiboxonly: true,
   	           altRows: true,
               jsonReader : {
     		      root:function (obj){return obj.response.data;},
     		      total:function (obj){return obj.pages.totalpage;},
     		      page:function (obj){return obj.pages.currentpagenum;},
     		      records:function (obj){return obj.pages.countrows;}
     			},
				loadComplete : function(data) {
					var table = this;
					setTimeout(function(){
						updatePagerIcons(table);
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
				}
     			
               });
            //.navGrid('#'+json.pageid,{edit:false,add:false,del:false,view:true});
       /**     
            if($("#"+this.id+"search").length==1){
                var tid=this.id;
                $("#"+this.id+"search").click(function(){
                    $("#"+tid).jqGrid('setGridParam',{postData:{"where":$.getseachwhere($("#"+tid+"search").parents("div[id]").attr("id"))}}).trigger("reloadGrid");
                });
            }**/
    });
	}

	
//	(function($){
//		    $.parseObj=function(strData){//转换对象
//		        return (new Function( "return " + strData ))();
//		    };
//	})(jQuery);


//日期初始化
var DatePicker = new Object();	
DatePicker.datepickerid = function(datepickerid){
	$(datepickerid).datepicker({
		autoclose: true,
		todayHighlight: true,
		language:'zh-CN'

		}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
	
}

//=======add by gongwx 时间区间使用
DatePicker.datepicker = function(datepickerid){
	$(datepickerid).datepicker({
		autoclose: true,
		todayHighlight: true,
		language:'zh-CN'

		})
	
}
/**
 * 获取选中的checkbox值
 * @param {Object} lname 
 *        checkbox name 属性值
 */
function getCheckboxV(lname) {
	var v = "";
	$("input:checkbox[name='" + lname + "']:checked").each(function() {
		v += $(this).val() + ",";
	});
	if (v.length != 0) {
		v = v.substring(0, v.length - 1);
	}
	return v;
}
    
/**
 * 获取单选按钮选中的值
 * @param {Object} lname
 * 		 radio name 属性值
 */
function getRadioV(lname){
	return  $("input:radio[name='"+lname+"']:checked").val();
}

/**
 * 月份的加减
 * @param {} date 相对日期 ""为当前日期	
 * @param {} months 添加几个月 正整数为加  负整数为减
 * @param {} pattern 返回日期格式 “/”,“CN”,“-”
 */
function addMonth(dateStr,months,pattern){
	var date = "";
	var retVal = "";
	if(dateStr==""){
		date = new Date();
	}else{
		date = new Date(dateStr);
	}
	date.setMonth(date.getMonth()+months);
	var month  = date.getMonth()+1;
	var day = date.getDate();
	if(month<10){
		month = "0"+month;
	}
	
	if(day<10){
		day  = "0"+day;
	}
	
	if(pattern=="/"){
		retVal = date.getFullYear()+"/"+month+"/"+day;
	}else if(pattern=="CN"){
		retVal = date.getFullYear()+"年"+month+"月"+day+"日";
	}else{
		retVal = date.getFullYear()+"-"+month+"-"+day;
	}
	
	return retVal;
	
}

/**
 * 日期的加减
 * @param {} date 相对日期 ""为当前日期	
 * @param {} days 添加几天 正整数为加  负整数为减
 * @param {} pattern 返回日期格式 “/”,“CN”,“-”
 */
function addDate(dateStr,days,pattern){
	var date = ""; 
	var retVal = "";
	if(dateStr==""){
		date = new Date();
	}else{
		date = new Date(dateStr);
	}
	date.setDate(date.getDate()+days);
	var month  = date.getMonth()+1;
	var day = date.getDate();
	if(month<10){
		month = "0"+month;
	}
	
	if(day<10){
		day  = "0"+day;
	}
	
	if(pattern=="/"){
		retVal = date.getFullYear()+"/"+month+"/"+day;
	}else if(pattern=="CN"){
		retVal = date.getFullYear()+"年"+month+"月"+day+"日";
	}else{
		retVal = date.getFullYear()+"-"+month+"-"+day;
	}
	
	return retVal;
}



/**
 * 操作权限检查
 * @param {} projectId       项目id
 * @param {} projectUserId   项目用户id
 * @param {} authorityCode   权限代码
 */
function checkAuthority(projectId,projectUserId,authorityCode){
	var flag = false; 
	$.ajax({
		url :"sys/sysUserController?queryAuthority",
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		data:{
			"projectId":projectId,
			"projectUserId":projectUserId,
			"authorityCode":authorityCode
		},
		success : function(response) {
			flag = response.success;
	    }
	});
	return flag;
}

/**
 * 文件夹权限
 * @param {} projectId
 * @param {} projectUserId
 * @param {} authorityCode
 * @param {} domID
 */
function checkDirAuthority(projectId,projectUserId,dirUid){
	var flag = false;
	$.ajax({
		url :"commons/SysUserController?checkDirAuthority",
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		data:{
			"projectId":projectId,
			"projectUserId":projectUserId,
			"dirUid":dirUid
		},
		success : function(response) {
			flag = response.success;
	    }
	});
	return flag;
}

/**
 * 查询文件夹权限
 * @param {} projectId
 * @param {} projectUserId
 * @param {} authStr
 * @return {}
 */
function queryDirAuthority(projectId,projectUserId,dirUid){
	var auth = 1;
	$.ajax({
		url :"sys/sysUserController?queryDirAuthority",
		cache : false,
		async :	false,
		dataType : "json",  
		type : 'post',
		data:{
			"projectId":projectId,
			"projectUserId":projectUserId,
			"dirUid":dirUid
		},
		success : function(response) {
			auth = response.obj;
	    }
	});
	return auth;
}

