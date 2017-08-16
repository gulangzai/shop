  <script type="text/javascript">
    
     function check(){  
    /*  if(!idenUser(form.userId)){
        alert(idenUser(form.userId)&&checkdata(form.pass)&&checkIdenPass(form.alpass)&&checkTele(form.tele)&&checkEmail(form.email));
     } */
         /* checkdata(form.pass) checkIdenPass(form.alpass) checkTele(form.tele) checkEmail(form.email)); */    
        if(idenUser(form.userId)&&checkdata(form.pass)&&checkIdenPass(form.alpass)&&checkTele(form.tele)&&checkEmail(form.email)){   
           var userId = form.userId.value;
           var pass = form.pass.value;
           var alpass = form.alpass.value;
           var name = form.name.value;
           var tele = form.tele.value;
           var email = form.email.value;
           var statusdiv =document.getElementById("status");  
           var status = statusdiv.options[statusdiv.selectedIndex].value;
           var louhaodiv = document.getElementById("louhao");
           var louhao = louhaodiv.options[louhaodiv.selectedIndex].text;
           var qingshidiv =document.getElementById("qingshi");  
           var qingshi = qingshidiv.options[qingshidiv.selectedIndex].text; 
          // alert("userId:"+userId+"alpass:"+alpass+"tele:"+tele+"email:"+email+"status:"+status+"louhao:"+louhao+"qingshi:"+qingshi);
           window.open("servlet/Register?userId="+userId+"&pass="+pass+"&alpass="+alpass+"&name="+name+"&tele="+tele+"&email="+email+"&status="+status+"&louhao="+louhao+"&qingshi="+qingshi); 
        }else{
           return;
        } 
     }
       function showdiv(){
         var ibodywidth = parseInt(document.body.offsetWidth);  
         var iwidth = (ibodywidth-400)/2;   
         document.getElementById("container").style.marginLeft=iwidth; 
      }  
      
      var xmlHttp = null;
      
      function idenUser(x){ 
        try{
            xmlHttp = new XMLHttpRequest();
        }catch(x){
           try{
              xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
           }catch(x){
              alert("you browser bu 支持 xmlhttp");
           return;
           }
        } 
       if(!checkdata(x)){  
           return false;
       }else{ 
            var userId = form.userId.value;
            var url = "servlet/Register?action=haveUser&userId="+userId;
            url = convertURL(url);
            xmlHttp.open("GET", url,false);
            xmlHttp.send(null);
            var e = document.getElementById("userIdName");
            var text = xmlHttp.responseText;  
           var liulan = navigator.userAgent;
            //alert(text);
            if(text=='NO') {
               e.innerText= "已存在该用户!";  
                e.style.display="block"; 
                if(liulan.indexOf('Firefox')){
                    e.textContent=e.innerText;
                    return false;
                } 
                return false;
            } else{ 
                e.innerText= "账号填写正确!";  
                e.style.display="block"; 
                if(liulan.indexOf('Firefox')){
                    e.textContent=e.innerText;
                    return true;
                } 
                return true;
            }  
            
        }
      }
      function convertURL(url){
         var timestamp = (new Date()).valueOf();
         //将时间戳拼接到url上
          url=url+"&t="+timestamp;
          return url;
      }
      
   function checkIdenPass(x){
	if(checkPass()){
		return true;
	}else{
	    var showPass=document.getElementById("alpassName");
		showPass.innerText="密码填写不一致";
		var liulan = navigator.userAgent;
		 if(liulan.indexOf('Firefox')){
              showPass.textContent=showPass.innerText;      
        } 
		showPass.style.display="block"; 
		return false;
	}
}

//核对手机号
function checkTele(x){
   var liulan = navigator.userAgent;
   	var teleValue = x.value;
   	var len = strlen(teleValue);
   	var ele = document.getElementById("teleName"); 
   	if(len!=11){ 
   		ele.innerText="手机号长度不对!";
   		if(liulan.indexOf('Firefox')){
              ele.textContent=ele.innerText;      
        }
   		ele.style.display="block";
   		return false;
   	}
    //判断是否是数字
   	var flag = true;
    for(var i=0;i<teleValue.length;i++){
    	var ss = teleValue.charAt(i);
    	var n = parseInt(ss); 
    	if(isNaN(n)){
    		ele.innerText="要求填写的要都是数字";
    		if(liulan.indexOf('Firefox')){
              ele.textContent=ele.innerText;      
             }
    		ele.style.display="block";
    		flag = false;
    		break;
    	} 
    }
    return flag;
}

//核对邮箱
function checkEmail(x){
    var liulan = navigator.userAgent;
	var emailX = x.value; 
	var ele = document.getElementById("emailName");
	var emailpattern=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/; 
    if(!emailpattern.test(emailX)){ 
		ele.innerText="电子邮箱格式不正确";
		if(liulan.indexOf('Firefox')){
              ele.textContent=ele.innerText;      
         }
		ele.style.display="block";
		return false;
	}else{
		return true;
	} 
}


      
  </script>