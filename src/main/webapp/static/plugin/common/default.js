xAlert = function(title,content,type){
	if(title==null||title==undefined||title==''){
		title="信息提示";
	}
	if(type==undefined){
		type="1";//默认状态成功
	}
	
	//成功
	var cssName="gritter-success";
	
	if(type==2){//失败
		cssName ="gritter-error ";
	}
	if(type==3){//警告
		cssName = "gritter-warning";
	}
	
	$.gritter.add({
		title: title,
		text: content,
		time:200,
		class_name: cssName
	});
	
}