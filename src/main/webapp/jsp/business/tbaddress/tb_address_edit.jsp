<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>

 <%
String rootFile = request.getScheme()+"://"+request.getServerName()+":8088/file";
String rootFileApp = request.getScheme()+"://"+request.getServerName()+":8088/app"; 

%>


<div class="container">
<div class="modal-dialog"  tabindex="-1" role="dialog" style="width:80%">
   <div class="modal-content">
      <div class="modal-header">
         <button type="button" class="close"
            data-dismiss="modal" aria-hidden="true">
               &times;
         </button>
         <h4 class="modal-title" id="myModalLabel">
                                             编辑收货地址
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbaddress/tbAddressController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_ADDRESS_UID" id="F_ADDRESS_UID" value="${pd.F_ADDRESS_UID}"/>
		     <input type="hidden" class="form-control" id="F_USER_ID"  name="F_USER_ID"  value="${pd.F_USER_ID}"  placeholder="请填写用户账号" title="用户账号">
		      
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_UserName"  name="F_UserName"  value="${pd.F_UserName}"  placeholder="请填写用户账号" title="用户账号">
						          </div>  
						       </div>
						       
						    
						     <div class="form-group" >
							  <label class="col-sm-2 control-label no-padding-right">
									城市：<span class="required-indicator">*</span>
								</label>
								<div class="col-sm-2" >
									 <select  datatype="*" nullmsg = "请选择所在的省！"  style="width: 150px;border:1px solid #ddd;" name="F_PROVINCE" id="F_PROVINCE" fieldname="F_PROVINCE"  class="col-xs-11 col-sm-11" onchange="checkProvince(this)" >
									 <!-- <option>&nbsp;&nbsp;选择省&nbsp;&nbsp;</option>  -->
									 </select>
								</div>
								<div class="col-sm-2"  >
									 <select  datatype="*" nullmsg = "请选择所在的地级市！"  style="width: 150px;border:1px solid #ddd;overflow-y:scroll;" name="F_CITY" id="F_CITY"  fieldname="F_CITY"  class="col-xs-11 col-sm-11" onchange="checkCity(this);">
									   <option  >&nbsp;&nbsp;&nbsp;&nbsp;地级市&nbsp;&nbsp;</option>
									 </select>
								</div>
								<div class="col-sm-2"  >
									 <select  datatype="*" nullmsg = "请选择所在的市、县、区！"  style="width: 150px;border:1px solid #ddd;overflow-y:scroll;"  name="F_DISTRICT" id="F_DISTRICT" fieldname="F_DISTRICT" onchange="checkContry(this);" class="col-xs-11 col-sm-11" >
									  <option value="" >&nbsp;&nbsp;&nbsp;&nbsp;市、县、区&nbsp;&nbsp;</option>
									 </select>
								</div>
						    </div>
						       
					       <div class="form-group">
						          <label class="col-sm-2 control-label">详细地址:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_ADDRESS_DETAIL"  name="F_ADDRESS_DETAIL"  value="${pd.F_ADDRESS_DETAIL}"  placeholder="请填写详细地址" title="详细地址">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">邮政编码:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_POSTAL_CODE"  name="F_POSTAL_CODE"  value="${pd.F_POSTAL_CODE}"  placeholder="请填写邮政编码" title="邮政编码">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">收件人:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_RECEIVE_NAME"  name="F_RECEIVE_NAME"  value="${pd.F_RECEIVE_NAME}"  placeholder="请填写收件人" title="收件人">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">手机号:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_RECEIVE_MOBILE"  name="F_RECEIVE_MOBILE"  value="${pd.F_RECEIVE_MOBILE}"  placeholder="请填写手机号" title="手机号">
						          </div>  
						       </div>
						     
						 
    </form>
     
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button> 
         <button type="button" class="btn btn-primary" onclick="update()">
                                            保存
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>
 
 
 <script type="text/javascript">
 
 $(function(){ 

	 $("#PROVINCE").empty();
	 $("#PROVINCE").append("<option>&nbsp;&nbsp;选择省&nbsp;&nbsp;</option>");
	 initSelect($("#F_PROVINCE"),"");
	 
	 init();
	 
	  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     }); 
 });

 function checkProvince(obj){ 
	 console.info(obj);
     var selectVal = $(obj).val();
     console.info(selectVal); 
     $("#F_CITY").empty();
     $("#F_CITY").append("<option>&nbsp;&nbsp;&nbsp;&nbsp;地级市&nbsp;&nbsp;</option>");
     initSelect($("#F_CITY"),selectVal);
     $("#F_DISTRICT").empty();
     $("#F_DISTRICT").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;市、县、区&nbsp;&nbsp;</option>");
     
 }

 function checkCity(obj){ 
     var selectVal = $(obj).val();
     console.info(selectVal);
     $("#F_DISTRICT").empty();
     $("#F_DISTRICT").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;市、县、区&nbsp;&nbsp;</option>");
     initSelect($("#F_DISTRICT"),selectVal);
 }

 function checkContry(obj){
 }
 

 function initSelect(selectObj,REGION_CODE){
	 $.ajax({
			url : "${ctx}/sysregion/sysRegionController/getInfoByRegionCode.do",
			data : {REGION_CODE:REGION_CODE},
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				var data = response.data;
				console.info(data); 
				data.forEach(function(ele,index){
					selectObj.append("<option value='"+ele.REGION_CODE+"'>"+ele.REGION_NAME+"</option>");   
				});
			}
		}); 
 }

 
 
 function init(){ 
		var data1={F_ADDRESS_UID:'${pd.F_ADDRESS_UID}'};
		$.ajax({
			url : "${ctx}/tbaddress/tbAddressController/goEdit.do",
			data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				var product = response;
				setValue(product);
			}
		});  
	}
   
	
	function setValue(obj){  
		        console.info(obj);
			     $("#F_DIQU").val(obj.F_DIQU); 
			     $("#F_USER_ID").val(obj.F_USER_ID); 
			     $("#F_UserName").val(obj.F_UserName); 
			     $("#F_ADDRESS_DETAIL").val(obj.F_ADDRESS_DETAIL); 
			     $("#F_POSTAL_CODE").val(obj.F_POSTAL_CODE); 
			     $("#F_RECEIVE_NAME").val(obj.F_RECEIVE_NAME); 
			     $("#F_RECEIVE_MOBILE").val(obj.F_RECEIVE_MOBILE); 
			     $("#CREATE_DATE").val(obj.CREATE_DATE);  


			     
			     $("#F_PROVINCE").val(obj.F_PROVINCE);
			     $("#F_PROVINCE").change();
			     
			     $("#F_CITY").val(obj.F_CITY);
			     $("#F_CITY").change();
			     
			     $("#F_DISTRICT").val(obj.F_DISTRICT); 
			   
    }
  
	//update
	function update(){
		 
		$.ajax({
			url : "${ctx}/tbaddress/tbAddressController/edit.do",
			data : $("#editForm").serialize(),
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				 console.info(typeof response);
				 if(!response.iserror){
					xAlert("信息提示","保存成功",1);
					$("#editClose").click();
					$("#INDEX_Form").submit();
				} 
			}
		});  
		 
	}
	 
 
 </script>
