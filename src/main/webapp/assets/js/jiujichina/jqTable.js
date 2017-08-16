
(function($){
	
	var tableContent;
	var table;
	var mobile='';
	var studentId='';
	var studentName='';
	var keyword='';
	var queryCondition;
	var url;
	var colNames; 
	var colModel;
	
	
	var bb=[];
    $.fn.table = function(options){  
    	tableContent = this; 
    	table = new Table(options); 
    	
    	for(var k=0;k<table.colNames.length;k++){ 
    		bb[k]=table.colNames[k]; 
    	}
    	table.addHeader(bb); 
    	flush(1);
    	return table;
    };
    
	
	//我选中的列表
	var choiceStudents = new Array(); 
	//选中的表头列表
	var choiceStudentHead = new Array();
	 
	function getParameter(){ 
 		keyword = $("input[name='search']").val();  
 		alert(keyword);
 		//console.info('m'+mobile+'studentId:'+studentId+'studentName'+studentName);
 	}
	
	//搜索
	$("#search").click(function(){ 
	    keyword = $("input[name='search']").val();//alert(); 
		table.keyword = keyword;
		flush(1,keyword);
	});
	
	//定时器 显示进度 
	function showProgress(){ 
		    var value = $('#p').progressbar('getValue');  
		    value += Math.floor(Math.random() * 10);
		    $('#p').progressbar('setValue', value); 
	}
	
	//列表头点击复选框
	Table.prototype.headCheck = function(trThPageNum){
		 if($('input[name="studentIdheadCheck'+trThPageNum+'"]:checkbox').is(":checked")){
			 
			 $("."+trThPageNum).each(function(){
				$(this).attr("checked",true);
				table.check(trThPageNum,$(this).val());
			});
			 choiceStudentHead.push(trThPageNum.toString());
		}else{
			$("."+trThPageNum).each(function(){
				$(this).attr("checked",false);
				table.check(trThPageNum,$(this).val());
			}); 
			 choiceStudentHead.splice(choiceStudentHead.indexOf(trThPageNum),1);
		}  
		 //console.info(choiceStudentHead);
	}
	
    Table.prototype.check = function(trThPageNum,studentId){
    	//console.info(studentId);
    	if($('input[name="studentIdChecked'+trThPageNum+studentId+'"]:checkbox').is(":checked")){
    		//没有就添加
    		if(choiceStudents.indexOf(studentId)==-1)
    		    choiceStudents.push(studentId);
    	}else{
    		//有就移除
    		if(choiceStudents.indexOf(studentId)!=-1)
    		    choiceStudents.splice(choiceStudents.indexOf(studentId),1);
    	} 
    	//console.info('coniceStudents'+choiceStudents);
    }
	
	//导出excel
	var t1;
	$("#exportExcel").click(function(){
		$(".easyui-progressbar").show();  
	/*	var checks = $('input[type="checkbox"]:checked');  
		for(var i=0;i<checks.length;i++){
			var flag = true;
			for(var j=0;j<choiceStudents.length;j++){
				console.info('判断：'+choiceStudents[j]+'-'+$(checks[i]).val());
				if(choiceStudents[j]==$(checks[i]).val()){
					flag=false;
					break;
				} 
			} 
			if(flag)
				choiceStudents.push($(checks[i]).val());
		}*/
		
		if(choiceStudents.length==0){
			alert('请选择你要导出的学生');
			return;
		}
		
		//console.info(choiceStudents) 
		  
		//alert(choiceStudents);
	 	t1 = window.setInterval(showProgress,1000); 
		   /* headColor:table.headColor, 
			intention:table.intention, 
			keyword:keyword,*/
		$.ajax({
			//url:ctx+'/myStudent/exportExcel.do',
    		type:'post',
    		dataType:"json", 
    		data:JSON.stringify(choiceStudents), 
		    contentType:"application/json",
    		async:false,
    		success:function(sR){
    			if(sR.message=='FAIL'){
    				alert('生成失败');
    			}else{   
    				window.clearInterval(t1); 
    				$(".easyui-progressbar").hide();
    				//window.location.href=ctx+"/myStudent/downloadExcel.do";
    			}
    		}
    	});   
	});
	
	 
	$("input:radio[name='RadioGroup1']").click(function(){  
		choiceStudents = new Array(); 
	  /*  $(".colorOpe").each(function(index){
	    	$(this).css("background-image",""); 
	    	   //console.info($(this));
	    });
	    $(this).css("background-image","url("+ctx+"/static/images/studentList/u840.png)");*/
		var bb = [];
    	for(var k=0;k<table.columns.length;k++){ 
    		bb[k]=table.columns[k].title;
    	}
    	table.headColor = $("input:radio[name='RadioGroup1']:checked").val(); 
    	table.intention = $("input:radio[name='RadioGroup2']:checked").val();
    	 //alert('---'+table.headColor+"--"+table.intention);
    	tableContent.empty();
    	table.addHeader(bb); 
    	flush(1);
	});
	
	$("input:radio[name='RadioGroup2']").click(function(){  
		    choiceStudents = new Array(); 
			var bb = [];
	    	for(var k=0;k<table.columns.length;k++){ 
	    		bb[k]=table.columns[k].title;
	    	}
	    	table.headColor = $("input:radio[name='RadioGroup1']:checked").val(); 
	    	table.intention = $("input:radio[name='RadioGroup2']:checked").val();
	    	 //alert('---'+table.headColor+"--"+table.intention);
	    	tableContent.empty();
	    	table.addHeader(bb); 
	    	flush(1);
	});
	
	
    
    var majorId;
    //表格对象
    function Table(options){
    	majorId=options.majorId;
    	//this.columns = options.columns;     //列集合
    	this.queryCondition = options.queryCondition; //查询条件
    	this.url = options.url; 
    	this.colNames = options.colNames;   //列名
		this.colModel = options.colModel;   //列字段
    	this.headColor = options.headColor;
    	this.majorId = options.majorId;
    	this.trNum;
    	this.header = [];   //表头数据
    	this.allData=[];    //
    	this.rowData=[]; 
    	this.contentData=[];//内容数据
    	this.$lis=[];       //分页标签
    	this.currentPage=1; //选中的当前页
    	this.allPageNum;    //总共的页数
    	this.allRecodeNum;  //总的数据量
    	this.keyword;       //搜索的关键词 
    	this.intention=0;   //意向
    }
    
    //获取数据
    function getRemoteData(currentPage,keyword){
    	 
    	$.ajax({
    		type:'post',
    		url:table.url,
    		async:false,
    		dataType:"json",
    		data:table.queryCondition, 
    		success:function(sR){
    			//alert(sR);
    			//sR = eval("("+sR+")");
    			//console.info(sR); 
    			var msg=sR.msg; 
    			//alert(msg);
    			msg = eval("("+msg+")"); 
    			var response = msg.response;
    			//response = eval("("+response+")");
    			//alert(response);
    			var pages = msg.pages; 
    			//alert(pages);
    			//pages = eval("("+pages+")"); 
    			var dd = response.data;
    			//dd = eval("("+dd+")");
    			 console.log(dd); 
    			for(var i=0;i<dd.length;i++){  
    			    table.addContentTr(dd[i]); 
    			    //独一无二 
    			}
    			table.allRecodeNum = pages.recordsperpage; 
    		}
    	});
    }
    
    //添加表头
    function addHeader(){  
    	for(var ii=0;ii<table.header.length;ii++){
    		tableContent.append(table.header[ii]); 
    	}
    }
    
    //添加数据
    function addData(){ 
    	for(var i=0;i<table.contentData.length;i++){ 
    		tableContent.append(table.contentData[i]); 
    	} 
    }
    
 
    Tr.prototype.addTh = function(thData){
    	this.rowData[this.rowData.length] = new Th(thData);
    }
    
    Tr.prototype.addTd = function(tdData){
    	this.rowData[this.rowData.length] = new Td(tdData);
    } 
    
    Table.prototype.addOperate = function($tr,trData){
    
    	/*var $th = $('<td style="width:350px;"><ul><li class="yhj"><input type="hidden" name="studentId" value="'+trData[7]+'"><a href="javascript:void(0)" onclick="studentYouhuiQuan(\''+trData[7]+'\')">优惠券</a></li><li><a href="javascript:void(0)" onclick="studentDetail(\''+majorId+'\',\''+trData[7]+'\')">查看详情</a></li>'
    			+'<li><a href="javascript:void(0)" onclick="table.deleteStudentByPhone('+trData[3]+')">删除</a></li>'
    			+'<li><a href="javascript:void(0)" onclick="table.resetPassword('+trData[3]+')">重置密码</a></li></ul></td>');
    	$tr.append($th);
    	*/
    }
    
    
    Table.prototype.addTr = function(trData){
    	this.allData[this.allData.length] = new Tr(trData);
    }
    
    Table.prototype.addHeader = function(trData){
    	this.header=[];
    	this.header[this.header.length] = new TrTh(trData);
    }
    
    Table.prototype.addContentTr = function(trData){ 
    	var tr = new Tr(trData); 
    	this.addOperate(tr,trData);
    	this.contentData[this.contentData.length] = tr;
    }
    
    //分页下标(当前页,总共的记录条数)
    function addPageTool(currentPage,allRecodeNum){ 
    	tableContent.next().remove();
    	var $ulDiv = $('<div style="magin-top:0px;"></div>'); 
    	$ulDiv.append(table.createUI(currentPage,allRecodeNum));
    	tableContent.after($ulDiv);  
    	return $ulDiv;
    }
    
    function RenderLi(btnLabel,currentPage){
    	var $li = $('<li onclick="table.myClick(\''+btnLabel+'\');">'+currentPage+'</li>'); 
    	return $li;
    }
     
    Table.prototype.createUI = function(currentPage,allRecodeNum){ 
    	this.currentPage=currentPage;
    	var allPageNum = (parseInt(allRecodeNum%5)==0)?parseInt(allRecodeNum/5):parseInt(allRecodeNum/5)+1;
    	//alert(allRecodeNum+'-'+allPageNum);
    	this.allPageNum=allPageNum;
    	 //alert(allRecodeNum+'总共页数'+allPageNum);
    	var $ul = $("<ul class='pages'></ul>"); 
    	var $li= new RenderLi('first',"首页");
    	$ul.append($li);
    	$li  = new RenderLi("last","上一页")
    	$ul.append($li);	
    	this.$lis[this.$lis.length]=$li;
    	var startLi = 1;
    	var endLi = 9;
    	
    	if(currentPage>4){
    		startLi = parseInt(currentPage)-4;
    		endLi = parseInt(currentPage)+4;
    	}
    	if(allPageNum<endLi){
    		endLi = allPageNum;
    	}
    	if(allPageNum<startLi){
    		startLi = 1;
    		endLi = 1;
    	}
    	//alert(currentPage+'-'+startLi+'-'+endLi);
    	for (var point = startLi; point < endLi; point++) {
    		var $li = new RenderLi(point,point); 
    		if(point==currentPage){
    			$li.addClass("pgCurrent");
    		}
    		this.$lis[this.$lis.length]=$li;
    		$ul.append($li);
    	}  
    	var num = 10;
    	if(allPageNum>endLi){
    		$li=new RenderLi("...","...");
    		num=+1;
        	this.$lis[this.$lis.length]=$li;
        	$ul.append($li);
    	} 
    	
    	//末页
    	$li = new RenderLi(allPageNum,allPageNum);
    	if(this.allPageNum==currentPage){
    		$li.addClass("pgCurrent");
    	}
    	$ul.append($li);
    	
    	$li=new RenderLi("next","下一页"); 
    	this.$lis[this.$lis.length]=$li; 
    	$ul.append($li);   
    	
    	//共多少页
    	$li = new RenderLi("all","共"+allPageNum+"页");
    	$ul.append($li);
    	return $ul;
    }
    
    //点击标签页
    Table.prototype.myClick = function(currentPage){  
    	if(currentPage=='first'){
    		this.currentPage = 1;
    		 currentPage = 1;
    	}
    	if(currentPage=='all') return;
    	if(currentPage=='...') return;
    	if(currentPage=='last'){
    	  	this.currentPage = this.currentPage -1;
    	}else if(currentPage=='next'){
    		this.currentPage = parseInt(this.currentPage) +1; 
    	}else{
    		this.currentPage = currentPage;
    	} 
    	currentPage = this.currentPage; 
    	if(currentPage<1) this.currentPage=1;
    	else if(currentPage>this.allPageNum) this.currentPage = this.allPageNum;  
    	//alert(currentPage);
    	//判断是否搜索
    	var keyword = $("input[name='search']").val();
    	if(keyword=='')
    	   flush(this.currentPage);
    	else{
    		//alert('搜索'+keyword);
    		 flush(this.currentPage,table.keyword); 
    	} 
    } 
    
    function flush(currentPage){
    	tableContent.next().remove();
    	fn();
    	//清空表格数据
    	table.contentData=[];
    	//表操作
    	getRemoteData(currentPage);
    	tableContent.empty(); 
        table.addHeader(bb);
    	addHeader();
    	//添加表格样式
    	addData();   
    	//alert('--ss-'+this.allRecodeNum);
    	addPageTool(currentPage,table.allRecodeNum); 
    }
    
    function flush(currentPage,keyword){
    	tableContent.next().remove();
    	//清空表格数据
    	table.contentData=[];
    	//表操作
    	getRemoteData(currentPage,keyword);
    	tableContent.empty(); 
    	table.addHeader(bb);
    	addHeader();
    	//添加表格样式
    	addData();    
    	addPageTool(currentPage,table.allRecodeNum); 
    }
    
    //初始化
    function init(){
    	tableContent.empty(); 
		addHeader();
		table.contentData=[]; 
    }
    
    Table.prototype.deleteStudentByPhone = function(phone){  
    	$.messager.confirm("确认", '你确认要删除该学员?', function (r) {  
		    	if(r){
		    		$.ajax({
			    		type:'post',
			    		url:ctx+'/myStudent/deleteStudentByPhone.do',
			    		async:false,
			    		data:{
			    			phone:phone
			    		},
			    		success:function(sR){
			    			if(sR.message=='DELETE_YES'){
			    				alert("删除成功"); 
			    				flush(table.currentPage,table.keyword);
			    			}else{
			    				alert("删除失败");
			    			} 
			    		}
			    	});
		    	} 
		    });
    }
    
    //重置密码
    Table.prototype.resetPassword = function(phone){   
        $.messager.confirm("确认", '你确认重置密码吗?', function (r) {  
    	        if (r) {  
    	        	$.ajax({
    	        		type:'post',
    	        		url:ctx+'/myStudent/resetPassword.do',
    	        		async:false,
    	        		data:{
    	        			phone:phone
    	        		},
    	        		success:function(sR){
    	        			if(sR.message=='RESET_SUCCESS'){
    	        				alert("密码重置成功,为初始密码123456");
    	        			} else{
    	        				alert("密码重置失败");
    	        			}
    	        		}
    	        	}); 
    	            return true;  
    	        }  
    	}); 
    }
     
    var thwidths=new Array("2%","2%","5%","6%","9%","11%","9%","10%","15%");
    function TrTh(ths){ 	
    	 //console.info(choiceStudentHead+''+ typeof table.currentPage); 
    	 var $tr = $('<tr></tr>');
    	 /*if(choiceStudentHead.indexOf(table.currentPage.toString())==-1){
    	   $tr.append(new Th('<input type="checkbox" name="studentIdheadCheck'+table.currentPage+'" onclick="table.headCheck('+table.currentPage+')"/>',thwidths[0])); 
    	 }else{  
      	   $tr.append(new Th('<input type="checkbox"  name="studentIdheadCheck'+table.currentPage+'" onclick="table.headCheck('+table.currentPage+')" checked="checked"/>',thwidths[0]));  
    	 }
    	 */ 
    	 for(var i=0;i<table.colNames.length-1;i++){ 
    		 $tr.append(new Th(table.colNames[i],table.colModel[i]));  
    	 }
     	 return $tr;
    }
    
    function Tr(obj){   
       //console.info(ths);
    	 var $tr = $('<tr></tr>');
    	 //判断如果是勾选的要默认选中 
    	//console.info(choiceStudents);
    	 /*if(choiceStudents.indexOf(ths[7])==-1){
    		 $tr.append(new Td('<input type="checkbox" onclick="table.check(\''+table.currentPage+'\',\''+ths[7]+'\')"  name="studentIdChecked'+table.currentPage+ths[7]+'" class="'+table.currentPage+'"  value="'+ths[7]+'"/>'));  
    	 }else{
    		 $tr.append(new Td('<input type="checkbox" onclick="table.check(\''+table.currentPage+'\',\''+ths[7]+'\')"  name="studentIdChecked'+table.currentPage+ths[7]+'" class="'+table.currentPage+'" checked="checked" value="'+ths[7]+'"/>'));  
    	 }
    	 */ 
    	 
    	 /*for(var i=0;i<ths.length-1;i++){
    		 $tr.append(new Td(ths[i]));  
    	 } */
    	 /*for(var name in obj){
    		 $tr.append(new Td(obj[name]));  
    	 }
    	 */
    	 for(var i=0;i<table.colModel.length-1;i++){ 
    		 $tr.append(new Td(obj[table.colModel[i].name],table.colModel[i]));  
    	 }
    	 
    	 return $tr;
    } 
    function Th(data,col){
    	//console.log(col);
    	if(col.width==undefined){
    		col.width=1;
    	} 
    	var $th = $('<th width='+col.width+' style="background-color:'+table.headColor+';color:black;" class="table_th">'+data+'</th>');
        return $th;
    }
    
    function Td(data,col){
    	console.log(col);
    	if(col.width==undefined){
    		col.width=1;
    	}
    	var $td = $('<td width='+col.width+'>'+data+'</td>');
    	return $td;
    }
})(jQuery);