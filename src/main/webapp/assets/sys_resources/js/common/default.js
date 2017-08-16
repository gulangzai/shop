var defaultJson = new Object();

var g_prompt = new Array("操作成功！");

/*
 * 处理插入后返回的json串
 * 
 * resultdata:接收返回的字符串
 * return 
 * insertJsonObj
 * 插入格式的json对象
 */
defaultJson.dealResultJson = function(resultdata) {
	var subresultmsgobj;
	var resultmsgobj = convertJson.string2json1(resultdata);
	subresultmsgobj = resultmsgobj.response.data[0];
	return subresultmsgobj;
};
//----------------------------------------
/**
 * 将json串组成保存json串格式
 * param:data1为json  字符串对象
 */
defaultJson.packSaveJson = function(data1) {
	// 开始解析json对象
	if (data1 == null) return "";
	
	var data1 = "{\"response\":{\"data\":[" + data1 + "]}}}";
	//return JSON.parse(data1);
	var data = {

		msg : data1
	}
	return data;
};

/**
 * 通用输入更新调用函数
 * param： actionName 访问spring路径
 * param:  data1 更新的数据 json 对象
 * param： tableisID 操作的表对象
 */
defaultJson.doUpdateJson = function(actionName, data1,tablistID,callbackFunction) {
    var success  = true;
    var isAsync = false;
    if(callbackFunction!=undefined){
 	   isAsync = true;
    }
	$.ajax({
		url : actionName,
		data : data1,
		dataType : 'json',
		async :	isAsync,
		type : 'post',
		//contentType:'application/json;charset=UTF-8',	    
		success : function(result) {
			$("#resultXML").val(result.msg);
			//将返回值增加到TabList中,将返回的串转换为数组形式
			if(tablistID != null)
			{
					var rowIds = CommUtils.getJqgridSelected(tablistID);
					jQuery("#"+tablistID).jqGrid().trigger("reloadGrid");//.updateGridRows(result.msg,rowIds,true);
					
//					var rowindex = $("#"+tablistID.id).getSelectedRowIndex();
//					var subresultmsgobj = defaultJson.dealResultJson(result.msg);
					/*
					 * 如果返回结果为单表，更新的table也为单表则可以直接将subresultmsgobj传给updateResult使用，否则需要如下方式组成新的json
					 * 
					 */
//					var comprisesJson = $("#"+tablistID.id).comprisesJson(subresultmsgobj,rowindex);
//					var strarr = $("#"+tablistID.id).updateResult(JSON.stringify(comprisesJson),tablistID,rowindex);
//
//					$("#"+tablistID.id).setSelect(rowindex);
					
			}
			var prompt = result.prompt;
 			if(!prompt){
 				prompt =g_prompt[0];
 			}
			xAlert("信息提示",prompt);
			
			//defaultJson.clearTxtXML();
			success = true;
			if(isAsync==true){
			  eval(callbackFunction+"()");
			}
		},
	    error : function(result) {
	     	alert(result.msg+"  出错！");
		    //defaultJson.clearTxtXML();
		    success = false;
	    }
	});
	 return success;
};

/**
 * 通用输入插入调用函数
 * param： actionName 访问spring路径
 * param:  data1 插入的数据 json 对象
 * param： tableisID 操作的表对象
 */
defaultJson.doInsertJson = function(actionName, data1,tablistID,callbackFunction) {
    var success  = true;

	var isAsync = false;
	if (callbackFunction != undefined) {
		isAsync = true;
	}
	$.ajax({
		url : actionName,
		data : data1,
		dataType : 'json',
		async :	isAsync,
		type : 'post',
		//contentType:'application/json;charset=UTF-8',	    
		success : function(result) {
			//将返回值增加到TabList中,将返回的串转换为数组形式
			//alert(result.msg);
			//add by zhangbr@ccthanking.com BEGIN 
			//上传附件时，需要使用resultXML中的值，所以此处查询成功后，要将返回结果赋值给resultXML
			//如果页面不存在resultXML，附件上传时也有判断，不会报错
			//add by zhangbr@ccthanking.com END
			
			if(tablistID != null)
			{
				jQuery("#"+tablistID).jqGrid().trigger("reloadGrid");//.updateGridRows(result.msg,rowIds,true);
			}
			var prompt = result.prompt;
 			if(!prompt){
 				prompt =g_prompt[0];
 			}
			
			xAlert("信息提示",prompt);

			success = true;
			if(isAsync==true){
			  eval(callbackFunction+"()");
			}
			},
	    error : function(result) {
			    success = false;

		}
	});
	 return success;
};


/**
 * 通用输入插入调用函数
 * param： actionName 访问spring路径
 * param:  data1 插入的数据 json 对象
 * param： tableisID 操作的表对象
 */
defaultJson.doInsertJsonNoTs = function(actionName, data1,tablistID,callbackFunction) {
    var success  = true;

	var isAsync = false;
	if (callbackFunction != undefined) {
		isAsync = true;
	}
	$.ajax({
		url : actionName,
		data : data1,
		dataType : 'json',
		async :	isAsync,
		type : 'post',
		//contentType:'application/json;charset=UTF-8',	    
		success : function(result) {
			//将返回值增加到TabList中,将返回的串转换为数组形式
			//alert(result.msg);
			//add by zhangbr@ccthanking.com BEGIN 
			//上传附件时，需要使用resultXML中的值，所以此处查询成功后，要将返回结果赋值给resultXML
			//如果页面不存在resultXML，附件上传时也有判断，不会报错
			//add by zhangbr@ccthanking.com END
			
			if(tablistID != null)
			{
				jQuery("#"+tablistID).jqGrid().trigger("reloadGrid");//.updateGridRows(result.msg,rowIds,true);
			}
			var prompt = result.prompt;
 			if(!prompt){
 				prompt =g_prompt[0];
 			}
			
			//xAlert("信息提示",prompt);

			success = true;
			if(isAsync==true){
			  eval(callbackFunction+"()");
			}
			},
	    error : function(result) {
			    success = false;

		}
	});
	 return success;
};

/**
 * 通用  添加新数据 之后返回新数据 result 
 * param： actionName 访问spring路径
 * param:  data1 插入的数据 json 对象
 * param： tableisID 操作的表对象
 */
defaultJson.doInsertJsonReturn = function(actionName, data1,tablistID,callbackFunction) {
    var success  = "";
	var isAsync = false;
	if (callbackFunction != undefined) {
		isAsync = true;
	}
	$.ajax({
		url : actionName,
		data : data1,
		dataType : 'json',
		async :	isAsync,
		type : 'post',
		//contentType:'application/json;charset=UTF-8',	    
		success : function(result) {
			//将返回值增加到TabList中,将返回的串转换为数组形式
			//alert(result.msg);
			//add by zhangbr@ccthanking.com BEGIN 
			//上传附件时，需要使用resultXML中的值，所以此处查询成功后，要将返回结果赋值给resultXML
			//如果页面不存在resultXML，附件上传时也有判断，不会报错
			//add by zhangbr@ccthanking.com END
			
			if(tablistID != null)
			{
				jQuery("#"+tablistID).jqGrid().trigger("reloadGrid");//.updateGridRows(result.msg,rowIds,true);
			}
			var prompt = result.prompt;
 			if(!prompt){
 				prompt =g_prompt[0];
 			}
 			xAlert("信息提示",prompt);

			success = true;
			if(isAsync==true){
			  eval(callbackFunction+"()");
			}
			success=result;
			},
	    error : function(result) {
			    success="";
		}
	});
	 return success;
};

xAlert =function(title,content,type)
{  
	if(title==null||title==undefined||title==""){
		title = "信息提示";
	}
	if(type==undefined){
		type = "1";//默认状态成功
	}
	if(title==undefined||title ==null){
		title = "";
	}
	var cssName = "";
	if(type==1){//成功
		cssName += "gritter-success ";
	}
	if(type==2){//失败
		cssName +="gritter-error ";
	}
	if(type==3){//警告
		cssName += "gritter-warning";
	}
	
	$.gritter.add({
		title: title,
		text: content,
		time:200,
		class_name: cssName
	});

//	
//	$('#pubAlert').modal({
//	    backdrop:false,
//	    keyboard:false,
//	    show:true
//	});
	

};
