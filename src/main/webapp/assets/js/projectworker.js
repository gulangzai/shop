
/*
	function sleep(numberMillis) { 
		var now = new Date(); 
		var exitTime = now.getTime() + numberMillis; 
		while (true) { 
			now = new Date(); 
			if (now.getTime() > exitTime) 
			return; 
		} 
	}
	*/
	
		var data = new Object();
			
		var checkcount = 0;
		function checkdata(){
			
			checkcount = checkcount+1;
			//console.log(checkcount);
			
			if (checkcount > 60)
			{
				//console.log(data.G_ProjectUID);
				//console.log(data.G_Points);
				//console.log(data.G_Items);
				//console.log(data.G_Item_Types);
				//console.log(data.G_Points_Items);
				//console.log(data.G_PointProperties);
				//console.log(data.G_PointData_jc);
				//console.log(data.G_PointData_cx);
				//console.log(data.G_User_Focus_Points);
				console.log("获取项目数据时间过长，已退出！");
				
				postMessage( null );
				
				return;
			}

			if (data.G_ProjectUID == null 
				|| data.G_Points == null
				|| data.G_Items == null
				|| data.G_Item_Types == null
				|| data.G_Points_Items == null
				|| data.G_PointProperties == null
				|| data.G_PointData_jc == null
				|| data.G_PointData_cx == null
				|| data.G_User_Focus_Points == null
			)
			{
				/*
				sleep(5);
				count++;
				*/
				setTimeout(checkdata, 1000);
			}
			else
			{
				//console.log(data.G_ProjectUID);
				//console.log(data.G_Points);
				//console.log(data.G_Items);
				//console.log(data.G_Item_Types);
				//console.log(data.G_Points_Items);
				//console.log(data.G_PointProperties);
				//console.log(data.G_PointData_jc);
				//console.log(data.G_PointData_cx);
				//console.log(data.G_User_Focus_Points);

				calcretdata();
			}
		}

		function getdata(baseurl, projectid){
			
			data.G_ProjectUID = projectid;
			
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryPoints",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_Points = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryPoints&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_Points = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
			
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryItems",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_Items = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryItems&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_Items = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
			
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryItemTypes",
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_Item_Types = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryItemTypes";
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_Item_Types = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
	
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryPoint_Item",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_Points_Items = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryPoint_Item&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_Points_Items = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
			
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryPointProperty",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_PointProperties = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryPointProperty&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_PointProperties = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
	
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryPointData_jc",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_PointData_jc = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryPointData_jc&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_PointData_jc = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
	
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryPointData_cx",
				data:{"project_uid":projectid},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_PointData_cx = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryPointData_cx&project_uid=" + projectid;
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_PointData_cx = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}
			
			{
				/*
				$.ajax({
				url:baseurl + "/jkjc/jcPrjPointsController?queryUser_Focus_Point",
				data:{},
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(result){
	    			data.G_User_Focus_Points = result.obj;
				}
				}); 
				*/
				var worker =new Worker("ajaxworker.js");
				var message = baseurl + "/jkjc/jcPrjPointsController?queryUser_Focus_Point";
				
				worker.onmessage =function(evt){
					//console.log(evt.data);
					
					data.G_User_Focus_Points = evt.data == null ? evt.data : evt.data.obj;
				}
				worker.postMessage(message);
			}

			checkdata();
					
	}

	function calcretdata()
	{
		//生成data.G_Points_Items_All
		data.G_Points_Items_All = new Array();
		for (var i = 0 ; i < data.G_Points_Items.PRJ_POINT_ITEM_UID.length ; i++)
		{
			var point_item_id=data.G_Points_Items.PRJ_POINT_ITEM_UID[i];
			if (point_item_id == null || point_item_id == "")
			{
				console.log("错误：没有找到测点监测项对应的记录！");
				continue;
			}
			var itemid=data.G_Points_Items.JC_PRJ_ITEM_UID[i];
			if (itemid == null || itemid == "")
			{
				console.log("错误：没有找到监测项对应的记录！");
				continue;
			}
			var pointuid = data.G_Points_Items.PRJ_POINTS_UID[i];
			if (pointuid == null || pointuid == "")
			{
				console.log("错误：没有找到测点对应的记录！");
				continue;
			}
			//获取监测项信息
			var itemtypename=null;
			var itemname=null;
			var itemshortname=null;
			var itemunit=null;
			var itemprecode=null;
			var itemiconfile=null;
			var jctype = null;
			for (var j = 0 ; j < data.G_Items.JC_PRJ_ITEM_UID.length ; j++)
			{
				if (itemid == data.G_Items.JC_PRJ_ITEM_UID[j])
				{
					for (var k = 0 ; k < data.G_Item_Types.JC_TYPE_UID.length ; k++)
					{
						if (data.G_Items.JC_TYPE_UID[j] == data.G_Item_Types.JC_TYPE_UID[k])
						{
							itemtypename = data.G_Item_Types.JC_TYPE_NAME[k];
							break;
						}
					}
					itemname = data.G_Items.JC_NAME[j];
					itemshortname = data.G_Items.SHORT_NAME[j];
					itemunit = data.G_Items.UNIT[j];
					itemprecode = data.G_Items.PRE_CODE[j];
					itemiconfile = data.G_Items.ICON_FILE[j];
					jctype = data.G_Items.JC_TYPE_UID[j];
					break;
				}
			}
			//iconfile有空值跳过
			if(itemiconfile == null && itemiconfile == "")
			{
				console.log("错误：没有找到监测项对应的图标文件！");
				continue;
			}
			//获取测点信息
			var pointelementid = null;
			var pointcode = null;
			var pointinitheight = null;
			for (var j = 0 ; j < data.G_Points.PRJ_POINTS_UID.length ; j++)
			{
				if (pointuid == data.G_Points.PRJ_POINTS_UID[j])
				{
					pointelementid = data.G_Points.U3D_ELEMENT_ID[j];
					pointcode = data.G_Points.POINT_CODE[j];
					pointinitheight = data.G_Points.INIT_HEIGHT[j];
					break;
				}
			}
			
			if (pointcode == null || pointcode == "")
			{
				console.log("错误：没有找到测点对应的测点记录或测点记录有错误！");
				continue;
			}
			var IsFocused=false;
			for (var j = 0 ; j < data.G_User_Focus_Points.PRJ_POINTS_UID.length ; j++)
			{
				if (pointuid == data.G_User_Focus_Points.PRJ_POINTS_UID[j])
				{
					IsFocused = true;
					break;
				}
			}
			//取预警值
			var singlewarn=null;
			var totalwarn1=null;
			var totalwarn2=null;
			for (var j = 0 ; j < data.G_PointProperties.PRJ_POINT_ITEM_UID.length ; j++)
			{
				if (point_item_id == data.G_PointProperties.PRJ_POINT_ITEM_UID[j])
				{
					singlewarn = data.G_PointProperties.SINGLE_WARN[j];
					totalwarn1 = data.G_PointProperties.TOTAL_WARN1[j];
					totalwarn2 = data.G_PointProperties.TOTAL_WARN2[j];
				}
			}
			
			//预警值有空值也跳过
			if(singlewarn == null && singlewarn == "")
			{
				console.log("错误：SINGLE_WARN有空值！");
				continue;
			}
			if(totalwarn1 == null && totalwarn1 == "")
			{
				console.log("错误：TOTAL_WARN1有空值！");
				continue;
			}
			if(totalwarn2 == null && totalwarn2 == "")
			{
				console.log("错误：TOTAL_WARN2有空值！");
				continue;
			}
			//取测点最新数据并判断是否超过预警值
			var reportdate=null;
			var v_value = null;
			var v_value_diff = null;
			var h_value = null;
			var h_value_diff = null;
			var cx_deep = null;
			var cx_value = null;
			var cx_value_diff = null;
			var IsWarning=false;
			var datatype = "沉降";
			var prj_ponits_uid = null;
			if(itemname.indexOf("测斜") >= 0 || itemshortname.indexOf("测斜") >= 0)
			{
				datatype = "测斜";
				cx_deep = new Array();
				cx_value = new Array();
				cx_value_diff = new Array();
				var datacount=0;
				for (var j = 0 ; j < data.G_PointData_cx.PRJ_POINTS_UID.length ; j++)
				{
					if (pointuid == data.G_PointData_cx.PRJ_POINTS_UID[j])
					{
						reportdate = data.G_PointData_cx.REPORT_DATE[j];
						prj_ponits_uid  = data.G_PointData_cx.PRJ_POINTS_UID[j];
						cx_deep[datacount] = data.G_PointData_cx.DEEP[j];
						cx_value[datacount] = data.G_PointData_cx.HORIZONTAL_VALUE[j];
						cx_value_diff[datacount] = data.G_PointData_cx.HORIZONTAL_VALUE_DIFF[j];
						
						if (!IsWarning)
						{
							if (Math.abs(parseFloat(cx_value_diff[datacount])) > parseFloat(singlewarn))
							{
								IsWarning = true;
							}
							var value = parseFloat(cx_value[datacount]);
							if (value < parseFloat(totalwarn1) || value > parseFloat(totalwarn2))
							{
								IsWarning = true;
							}
						}
						datacount++;
					}
				}
				
			}
			else
			{
				for (var j = 0 ; j < data.G_PointData_jc.PRJ_POINTS_UID.length ; j++)
				{
					if (pointuid == data.G_PointData_jc.PRJ_POINTS_UID[j])
					{
						reportdate = data.G_PointData_jc.REPORT_DATE[j];
						prj_ponits_uid  = data.G_PointData_jc.PRJ_POINTS_UID[j];
						if(itemname.indexOf("水平") >= 0 || itemshortname.indexOf("水平") >= 0)
						{
							datatype = "水平";
							h_value = data.G_PointData_jc.HORIZONTAL_VALUE[j];
							h_value_diff = data.G_PointData_jc.HORIZONTAL_VALUE_DIFF[j];

							if (Math.abs(parseFloat(h_value_diff)) > parseFloat(singlewarn))
							{
								IsWarning = true;
							}
							var value = parseFloat(h_value);
							if (value < parseFloat(totalwarn1) || value > parseFloat(totalwarn2))
							{
								IsWarning = true;
							}

						}
						else
						{
							v_value = data.G_PointData_jc.VERTICAL_VALUE[j];
							v_value_diff = data.G_PointData_jc.VERTICAL_VALUE_DIFF[j];

							if (Math.abs(parseFloat(v_value_diff)) > parseFloat(singlewarn))
							{
								IsWarning = true;
							}
							var value = parseFloat(v_value);
							if (value < parseFloat(totalwarn1) || value > parseFloat(totalwarn2))
							{
								IsWarning = true;
							}
						}
						break;
					}
				}
			}
			
			var point_item = new Object();
		    point_item.IsWarning = IsWarning;
		    point_item.IsFocused = IsFocused;
		    point_item.PRJ_POINT_ITEM_UID = point_item_id;
		    point_item.PRJ_POINTS_UID = pointuid;
		    point_item.JC_PRJ_ITEM_UID = itemid;
		    point_item.datatype = datatype;
		    point_item.POINT_CODE = pointcode;
		    point_item.U3D_ELEMENT_ID = pointelementid;
		    point_item.INIT_HEIGHT = pointinitheight;
		    point_item.JC_TYPE_UID = jctype;
		    point_item.JC_TYPE_NAME = itemtypename;
		    point_item.JC_NAME = itemname;
		    point_item.SHORT_NAME = itemshortname;
		    point_item.UNIT = itemunit;
		    point_item.PRE_CODE = itemprecode;
		    point_item.ICON_FILE = itemiconfile;
		    point_item.SINGLE_WARN = singlewarn;
		    point_item.TOTAL_WARN1 = totalwarn1;
		    point_item.TOTAL_WARN2 = totalwarn2;
		    point_item.REPORT_DATE = reportdate;
		    point_item.V_VALUE = v_value;
		    point_item.V_VALUE_DIFF = v_value_diff;
		    point_item.H_VALUE = h_value;
		    point_item.H_VALUE_DIFF = h_value_diff;
		    point_item.CX_DEEP = cx_deep;
		    point_item.CX_VALUE = cx_value;
		    point_item.CX_VALUE_DIFF = cx_value_diff;
		    point_item.REPORT_DATE = reportdate;
		    point_item.POINT_ID = prj_ponits_uid;
		    
		    point_item.ITEM_TYPE = data.G_Points_Items.ITEM_TYPE[i];
		    
		    data.G_Points_Items_All.push(point_item);
		}		

		//console.log(data);
		postMessage( data );
	}
	
	onmessage =function (evt){
		var message = evt.data;
		
		getdata(message.url, message.projectid);
	}