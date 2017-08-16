var NetUtil = {};

NetUtil.callJavaMethod = function(url,data){
	return $.ajax({
		type : 'post',
		url :url,
		data : data,
		cache : false,
		async :	false,
		dataType : "json" 
	}).responseText.trim();
};
