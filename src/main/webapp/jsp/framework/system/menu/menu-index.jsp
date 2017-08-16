<!DOCTYPE html>
<html>

	<head>
		<%@ page language="java" pageEncoding="UTF-8"%>
		<%@ include file="/jsp/framework/common/taglibs.jsp"%>
		<%@ taglib uri="/tld/base.tld" prefix="app"%>
		<title><fmt:message key="ui.title" /></title>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath }/assets/sys_resources/plugins/zTree/css/zTreeStyle/zTreeStyle.css"
			type="text/css">
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/assets/sys_resources/plugins/zTree/js/jquery.ztree.all-3.5.min.js"></script>

		<style>
#addHeight {
	height: 510px;
}

#btnDiv {
	float: right;
	margin-top: 25px;
	margin-bottom: 0px;
	margian-left: 500px;
	margin-right: 30px;
}

ul.ztree {
	margin-top: 0px;
	border: 1px solid #617775;
	background: #f0f6e4;
	width: 250px;
	height: 400px;
	overflow-y: scroll;
	overflow-x: auto;
}

/* 添加 部门 按钮   #btnPeople*/
.addclass {
	margin: 0;
	margin-left: -7px;
}

.addcss {
	margin: 0;
	margin-left: 12px;
}

.selTop {
	margin: 0;
	margin-left: -18px;
}

.selBom {
	margin: 0;
	margin-left: -30px;
}

/*去除背景蓝条**/
a:hover {
	background-color: white;
	background-image: none;
}

.btn-sm {
	border-width: 4px;
	font-size: 10px;
	padding: 4px 9px;
	line-height: 1.39;
}

div#rMenu {
	position: absolute;
	visibility: hidden;
	top: 0;
	background-color: #555;
	text-align: left;
	padding: 2px;
}

div#rMenu ul li {
	margin: 1px 0;
	padding: 0 5px;
	cursor: pointer;
	list-style: none outside none;
	background-color: #DFDFDF;
}
</style>
	</head>

	<body class="no-skin">
		<div class="main-container" id="main-container">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->
						<div class="row">
							<div class="col-sm-3">
								<div class="widget-box">
									<div class="widget-header header-color-blue2">
										<h4 class="lighter smaller">
											菜单管理
										</h4>

									</div>
									<div class="widget-body">
										<!-- 设置style 显示 间隔  "-->
										<div class="widget-main padding-8"
											style="height: 100%; width: 100%;">
											<ul id="menuTree" class="ztree">
												<img alt="请稍后，正在加载数据……"
													src="${pageContext.request.contextPath }/assets/img/loading.gif" />
											</ul>
										</div>

										<!-- 右键菜单 -->
										<div id="rMenu">
											<ul>
												<li id="m_add" onclick="addMenu();">
													增加菜单
												</li>
												<li id="m_fresh" onclick="freshMenu()">
													刷新
												</li>
												<li id="m_reset" onclick="updateMenu();">
													修改菜单
												</li>
												<li id="m_del" onclick="deleteMenu();">
													删除节点
												</li>
												<li id="m_addPage" onclick="addPageResource();">
													增加按钮节点
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="col-sm-9">
								<div class="widget-box" id="addHeight">
									<div class="modal-body" id="commpanyBox">

										<form method="post" class="form-horizontal" id="queryForm">
											<input type="hidden" fieldname="LEVELNO" id="LEVELNO"
												name="LEVELNO" />
											<!--可以再此处加入hidden域作为过滤条件 -->

											<!-- 
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													所属应用系统：
												</label>
												<div class="col-sm-8">
													<select id="APP_NAME" name="APP_NAME" fieldname="APP_NAME"
														kind="dic" src="APP_NAME"></select>
												</div>
											</div>  -->

											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													菜单别名（英文、数字）：
												</label>
												<div class="col-sm-8">
													<input type="text" id="NAME" name="NAME" fieldname="NAME" style="width: 80%;">
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													菜单标题（汉字）：
												</label>
												<div class="col-sm-8">
													<input type="text" id="TITLE" name="TITLE"
														fieldname="TITLE"  style="width: 80%;"/>
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													父级菜单编码：
												</label>
												<div class="col-sm-8">
													<input type="text" id="PARENT" name="PARENT"
														fieldname="PARENT" style="width: 80%;">
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													显示顺序号：
												</label>
												<div class="col-sm-8">
													<input type="text" id="ORDERNO" name="ORDERNO"
														fieldname="ORDERNO" style="width: 80%;">
												</div>
											</div>
											<!--  
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													页面显示区域：
												</label>
												<div class="col-sm-8">
													<select id="TARGET" name="TARGET" fieldname="TARGET"
														kind="dic" src="YMXSQY"></select>
												</div>
											</div>
												-->
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">
													页面web路径：
												</label>
												<div class="col-sm-8">
													<input type="text" id="LOCATION" name="LOCATION"
														fieldname="LOCATION" style="width: 80%;">
												</div>
											</div>
										</form>
										<form method="post" id="queryPageResourceForm"
											style="display: none;">
											<input type="hidden" id="PAGE_ID"
												fieldname="FS_PAGE_RESOURCE_ID" name="FS_PAGE_RESOURCE_ID" />
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right">
													资源名称：
												</label>
												<div class="col-sm-9">
													<input id="PAGE_NAME" type="text" fieldname="NAME"
														name="NAME" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right">
													资源定位符：
												</label>
												<div class="col-sm-9">
													<input id="PAGE_URL" type="text" fieldname="URL" name="URL" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right">
													父级对象：
												</label>
												<div class="col-sm-9">
													<input id="PAGE_PARENT" type="text" fieldname="PARENT"
														name="PARENT" disabled />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right">
													资源描述：
												</label>
												<div class="col-sm-9">
													<textarea rows="2" id="PAGE_MEMO" check-type="maxlength"
														maxlength="4000" fieldname="MEMO" name="MEMO"></textarea>
												</div>
											</div>
										</form>
									</div>

									<!-- 部门节点 -->

									<!--人员节点 -->

									<div id="btnDiv">
										<h5>
											<span>
												<button id="btnDel" class="btn btn-primary btn-sm"
													type="button">
													删除
												</button> &nbsp;&nbsp;&nbsp;&nbsp;
												<button id="btnSave" class="btn btn-primary btn-sm"
													type="button">
													保存
												</button> </span>
										</h5>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="dept-input" class="modal"></div>
		<div id="sjjUser-input" class="modal"></div>

		<form method="post" id="queryFormById">
			<table class="B-table" width="100%">
				<!--可以再此处加入hidden域作为过滤条件 -->
				<TR style="display: none;">
					<TD class="right-border bottom-border">
						<INPUT type="text" kind="text" id="QUD" fieldname="ORGANIZE_UID"
							value="" operation="=" />
						<!-- 	<input type="hidden" name="resultXML" id="resultXML"/> -->
					</TD>
					<TD class="right-border bottom-border">
					</TD>
				</TR>
			</table>
		</form>

		<script type="text/javascript"
			src="${pageContext.request.contextPath }/assets/sys_resources/js/common/Form2Json.js">
		</script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/assets/sys_resources/js/common/convertJson.js">
		</script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/assets/sys_resources/js/common/default.js?version=20131206">
		</script>

		<script type="text/javascript">
			function caozuoFun(obj){
				var status=obj.SFYX;
				var showHtml="";
				if(status=='1'){
					showHtml +="<span class='btn btn-link' id='addSpan' onclick='addRoles(this);'  >";
					showHtml +="角色 ";
					showHtml +="</span>&nbsp;&nbsp;";
					showHtml +="<span class='btn btn-link' id='addSpan' onclick='addUsers(this);'  >";
					showHtml +="用户 ";
					showHtml +="</span>";
				}
				
				return showHtml;
			}
			
			function addRoles(obj){
				while(obj.tagName.toLowerCase() != "tr"){
				    obj = obj.parentNode;
				    if(obj.tagName.toLowerCase() == "table")return null;
				   }
				obj.click();
				var data = $("#DT2").getSelectedRow();
				var tempJson = convertJson.string2json1(data);
				var fs_page_resource_id=tempJson.FS_PAGE_RESOURCE_ID;
				$(window).manhuaDialog({"title":"按钮菜单>添加到角色","type":"text","content":"${pageContext.request.contextPath }/jsp/framework/system/menu/pageResourceToRoles.jsp?fs_page_resource_id="+fs_page_resource_id,"modal":"4"});
			}
			
			function addUsers(obj){
				while(obj.tagName.toLowerCase() != "tr"){
				    obj = obj.parentNode;
				    if(obj.tagName.toLowerCase() == "table")return null;
				   }
				obj.click();
				var data = $("#DT2").getSelectedRow();
				var tempJson = convertJson.string2json1(data);	
				var fs_page_resource_id=tempJson.FS_PAGE_RESOURCE_ID;							 
				$(window).manhuaDialog({"title":"按钮菜单>添加到用户","type":"text","content":"${pageContext.request.contextPath }/jsp/framework/system/menu/pageResourceToUsers.jsp?fs_page_resource_id="+fs_page_resource_id,"modal":"4"});
			}
			
			var controllername= "${pageContext.request.contextPath }/sysMenuController";
			var controllernamePage= "${pageContext.request.contextPath }/pageResourceController";
			var setting = {
				async: {
					enable: true,
					url: controllername + "?getAllMenu",
					autoParam: ["id"],
					dataFilter: function (treeId, parentNode, responseData) {
			            return responseData;
			        }
				},
				view: {
					dblClickExpand: true
				},
				data: {
					simpleData: {
						enable: true,
						idKey: "id",
						pIdKey: "parentId"
					}
				},
				callback: {
					onRightClick  : showMenuValue,
					onClick: showMenuInfo,
					onDblClick: showUserList,
					onAsyncSuccess: function(){zTree.expandAll(true);}
				}
			};
			
			function showMenuInfo(event, treeId, treeNode) {
			    menuTreeJson = treeNode;
			    $("#NAME").val(menuTreeJson.id);
				$("#TITLE").val(menuTreeJson.name);
				$("#PARENT").val(menuTreeJson.parentId);
				$("#TARGET").val(menuTreeJson.target);
				$("#LOCATION").val(menuTreeJson.location);
				$("#ORDERNO").val(menuTreeJson.orderno);
				$("#LEVELNO").val(menuTreeJson.levelno);
				
				$("#APP_NAME").val(menuTreeJson.app_name);
				$("#NAME").attr("readonly", "readonly");
				$("#PARENT").attr("readonly", "readonly");
				
			    $("#queryForm").setFormValues(treeNode);
			    
			    showResouceURL(menuTreeJson.id);
			    
			    $("#DT1").clearResult();
			};
			
			function getQueryDateXw(querydata){
				var json = "{querycondition: {conditions: [" +querydata+" ]},pages:{recordsperpage:10, currentpagenum:1, totalpage:0, countrows:0},orders:[{\"fieldname\":\"parent\",\"order\":\"desc\"}]}";
				return json;
			}
			function showResouceURL(menuid){
				var querycondition = "{\"logic\":\"and\",\"fieldname\":\"PARENT\",\"operation\":\"=\",\"value\":\""+menuid+"\",\"fieldtype\":'',\"fieldformat\":''}";
				var data=getQueryDateXw(querycondition);
				//调用ajax插入
				defaultJson.doQueryJsonList(controllernamePage+"?query", data, DT2);
			}
			
			
			/**
			 * 点击右键时，获取的菜单信息
			 */
			function showMenuValue(event, treeId, treeNode) {
				menuTreeJson = treeNode;
				if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
					// 取消选中节点
					zTree.cancelSelectedNode();
					showRMenu("root", event.clientX, event.clientY);
				} else if (treeNode && !treeNode.noR) {
					// 设置选中节点
					zTree.selectNode(treeNode);
					showRMenu("node", event.clientX, event.clientY);
				}
			}
			function showUserList(event, treeId, treeNode) {
				var data = combineQuery.getQueryCombineData(queryUserForm,frmPost, DT1);
				//调用ajax插入
				defaultJson.doQueryJsonList(controllernamePage+"?queryPageMappingUser&menuKey="+treeNode.id, data, DT1);
			}
			/**
			 * 显示右键按钮
			 * type	 
			 * x	右键时所在的x坐标
			 * y	右键时所在的y坐标
			 */
			function showRMenu(type, x, y) {
				$("#rMenu ul").show();
				if (type=="root") {
					$("#m_add").hide();
					$("#m_fresh").hide();
					$("#m_reset").hide();
					$("#m_del").hide();
				} else {
					var levelno = menuTreeJson.levelno;
			
					if(levelno == 'final'){
						$("#m_add").hide();
						$('#m_addPage').hide();
					}else{
						$('#m_addPage').show();
					}
					
					// 根节点只能添加
					if(levelno == 0) {
						$("#m_add").show();
						$("#m_fresh").show();
						$("#m_reset").hide();
						$("#m_del").hide();
						$("#m_resource").hide();
						$('#m_addPage').hide();
					// 第三层节点不允许再添加
					} else if(levelno == 3) {
						$("#m_add").hide();
						$("#m_fresh").hide();
						$("#m_reset").show();
						$("#m_del").show();
						$("#m_resource").show();
						$('#m_addPage').show();
					// 其他正常
					} else {
						$("#m_add").show();
						$("#m_fresh").hide();
						$("#m_reset").show();
						$("#m_del").hide();
						$("#m_resource").show();
						$('#m_addPage').show();
					}
					if(levelno=='final'){
						$("#m_add").hide();
						$("#m_addPage").hide();
					}
					
				}
				rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
			
				$("body").bind("mousedown", onBodyMouseDown);
			}
			
			/**
			 * 隐藏右键按钮
			 */
			function hideRMenu() {
				if (rMenu) rMenu.css({"visibility": "hidden"});
				$("body").unbind("mousedown", onBodyMouseDown);
			}
			
			function onBodyMouseDown(event) {
				if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
					rMenu.css({"visibility" : "hidden"});
				}
			}
			
			/**
			 * 添加按钮方法
			 */
			function addMenu() {
			//	$("#h4").html("添加菜单");
				hideRMenu();
				$('#valueType').val('MENU');
				$("#queryPageResourceForm").hide();
				$("#queryForm").show();
				$("#PARENT").val(menuTreeJson.id);
				var thisLevel = menuTreeJson.levelno;
				var nextLevel = parseInt(thisLevel)+1;
				$("#LEVELNO").val(nextLevel);
			
				$("#NAME").removeAttr("readonly");
				$("#PARENT").attr("readonly", "readonly");
			
				$("#NAME").val("");
				$("#TITLE").val("");
				$("#TARGET").val("");
				$("#LOCATION").val("");
				
				// 设置操作标识符，1表示添加 
				operatorSign = 1;
			}
			function addPageResource(){
				hideRMenu();
			
				$("#queryPageResourceForm").show();
				$("#queryForm").hide();
				$('#valueType').val('PAGE');
				$("#queryPageResourceForm").show();
				$("#queryForm").hide();
			
				$("#PAGE_PARENT").val(menuTreeJson.id);
			
			
				//$("#NAME").attr("readonly", "readonly");
				$("#PAGE_PARENT").attr("readonly", "readonly");
				operatorSign = 1;
			}
			/**
			 * 修改按钮方法
			 */
			function updateMenu() {
			//	$("#h4").html("修改菜单");
				hideRMenu();
				if(menuTreeJson.levelno=='final'){
					$('#valueType').val('PAGE');
					$("#queryPageResourceForm").show();
					$("#queryForm").hide();
					$("#PAGE_ID").val(menuTreeJson.id);
					$("#PAGE_NAME").val(menuTreeJson.name);
					$("#PAGE_PARENT").val(menuTreeJson.parentId);
					//$("#TARGET").val(menuTreeJson.target);
					$("#PAGE_URL").val(menuTreeJson.location);
					//$("#ORDERNO").val(menuTreeJson.orderno);
					$("#showMO").html('<textarea class="span12" rows="2" id="PAGE_MEMO" check-type="maxlength" maxlength="4000" fieldname="MEMO" name="MEMO">'+menuTreeJson.memo+'</textarea>');
				
					//$("#NAME").attr("readonly", "readonly");
					$("#PAGE_PARENT").attr("readonly", "readonly");
				}else{
					$('#valueType').val('MENU');
					$("#queryPageResourceForm").hide();
					$("#queryForm").show();
					
					$("#NAME").val(menuTreeJson.id);
					$("#TITLE").val(menuTreeJson.name);
					$("#PARENT").val(menuTreeJson.parentId);
					$("#TARGET").val(menuTreeJson.target);
					$("#LOCATION").val(menuTreeJson.location);
					$("#ORDERNO").val(menuTreeJson.orderno);
					$("#LEVELNO").val(menuTreeJson.levelno);
				
					$("#NAME").attr("readonly", "readonly");
					$("#PARENT").attr("readonly", "readonly");
				}
				
				// 设置操作标识符，2表示修改
				operatorSign = 2;
			}
			
			
			function freshMenu() {
				$.fn.zTree.init($("#menuTree"), setting);
				hideRMenu();
			}
			
			//点击保存按钮
			$(function() {
				var saveUserInfoBtn = $("#saveUserInfo");
				saveUserInfoBtn.click(function() {
					if(!operatorSign) {
						//xAlert("提示信息","请选择一个父节点进行添加");
						xInfoMsg("请选择一个父节点进行添加","");
						return;
					}
			 		if(sign == 1) {
						 //xAlert("提示信息","登录用户名重复，请重新填写");
						 xInfoMsg("登录用户名重复，请重新填写","");
						 return;
					}
					var type =  $('#valueType').val();
			
			 		if(type=='PAGE'){
			 			if($("#queryPageResourceForm").validationButton()) {
			 				//生成json串
			 				var data = Form2Json.formToJSON(queryPageResourceForm);
			 				//组成保存json串格式
			 				var data1 = defaultJson.packSaveJson(data);
			 				//通过判断id是否为空来判断是插入还是修改
			 				
			 				var success = false;
			 				if(operatorSign == 1) {
			 					success = defaultJson.doInsertJson(controllernamePage + "?insert", data1, null);
			 				} else if(operatorSign == 2) {
			 					success = defaultJson.doUpdateJson(controllernamePage + "?update", data1, null);
			 				}
			 				$.fn.zTree.init($("#menuTree"), setting);
			 			}
			 	 	}else if(type=='MENU'){
			 	 		if($("#queryForm").validationButton()) {
			 				//生成json串
			 				var data = Form2Json.formToJSON(queryForm);
			 				//组成保存json串格式
			 				var data1 = defaultJson.packSaveJson(data);
			 				//通过判断id是否为空来判断是插入还是修改
			 				
			 				var success = false;
			 				if(operatorSign == 1) {
			 					success = defaultJson.doInsertJson(controllername + "?executeMenu&operatorSign=" + operatorSign, data1, null);
			 				} else if(operatorSign == 2) {
			 					success = defaultJson.doUpdateJson(controllername + "?executeMenu&operatorSign=" + operatorSign, data1, null);
			 				}
			 				$.fn.zTree.init($("#menuTree"), setting);
			 			}
			 	 	}
				});
			});
			
			// 检测菜单信息是否重复
			var sign;
			$(function() {
				var menuName = $("#NAME");
				menuName.blur(function() {
					$.ajax({
						url : controllername+"?queryUnique&menuName="+menuName.val(),
						cache : false,
						async : false,
						dataType : 'json',
						success : function(response) {
							var result = eval("(" + response + ")");
							// 设置添加时得校验标识，1表示数据重复
							sign = result.sign;
							//xAlert("提示信息", result.isUnique);
							xInfoMsg(result.isUnique,"");
						}
					});
				});
				var pageMenuURL = $("#PAGE_URL");
				pageMenuURL.blur(function() {
					$.ajax({
						url : controllernamePage+"?queryUnique&menuName="+pageMenuURL.val()+":"+$("#PAGE_ID").val(),
						cache : false,
						async : false,
						dataType : 'json',
						success : function(response) {
							var result = eval("(" + response + ")");
							// 设置添加时得校验标识，1表示数据重复
							sign = result.sign;
							//xAlert("提示信息", result.isUnique);
							xInfoMsg(result.isUnique,"");
						}
					});
				});
			});
			
			var zTree,rMenu,menuTreeJson,operatorSign;
			$(document).ready(function() {
				$.fn.zTree.init($("#menuTree"), setting);
				zTree = $.fn.zTree.getZTreeObj("menuTree");
				$("#menuTree").css("height",document.documentElement.clientHeight-50);
			
				rMenu = $("#rMenu");
			});
		</script>
	</body>

</html>