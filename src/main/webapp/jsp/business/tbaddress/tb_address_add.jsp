<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>


<%@ include file="/jsp/commons/edit.jspf"%>

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
                                           添加收货地址
         </h4>
      </div>
      <div class="modal-body">
           <form class="form-horizontal" action="${ctx}/tbaddress/tbAddressController/edit.do" role="form" name="Form" id="addForm" method="post">
           	 <input type="hidden" name="F_ADDRESS_UID" id="F_ADDRESS_UID" value="${pd.F_ADDRESS_UID}"/>
		  
		 
					       <div class="form-group">
						          <label class="col-sm-2 control-label">地区:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_DIQU"  name="F_DIQU"  value="${pd.F_DIQU}"  placeholder="请填写地区" title="地区">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">用户账号:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_USER_ID"  name="F_USER_ID"  value="${pd.F_USER_ID}"  placeholder="请填写用户账号" title="用户账号">
						          </div>  
						       </div>
						       
						 <div class="form-group" >
							  <label class="col-sm-2 control-label no-padding-right">
									城市：<span class="required-indicator">*</span>
								</label>
								<div class="col-sm-2" >
									 <select  datatype="*" nullmsg = "请选择所在的省！"  style="width: 150px;border:1px solid #ddd;" name="PROVINCE" id="PROVINCE" fieldname="F_PROVINCE"  class="col-xs-11 col-sm-11" onchange="checkProvince(this)" >
									 <!-- <option>&nbsp;&nbsp;选择省&nbsp;&nbsp;</option>  -->
									 </select>
								</div>
								<div class="col-sm-2"  >
									 <select  datatype="*" nullmsg = "请选择所在的地级市！"  style="width: 150px;border:1px solid #ddd;overflow-y:scroll;" name="CITY" id="CITY"  fieldname="F_CITY"  class="col-xs-11 col-sm-11" onchange="checkCity(this);">
									   <option  >&nbsp;&nbsp;&nbsp;&nbsp;地级市&nbsp;&nbsp;</option>
									 </select>
								</div>
								<div class="col-sm-2"  >
									 <select  datatype="*" nullmsg = "请选择所在的市、县、区！"  style="width: 150px;border:1px solid #ddd;overflow-y:scroll;"  name="DISTRICT" id="CONTRY" fieldname="F_DISTRICT" onchange="checkContry(this);" class="col-xs-11 col-sm-11" >
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
					       <div class="form-group">
						          <label class="col-sm-2 control-label">创建时间:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="CREATE_DATE"  name="CREATE_DATE"  value="${pd.CREATE_DATE}"  placeholder="请填写创建时间" title="创建时间">
						          </div>  
						       </div>
             
	       <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">
				          图片上传&nbsp;
				</label> 
				<!--  <div class="col-sm-9">
					<span style="margin:4px auto;" class="btn  btn-white btn-default btn-round " onclick="selectFile(this);" file_type="10901" >
						<i class="ace-icon fa fa-cloud-upload bigger-100"></i>
							附件上传
					</span>
						<form class="form-inline"  id="queryForm1" width="100%"
					   role="form" style="border:solid 1px #ddd;height:50px;line-height:50px;vertical-align:middle;"></form>
					<table  role="presentation" class="table table-striped">
						<tbody showType="width:120px;height:120px;quanxian:true;heightss:160px;heights:40px;del:true;attr:multi;preview:false" class="files showFileTab" data-toggle="modal-gallery" data-target="#modal-gallery"  file_type="10901"></tbody>
					</table>
				</div>-->
				<div class="col-sm-9">
				     <div id="wrapper">
							<div id="container"> 
								<div id="uploader">
									<div class="queueList">
										<div id="dndArea" class="placeholder">
											<div id="filePicker"></div>
											<p>或将照片拖到这里，单次最多可选300张</p>
										</div>
									</div>
									<div class="statusBar" style="display: none;">
										<div class="progress">
											<span class="text">0%</span> <span class="percentage"></span>
										</div>
										<div class="info"></div>
										<div class="btns">
											<div id="filePicker2"></div>
											<div class="uploadBtn">开始上传</div>
										</div>
									</div>
								</div>
							</div> 
						</div>
				 </div>
		 </div>
		 
	   
    </form>
    
      <div class="row">
		      <label class="col-sm-2 control-label">图片:</label>
		       <div class="col-sm-9"  id="pictures">
		          
		      </div>
		 </div> 
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         <button type="button" class="btn btn-primary" onclick="save()">
            提交更改
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>
 
 
 <script type="text/javascript">
	 var form;
	 $(function(){ 
		 form = FormValid.validbyFormId("#addForm");  
		 $("#PROVINCE").empty();
		 $("#PROVINCE").append("<option>&nbsp;&nbsp;选择省&nbsp;&nbsp;</option>");
		 initSelect($("#PROVINCE"),"");
	 });

	 function checkProvince(obj){ 
		 console.info(obj);
         var selectVal = $(obj).val();
         console.info(selectVal); 
         $("#CITY").empty();
         $("#CITY").append("<option>&nbsp;&nbsp;&nbsp;&nbsp;地级市&nbsp;&nbsp;</option>");
         initSelect($("#CITY"),selectVal);
         $("#CONTRY").empty();
         $("#CONTRY").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;市、县、区&nbsp;&nbsp;</option>");
         
	 }

	 function checkCity(obj){ 
         var selectVal = $(obj).val();
         console.info(selectVal);
         $("#CONTRY").empty();
         $("#CONTRY").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;市、县、区&nbsp;&nbsp;</option>");
         initSelect($("#CONTRY"),selectVal);
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


	 
  
	  $("#CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
     
	 function deletePic(PICTURES_ID,table,table_uid_value){
		
		$.ajax({
			url : "${ctx}/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
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
	function save(){
		  
		if(form.check()){
			$.ajax({
				url : "${ctx}/tbaddress/tbAddressController/save.do",
				data : $("#addForm").serialize(),
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					 console.info(typeof response);
					 if(!response.iserror){
						xAlert("信息提示","上传成功",1);
						$("#editClose").click();
						$("#INDEX_Form").submit();
					} 
				}
			});  
		} 
	}
	 
 
 </script>
