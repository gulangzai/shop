
addEventListener("message", function(evt){
var message = evt.data;
var xhr = new XMLHttpRequest();
xhr.open("GET", message);
xhr.onload = function(){
			if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    var response=null;
                    try {
							//console.log(xhr.responseText);
                         response = eval("(" + xhr.responseText + ")");
                     } catch (e) {
                     console.log("解析responseText返回值出错");
                    }
					//console.log(response);
					postMessage(response);
                }
            }
};
xhr.send();
},false);