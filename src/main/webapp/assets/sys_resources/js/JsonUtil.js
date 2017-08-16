var JsonUtil = function(){ 
	 return{ 
		 objectFromString:function(str){
			 return eval("("+str+")");
		 }
	 };  
}();
