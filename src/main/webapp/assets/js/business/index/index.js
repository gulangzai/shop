$(function() {
	 
	
	var now = getNowFormatDate();
	$("#dayOfWeek").text(getDayOfWeek());
	$("#today").text(now);
	
	$('.ajax-loading-overlay').remove();

   /* $('#Li_lpxx').hover(function(){
         $('#table_details').css('visibility','visible');
    },function(){
         $('#table_details').css('visibility','hidden');
    });*/
	   
	//获取工程资料前3项最新的 model
	initHomePageProjectDoc();
	
	//本周风险源多少个，存在应急预案多少个
	initFxyYjya();
	
	//风险源最新3个文件
	initFxyLaterThree();
	
	//考勤模块
	initKaoqing(); 
	
	//保险信息
	initbaoxian();
	//理赔的各种状态
	initlipei();
	//质量安全工况
	initgongk();
	
	//饼图
	initxcgongk();
	 
	//获取工程资料前3项最新的 
	function initHomePageProjectDoc() { 
		var data = {};  
		var elements = NetUtil.callJavaMethod(ctx+"/project/pmProjectDocsController/queryHomePageProjectDoc", data);
		console.info(elements);
		var eles = JsonUtil.objectFromString(elements); 
		$("#projectDoc").empty();
		eles.forEach(function( val, index ) {
			// console.log( val, index, this); 
			 var $tr = $("<tr class='col-xs-12'><td class='col-xs-6' title='"+val.fileName+"'>"+val.subFileName+"</td><td class='col-xs-6'>"+val.createdDate+"</td></tr>");
			 $("#projectDoc").append($tr);
		 });   
	}
	

	
	function initKaoqing() { 
		var data = {}; 
		//本周风险源多少个，存在应急预案多少个
		var elements = NetUtil.callJavaMethod(ctx+"/rygl/pmXcqdController/queryKaoqingMessage", data);
		//console.info(elements);
		var ele = JsonUtil.objectFromString(elements); 
		$("#operate_time").text(ele.operate_time);
		$("#person_number").text(ele.person_number);
		$("#kaoqing_number").text(ele.kaoqing_number);
	}
	
	function initFxyLaterThree() { 
		var data = {};
		
		//最近3天的风险源记录
		var elements = NetUtil.callJavaMethod(ctx+"/pmfxy/pmFxyController/queryLaterThree", data);
		//console.info(elements);
		var eles = JsonUtil.objectFromString(elements); 
		$("#fxy_list").empty();
		eles.forEach(function( val, index ) {
			// console.log( val, index, this);
			 var $tr = $("<tr class='col-xs-12'><td class='col-xs-6' title='"+val.wxys+"'>"+val.wxys_sub+"</td><td class='col-xs-6'>"+val.create_date+"</td></tr>");
			 $("#fxy_list").append($tr);
		 });   
	}
	
	function initFxyYjya() { 
		var data = {}; 
		//本周风险源多少个，存在应急预案多少个
		var elements = NetUtil.callJavaMethod(ctx+"/pmfxy/pmFxyController/queryFxyYjya", data);
		//console.info(elements);
		var ele = JsonUtil.objectFromString(elements); 
		$("#fxy_count").text(ele.fxy_count);
		$("#fxy_have_yjya").text(ele.fxy_have_yjya);
		
		var myChart = echarts.init(document.getElementById('fxy_yjya_bar'));   
		var option = {
			grid: { // 控制图的大小，调整下面这些值就可以，
			      x:20,
			      y:20,
			      x2:20,
			      y2:20// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
	        },
		    tooltip:{
		    	show: true,  
		        formatter: "{a} {b} : {c}"
		    },
		    calculable : true,
		    legend:{
		    	data:['','']
		    },
		    xAxis: {
		    	splitLine:{show: false},
		        data: [''],
		        type:'category',
		        axisLine:{
		        	lineStyle:{
		        		color:'#a5a5a4'
		        	}
		        },
		        splitArea : {show : false}//保留网格区域
		    },
		    yAxis: {
		        splitLine:{show: false},//去除网格线
		        type:'value', 
		        axisLine:{
		        	lineStyle:{
		        		color:'#a5a5a4'
		        	}
		        },
		        splitArea : {show : false}//保留网格区域
		    },
		    series: [
		        { 
		        	name:'风险源',
		            type: 'bar',
		            data:[ele.fxy_count],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#FDCC68'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		             }
		        },
		        { 
		        	name:'应急预案',
		            type: 'bar',
		            data:[ele.fxy_have_yjya],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#9F9F99'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		             }
		        }
		    ]
		}; 
		//为echarts对象加载数据              
        myChart.setOption(option);   
	}
	function initbaoxian() { 
		var data = {}; 
		var elements = NetUtil.callJavaMethod(ctx+"/bxgl/pmBxCbxxController/querybaoxian", data);
		//console.info(elements);
		var ele = JsonUtil.objectFromString(elements); 
		$("#cbxxsum").text(ele.cbxxsum);
		$("#lpxxsum").text(ele.lpxxsum);
		$("#tsxxsum").text(ele.tsxxsum);
	}
	function initlipei() { 
		var data = {}; 
		var elements = NetUtil.callJavaMethod(ctx+"/bxgl/pmBxCbxxController/querylipei", data);
		//console.info(elements);
		var eles = JsonUtil.objectFromString(elements); 
		$("#table_details").empty();
		eles.forEach(function( val, index ) {
			  var $tr = $("<tr> <td class='col-xs-10'>"+val.DIV_VALUE+"</td> <td class='col-xs-2'>"+val.SUM+"个</td> </tr>");
			 $("#table_details").append($tr);
		 });   
	}
	
	function initgongk() { 
		var data = {}; 
		var elements = NetUtil.callJavaMethod(ctx+"/xcgl/pmXianchangController/querygongk", data);
		//console.info(elements);
		var ele = JsonUtil.objectFromString(elements); 
		var sum = ele.sum;
		var chuli = ele.chuli;
		var weichuli = ele.weichuli;
		var chaoqi = ele.chaoqi;
		
		$("#gk_num").text(ele.sum); 
		$("#gk_chuli").text(ele.chuli);
		$("#gk_wei").text(ele.weichuli);
		$("#gk_chaoqi").text(ele.chaoqi);
		
		
		var sum_chuli = sum-chuli;
		var weichuli_chaoqi = weichuli-chaoqi;
		 
		var myChart = echarts.init(document.getElementById('gongkuang_echart_bar'));   
		var option = {
			grid: { // 控制图的大小，调整下面这些值就可以，
			      x:20,
			      y:20,
			      x2:20,
			      y2:20// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
	        },
		    tooltip:{
		    	trigger:'axis',
		    	formatter:function(a) 
		    	{ 
		    	   console.info(a);
		    	   var b1= a[0];
		    	   var b2= a[1];
		    	   var b3= a[2];
		    	   var b4= a[3];
		    	   
		    	   var weichuli = b1[3];
		    	   var yichaoqi = b2[3];
		    	   var gongkuang =b3[3];
		    	   var chulizhong= b4[3];
		    	   //(parseInt(gongkuang)+parseInt(chulizhong)) (parseInt(weichuli)+parseInt(yichaoqi))
		    	   return "工况总数:"+(parseInt(gongkuang)+parseInt(chulizhong))+"<br>"+"处理中:"+chulizhong+"<br>未处理:"+(parseInt(weichuli)+parseInt(yichaoqi))+"<br>已超期:"+yichaoqi;
		    	} 
		    }, 
		    legend:{
		    	data:[]
		    },
		    calculable : true,
		    xAxis: {
		        data: [''],
		        type:'category',
		        axisLine:{
		        	lineStyle:{
		        		color:'#a5a5a4'
		        	}
		        }
		    },
		    yAxis: {
		        type:'value',
		        axisLine:{
		        	lineStyle:{
		        		color:'#a5a5a4'
		        	}
		        },
		        splitLine:{show: false},//去除网格线
		        splitArea:{show: false}//去除网格线
		    },
		    series: [
		        { 
		        	name:'处理中',
		            type: 'bar',
		            stack: '总量',
		            data:[chuli],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#ADADAB'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		            }
		        }, 
		        { 
		        	name:'工况数 ',
		            type: 'bar',
		            stack: '总量',
		            data:[sum_chuli],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#74D1BE'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		             }
		        }, 
		        { 
		        	name:'已超期',
		            type: 'bar',
		            stack: '总量1',
		            data:[chaoqi],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#C1C1C0'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		             }
		        },
		        { 
		        	name:'未处理',
		            type: 'bar',
		            stack: '总量1',
		            data:[weichuli_chaoqi],
		            barWidth: 45,//固定柱子宽度
		            itemStyle: {
		                normal: {
		                    color: function(params) { 
		                        var colorList = ['#FDCC68'];
		                        return colorList[params.dataIndex];
		                    }
		                }
		             }
		        }
		    ]
		}; 
		//为echarts对象加载数据              
        myChart.setOption(option);   
	}
	
	function initxcgongk() { 
		var data = {}; 
		var elements = NetUtil.callJavaMethod(ctx+"/xcgl/pmXianchangController/queryxcgongk", data);
		//console.info(elements);
		var ele = JsonUtil.objectFromString(elements); 
		$("#xcgk_num").text(ele.sum);
		$("#xcgk_close").text(ele.close);
		$("#xcgk_chuli").text(ele.chuli);
		$("#xcgk_chaoqi").text(ele.chaoqi);
		var sum = ele.sum;
		var close = ele.close;
		var chuli = ele.chuli;
		var chaoqi = ele.chaoqi;
		var myChart = echarts.init(document.getElementById('gongkuang_tongji_echart_pie'));   
		option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: { 
			        x : 'center',
			        y: 'top',
			        //data:['已关闭','处理中','未处理']
			        data:[]
			    },
			    calculable : false,
			    series : [
			        {
			            name:'统计',
			            type:'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[  
			                {value:close, name:'已关闭'},
			                {value:chuli, name:'处理中'},
			                {value:chaoqi, name:'未处理'}
			            ]
			        }
			    ],
			    color:['#D5D9D8', '#91CBCD','#F5CD9D']
			}; 
		 myChart.setOption(option);   
	}
	

	function getNowFormatDate() { 
	    var date = new Date(); 
	    var seperator1 = "-"; 
	    var seperator2 = ":"; 
	    var month = date.getMonth() + 1; 
	    var strDate = date.getDate(); 
	    if (month >= 1 && month <= 9) { 
	        month = "0" + month; 
	    } 
	    if (strDate >= 0 && strDate <= 9) { 
	        strDate = "0" + strDate; 
	    } 
	    var currentdate = date.getFullYear() + "/" + month + "/" + strDate; 
	    return currentdate; 
	} 
	
	function getDayOfWeek(){
		var d=new Date() ;
		var day=new Array(7); 
		day[0]="星期日"; 
		day[1]="星期一"; 
		day[2]="星期二"; 
		day[3]="星期三"; 
		day[4]="星期四"; 
		day[5]="星期五"; 
		day[6]="星期六"; 
		return day[d.getDay()];
	}
	
});
