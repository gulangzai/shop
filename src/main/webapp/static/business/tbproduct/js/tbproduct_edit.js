var form; 
$(function(){ 
	 
	 $("input[name='F_ISSPECIAL_label']").change(function(){ 
		 $("#F_IsSpecial").val($(this).val());
	 });
	 $("input[name='F_Status_label']").change(function(){ 
		 $("#F_Status").val($(this).val());
	 });
	 
	 init();
	 form = FormValid.validbyFormId("#editForm"); 
 });
 
 function init(){  
		var data1={F_PRODUCT_ID: $("#F_PRODUCT_ID").val()};
		$.ajax({
			url : ctx+"/tbProductController/goEdit.do",
			data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response); 
				var product = response;
				setValue(product);
			}
		});  
	}
 
   
   
	
	//添加规格
	function addStandard(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = "添加规格";
		 diag.URL = ctx+"/standard/goAdd.do";
		 diag.Width = 480;
		 diag.Height = 370;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.OKEvent = function(){  
			 var nameObj = $(diag.innerFrame.contentWindow.document.getElementById('F_STANDARDNAME'));
			 var standardName =  diag.innerFrame.contentWindow.document.getElementById('F_STANDARDNAME').value;
			 var standardValue =  diag.innerFrame.contentWindow.document.getElementById('F_STANDARDVALUE').value;
			 var xuhao =  diag.innerFrame.contentWindow.document.getElementById('F_XUHAO').value;
			 if(diag.innerFrame.contentWindow.mysave()){
				 var $tr= $("<tr></tr");
					$tr
					.append($("<td></td>").append($("<input type='text' name='F_XUHAO[]'>").val(xuhao)))
					.append($("<td></td>").append($("<input type='text' name='F_StandardName[]'>").val(standardName)))
					.append($("<td></td>").append($("<input type='text' name='F_StandardValue[]'>").val(standardValue))); 
					diag.close();
					$(".guige").append($tr);
			 }
			/* if(nameObj.val()==""){
					nameObj.tips({
						side:3,
			            msg:'请输入规格名',
			            bg:'#AE81FF',
			            time:2
			        });
					nameObj.focus();
					return false;
				}
			 
			 if(standardName!=''){ 
				var $tr= $("<tr></tr");
				$tr
				.append($("<td></td>").append($("<input type='text' name='F_XUHAO[]'>").val(xuhao)))
				.append($("<td></td>").append($("<input type='text' name='F_StandardName[]'>").val(standardName)))
				.append($("<td></td>").append($("<input type='text' name='F_StandardValue[]'>").val(standardValue))); 
				diag.close();
				$(".guige").append($tr);
			 }  */
		 };
		 //点击确定后调用的方法
		 diag.show();
	}
	
	
	function setValue(product){
	    $("#F_CLSID").val(product.F_CLSID);
		$("#F_CLSNAME").val(product.F_CLSNAME);
		
		if(product.F_ISSPECIAL=='0'){
			$("#F_ISSPECIAL_label0").attr("checked",'true');
			$("#F_IsSpecial").val("0");
		}else{
			$("#F_ISSPECIAL_label1").attr("checked",'true');
			$("#F_IsSpecial").val("1");
		} 
		
		if(product.F_Status=='0'){
			$("#F_Status_label0").attr("checked",'true');
			$("#F_Status").val("0");
		}else{
			$("#F_Status_label1").attr("checked",'true');
			$("#F_Status").val("1");
		} 
		
		$("#F_PRICE").val(product.F_PRICE);
		$("#F_SHOW_PRICE").val(product.F_SHOW_PRICE);
		$("#F_PRODUCTDESC").text(product.F_PRODUCTDESC);
		$("#F_PRODUCTNAME").val(product.F_PRODUCTNAME);
		$("#F_PRODUCT_ID").val(product.F_PRODUCT_ID); 
		$("#F_REAL_PRICE").val(product.F_REAL_PRICE);
		$("#F_Number").val(product.F_Number);
		$("#F_Express").val(product.F_Express);
		$("#F_PATH1").val(product.F_PATH1);
		$("#F_PATH2").val(product.F_PATH2);
		$("#F_PATH3").val(product.F_PATH3);
		$("#F_PATH4").val(product.F_PATH4); 
		
		getPicFile("TB_PRODUCT",product.F_PRODUCT_ID);
    }
	
	function getPicFile(table,table_uid_value){
		$.ajax({
			url : ctx+"/tbPicturesController/getPicture.do?TABLE="+table+"&TABLE_UID_VALUE="+table_uid_value,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				$("#pictures").empty();
				response.forEach(function(ele,index){
					$("#pictures")
					.append($('<div class="col-sm-4" id="'+ele.PICTURES_ID+'"><img src="'+ele.PATH+'"  width="100%" height="180px"><p><button class="btn btn-default"  onclick="deletePic(\''+ele.PICTURES_ID+'\',\''+table+'\',\''+table_uid_value+'\')">x</button></p></div>')); 
					$("#editForm").append($('<input type="hidden" name="PICTURES_ID" id="'+ele.PICTURES_ID+'_input"  value="'+ele.PICTURES_ID+'"/>'));
				});
				
			}
		});  
	}
	
	function deletePic(PICTURES_ID,table,table_uid_value){
		
		$.ajax({
			url : ctx+"/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				if(!response.iserror){
					if(table_uid_value!=''&&table_uid_value!='undefined'){
						//getPicFile(table,table_uid_value);
					}else{
						
					} 
					var pic = "#"+PICTURES_ID; 
					$(pic).remove(); 
					//<input type="hidden" name="PICTURES_ID" id="PICTURES_ID" />
					var p_input = "#"+PICTURES_ID+"_input";
					console.info($(p_input));
					//$("#editForm").remove($(p_input));
					$(p_input).remove();
					
				} 
				
			}
		});  
	}
	
	//保存
	function editUpdate(){ 
		if(form.check()){	
			$.ajax({
				url : ctx+"/tbProductController/edit.do",
				data : $("#editForm").serialize(),
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					 console.info(typeof response);
					 if(!response.iserror){
						 xAlert("信息提示","上传成功",1);
						$("#editClose").click();
						reload();
					} 
				}
			}); 
		}
		 
	}
	
	
	$("#selectClassTree").click(function(){
		   classTree();
     });
	 
	 
    //选择类型树
	function classTree(){ 
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = "菜单权限";
		 diag.URL = ctx+"/goodClass/classTree.do";
		 diag.Width = 280;
		 diag.Height = 370;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.OKEvent = function(){  
			 var fClsId =  diag.innerFrame.contentWindow.document.getElementById('choseClassId').value;
			 var choseClassName =  diag.innerFrame.contentWindow.document.getElementById('choseClassName').value;
 
			if(fClsId==''){
				alert("请选择一个类型");
			 } else{ 
				$("#F_CLSID").val(fClsId); 
				$("#F_CLSNAME").val(choseClassName);
				diag.close();
			 }   
		 };
		 //点击确定后调用的方法
		 diag.show();
	}
		