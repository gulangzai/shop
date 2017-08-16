var JqgridManager = new Object();


var LanbaoWin = function(){ 
	 return{
		 //跳转
		 openWin:function(url){
			 window.location.href=url;
		 },
		  myShowModalDialog:function (url,width,height){  
			  
				var arguments = window;
				width = width?width:500;
				height = height?height:350; 
				var left = (screen.width-width)/2;
				var top = (screen.height-height)/2;
				var features=""
					+ "dialogLeft:" + left + ";"  //��߾�
			        + "dialogTop:" + top + ";"    //������
					+"dialogWidth:"+width+"px;"   //���
					+"dialogHeight:"+height+"px;" //�߶�
					+"center:yes;"  //   �Ƿ����
					+"resizable:no;" //�Ƿ���Ըı��С
					+"scroll:no;"  //�����ݳ����ʱ�Ƿ���ʾ������
					+"status:yes;"  //�Ƿ���ʾ״̬�� 
				    +"help:no;";   //�Ƿ���ʾ����ť
				var sPageURL = sWebRootPath+url;
				window.showModalDialog(sPageURL,arguments,features); 
				//window.showModelessDialog(sPageURL,arguments,features);
			},
			//���������
			randomNumber:function(){
				//return Math.abs(Math.sin(new Date().getTime())).toString().subStr(2);
				return Math.abs(Math.sin(new Date().getTime()));
			},
			//�淶url
			_getParaString:function(sPara){
				if(typeof(sPara)=="undefined"||sPara==""){
					return "";
				}else if(sPara.subString(0,1)=="&"){
					return encodeURI(encodeURI(sPara));
				}else{
					return "&"+encodeURI(encodeURI(sPara));
				}
			},
			OpenPage:function(sURL,sPara,sTargetWindow,sStyle){
				if(typeof(sURL)=="undefined"||sURL==""){
					alert("URL����Ϊ��");
					return false;
				}
				if(sURL.indexOf("?")>0){
					alert("url�д���\"?\"");
					return false;
				}
				var sWindowToUnload;
				if(sTargetWindow==null||sTargetWindow=="_self"){
					sWindowToUnload = "self";
				}else if(sTargetWindow=="_top"){
					sWindowToUnload = "top";
				}else if(sTargetWindow=="_blank"){
					sWindowToUnload = "blank";
				}else if(sTargetWindow=="_parent"){
					sWindowToUnload = "parent";
				}else{
					sWindowToUnload = sTargetWindow;
				}
				
				var sPageURL = sWebRootPath+sURL;
				if(sURL.indexOf("?")<0){
					sPageURL = sPageURL+"?";
				}else if(sURL.substr(sURL.length-1)!="?"){
					sPageURL = sPageURL+"&";
				}
			    sPageURL = sPageURL+this._getParaString(sPara)+"&randp="+this.randomNumber();
			    
		/*	    alwaysLowered	yes/no	ָ���������������д���֮��
			    alwaysRaised	yes/no	ָ�������������д���֮��
			    depended	yes/no	�Ƿ�͸�����ͬʱ�ر�
			    directories	yes/no	Nav2��3��Ŀ¼���Ƿ�ɼ�
			    height	pixel value	���ڸ߶�
			    hotkeys	yes/no	��û�˵����Ĵ������谲ȫ�˳��ȼ�
			    innerHeight	pixel value	�������ĵ������ظ߶�
			    innerWidth	pixel value	�������ĵ������ؿ��
			    location	yes/no	λ�����Ƿ�ɼ�
			    menubar	yes/no	�˵����Ƿ�ɼ�
			    outerHeight	pixel value	�趨����(����װ�α߿�)�����ظ߶�
			    outerWidth	pixel value	�趨����(����װ�α߿�)�����ؿ��
			    resizable	yes/no	���ڴ�С�Ƿ�ɵ���
			    screenX	pixel value	���ھ���Ļ��߽�����س���
			    screenY	pixel value	���ھ���Ļ�ϱ߽�����س���
			    scrollbars	yes/no	�����Ƿ���й�����
			    titlebar	yes/no	������Ŀ���Ƿ�ɼ�
			    toolbar	yes/no	���ڹ������Ƿ�ɼ�
			    Width	pixel value	���ڵ����ؿ��
			    z-look	yes/no	���ڱ�������Ƿ��������֮��
			    */
			    
			    window.open(sPageURL,sTargetWindow,sStyle+",alwaysRaised=yes,titlebar=no,location=yes,menubar=no,toolbar=no,z-look=yes");
			} 
	 } ;  
}();

 
var Lanbao={}; 
/*
 * RunJavaMethodservlet
 * */
Lanbao.RunJavaMethod = function(ClassName,MethodName,Args){ 
	return Lanbao.CallJavaMethod(ClassName,MethodName,Args,ClassName);
};


Lanbao.CallJavaMethod = function(ClassName,MethodName,Args,ArgsObjectText){
	return $.ajax({
		type:"POST",
		url:sWebRootPath+"/servlet/RunJavaMethodServlet?1=1"+ArgsObjectText,
		data:{
			"sClass":ClassName,
			"sMethod":MethodName,
			"sArgs":Args
		},
		async:false
	}).responseText.trim(); 
};

/*
 * ��ӦspringMVC control
 * */
Lanbao.RunCtrMethod = function(address,args){
	var result= $.ajax({
		type:"POST",
		url:sWebRootPath+"/"+address+"?1=1",
		dataType:"text",
		data:{
			/*"sClass":ClassName,
			"sMethod":MethodName,*/
			"args":args
		},
		async:false
	}).responseText;  
	// console.log(result);
	return  result;
};

//form
Lanbao.getFormValueByName = function(name,para){
	//return $(":input[name='"+name+"']").val();
	 return $("[name='"+name+"']").attr(para);
};

//select
Lanbao.getSelValueByName = function(name){
	return $("[name='"+name+"']").val();
};
//select���õڼ���ֵѡ��
Lanbao.getSelOptionValue = function(name,value){
	 $("[name='"+name+"']").find("option[value='"+value+"']").attr("selected",true);
}; 

Lanbao.getIEVersion = function(){
	var str="";
	if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/6./i)=="6."){
		   str = "IE 6";
		}
		else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7."){
			str="IE 7";
		}
		else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
			str="IE 8";
		}
		else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/9./i)=="9."){
			str="IE 9";
		} 
	return str;
}

var FormValid = new Object();
/**
 * 验证框架
 */
FormValid.validbyFormId = function(formId){
	var v = $(formId).Validform({
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
				var left0=o.obj.position().left;
				var top0 = o.obj.position().top; 
				infoObj.css({
					left:left0,
					//left:160,
					top:top0
				}).show().fadeIn(5000);
			} 
		}
	  }
	});
	return v;
}

JqgridManager.getColModel = function(jqgrid){
	 var jqueryCondition;
	 jqueryCondition.colModels=[];
	 $("#"+jqgrid+" th").each(function(){
		 var col = {};
		 console.info($(this).attr("name"));
	 });
}


JqgridManager.init = function(jqgrid){
	
	console.info(jqgrid);
	
	JqgridManager.getColModel(jqgrid);
	
	 $("#jqGrid").jqGrid({
  	   url: "${ctx}/tbProductController/dataList.do",
         colModel: [
             {
				 label: '商品名',
                 name: 'F_PRODUCTNAME', 
                 width: 15, 
                 sortable:false
             },
             {
				   label: '商品描述',
                 name: 'F_PRODUCTDESC', 
                 width: 55
             },
             {
					label: '商品价格',
                  name: 'F_PRICE',
                  width: 15,  
					align: 'center'
             },
             {
					label: '操作', 
					name:'OPERATOR',
                    width: 15,  
					align: 'center',
				    formatter:doReportInfo
             }
         ],  
         autowidth:true,
         shrinkToFit:true, //此属性用来说明当初始化列宽度时候的计算类型，如果为ture，则按比例初始化列宽度。如果为false，则列宽度使用colModel指定的宽度
         height: 250,
         rowNum: 10,
         rowList:[10,20,50],
		   datatype: 'json',
		   viewrecords:true,  //定义是否要显示总记录数
		   rownumbers:true,   //如果为ture则会在表格左边新增一列，显示行顺序号，从1开始递增。此列名为'rn'.
		   multiselect:true,  //多选
		   jsonReader:{
				root:function (page){return page.data;},
		    	total:function (page){return page.totalPage;},
   		    page:function (page){return page.currentPage;},
   		    records:function (page){return page.totalResult;}	   
			   
		   },
		   loadComplete:function(data){
			   console.log(data);
			   console.log(data.rows);
		   },
         pager: "#jqGridPager", 
     });   
 
}


