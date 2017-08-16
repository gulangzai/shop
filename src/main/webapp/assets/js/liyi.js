var klm = klm || {};

klm = (function(){ 
	var datas;

	 liyi_init = function(){
		datas = [{id:"1",pid:"0",name:"文档1"},
		            {id:"11",pid:"1",name:"文档11"},
		            {id:"111",pid:"11",name:"文档111"},
		            {id:"112",pid:"11",name:"文档112"},{id:"2",pid:"0",name:"文档二"}]; 

		this.createById(0); 
	 };
 
	 createById = function(pid){
		$("#grid_table").empty(); 
		for(var i=0;i<datas.length;i++){
			console.info("data["+i+"]"+datas[i]);
			if(datas[i].pid==pid){
				$("#grid_table").append("<tr id='"+datas[i].id+"' onclick=\'klm.createById("+datas[i].id+")\'><td>"+datas[i].name+"</td></tr>");
			}
		} 
	};
	 
	
   return{
	     liyi_init: liyi_init,
	     createById:createById
   }
	 
})(jQuery);
	



