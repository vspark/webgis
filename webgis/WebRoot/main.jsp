
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Expires" content="0" />  
<meta http-equiv="Cache-Control" content="no-cache, no-store" /> 
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>${systemConfig.systemTitle}</title>

<%
   String ApplicationPath = request.getContextPath() ;
   String jsPath = ApplicationPath+"/js";
   String imgPath =  ApplicationPath+"/image";
   
%>
    <!-- GC -->


<!--easyui的主题css-->

	<link rel="stylesheet" type="text/css" href="<%=ApplicationPath%>/js/easyUI/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=ApplicationPath%>/js/easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=ApplicationPath%>/css/jquery.autocomplete.css" />
<style type="text/css"> 
*{
	font-size:12px;
}

body {
    font-family:verdana,helvetica,arial,sans-serif;
    font-size:12px;
    margin:0;
}
.l-topmenu-welcome{position:absolute; height:38px;  right:30px; top:2px;color:#070A0C; border:0px solid red;}
.tree ul li
{
	margin-top:5px;
}

.onlinecar {
	background:url('image/online.png') ;
}
.offlinecar {
	background:url('image/offline.png') ;
}
.parkingcar {
	background:url('image/parking.png') ;
}
.department {
	background:url('image/dep.png') ;
}

.tree-icon
{
	width:25px;
	height:20px;
}
.mylogo
{
   width:350px;
   float:left;
   color: #2477b3;
		font-family: "微藕", Tahoma, sans-serif;
		font-size: 18px;
		font-weight: bold;
}
 </style>
</head>
<body class="easyui-layout"> 
    <div id="pageloading"></div>
    <!-- 标题 -->
	<div data-options="region:'north',border:false" style="height:66px;background:url(<%=imgPath%>/bg.gif) repeat-x scroll 0 100%;padding:1px">
	     <div class="mylogo"><img src="<%=imgPath%>/logo.png"   align="absmiddle" height=63/>${systemConfig.systemTitle}</div>
	     <div id="rightBar" style="float:right;width:900px;">

		    <div class="l-topmenu-welcome" >
				<a class="l-link2">【<span id="LoginName"></span>】</a> 
				<span class="space">|</span>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-psd',plain:true" onclick="openUpdatePasswordWindow();">修改用户密码</a>
				<span class="space">|</span>
				
				<a  class="easyui-linkbutton"  href="<%=ApplicationPath%>/logout.action" data-options="iconCls:'icon-exit',plain:true">退出</a>
			</div> 

			<div id="topMenuContainer"  style="float:right;margin-top:35px;margin-left:20px;width:450px;">
			<div id="topMenu"style="float:right;"> </div>
			</div>
			<div id="menuList"></div>
			<div id="toolbar"  style="float:right;margin-top:35px;margin-left:20px;width:380px;"></div>

	     </div>
	</div><!--end of north-->
	<div data-options="region:'west',split:true" style="width:230px">
		<!-- 车辆左树 -->
	    <div id="treeTab" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
			<div title="车辆列表" style="padding:3px">
			   <div id="p"   style="margin-bottom:5px">	      
					  <select class="easyui-combobox" name="filterType" id="filterType" style="width:80px;" data-options="panelHeight:150,value:'plateNo'"> 
						  <option value="plateNo">车牌号</option>
						  <option value="simNo">Sim卡号</option>
						  <option value="depName">车组名称</option>
						  <option value="driverName">司机姓名</option>
						  <option value="online" >在线车辆</option>
						  <option value="offline" >离线车辆</option>
						  <option value="all" >全部车辆</option>
					  </select>
					  <input id="searchBox" class="easyui-searchbox" data-options="prompt:'模糊查询',searcher:doSearchTree" style="width:110px"></input>
			   </div>
			   <ul id="vehicleTree"></ul>
			   <div class="easyui-menu" id='rightMenu' style='width: 160px;'>
				<!--<div class="menu-sep"></div>-->
			   </div>
		   </div><!-- end of 车辆列表-->
		   <div title="地图数据" style="padding:0px">				       
			   <div id="mapTreeToolbar"   style="margin-bottom:5px">	  
				  <a id="btnReloadMapTree" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" >刷新</a>
				  <a id="btnDeleteArea" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-no'" >删除</a>
				  <!--
				  <a id="btnDeleteArea" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" >绑定车辆</a>
				  -->
				   <a id="loadMapTree" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" >加载围栏</a>
			   </div>
		       <!--地图区域对象组成的树菜单-->
			   <ul id="mapTree"></ul>
		   </div>
		</div>
	</div><!--end of west-->
	<!-- 统计信息 -->
	<div data-options="region:'south',border:false" style="height:20px;background:#dcf095;padding:0px;">  
			<a><img src="<%=imgPath %>/info.png" style="vertical-align:middle"  width="13" height="13" alt="总数图标"/>总数:<span id="spanTotal">0</span></a>  
		  <a><img src="<%=imgPath %>/online.png"  style="vertical-align:middle" width="13" height="13" alt="上线图标"/>在线:<span id="spanGpsOnline">0</span></a>
		  <a><img src="<%=imgPath %>/offline.png"  style="vertical-align:middle" width="13" height="13" alt="离线图标"/>离线:<span id="spanGpsOffline">0</span></a>
		  <a><img src="<%=imgPath %>/parking.png"  style="vertical-align:middle" width="13" height="13" alt="停车图标"/>停车:<span id="spanParking">0</span></a>
		  <a><img src="<%=imgPath %>/chart.png"  style="vertical-align:middle" width="13" height="13" alt="上线率图标"/>上线率:<span id="spanOnlineRate">0</span>%</a>
		  <a style="margin-left:50px">地图车标:<img src="<%=imgPath %>/VehicleGreen.png" width="11" height="17" align="absmiddle"/>行驶 <img src="<%=imgPath %>/VehicleParking.png" width="21" height="19" align="absmiddle"/>停车 <img src="<%=imgPath %>/VehicleRed.png" width="11" height="17" align="absmiddle"/>报警</a>
          登录时间：<span id="spanLoginTime"></span><span style="margin-left:10px; margin-right:10px;">|</span><img src="<%=imgPath %>/user_add.png"  style="vertical-align:middle" width="13" height="13" alt="在线人数图标"/>当前在线人数:<span id="spanOnlineUserNum">0</span><span style="margin-left:10px; margin-right:10px;">|</span>软件版本：V1.0<span style="margin-left:10px; margin-right:10px;">|</span> <img src="<%=imgPath %>/alarm.png"  style="vertical-align:middle;cursor:pointer;" id="imgShowAlarmWindow" width="13" height="13" title="点击报警窗口" alt="点击报警窗口" onclick="AlarmGrid.popNotifyWindow();"/>
	</div>
	<!-- 操作区域 -->
	<div data-options="region:'center'">
	    <div id="mainTab" class="easyui-tabs" data-options="fit:true,border:false,plain:true,onLoad:onMainTabLoaded,onClose:onMainTabClosed">
		      
			<div title="综合监控" style="padding:0px" data-options="iconCls:'icon-main'">
				<div id="centerLayout" class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',border:true">
						<!-- 地图  -->
					   <iframe id="mapFrame" scrolling="no" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
					</div>
					<div data-options="region:'south',split:true,border:true" style="height:240px">
						<form id="queryForm"></form>
	                   <div id="realDataTab" class="easyui-tabs" data-options="fit:true,border:false,plain:true,onSelect:onTabSelect,tools:'#tab-tools'">
			               <div title="实时数据" style="padding:0px" data-options="">
						      <div id="commandToolbar" style=" margin :0px; padding :5px;">     
									车牌号：
									<input id="realDataPlateNo" type="realDataPlateNo" style="width:100px;" readonly="readonly" />&nbsp;| 
								</div>

					          <div id="realDataGrid"></div>
						   </div>
						    <div title="报警数据" style="padding:0px">
							  <div id="alarmGridToolbar" style=" margin :0px; padding :5px;">     
							       <span style="color:red">双击记录处理报警</span> &nbsp;| 
									车牌号：
									<input id="alarmPlateNo" name="alarmPlateNo" type="text" onfocus="" style="width:80px;"/>
								   报警类型： 
									<select  class="easyui-combobox" name="alarmType" id="alarmType" style="width:140px;" >
								    </select>
									&nbsp;
									报警来源： 
									<select  class="easyui-combobox" name="alarmSrc" id="alarmSrc" style="width:100px;" data-options="panelHeight:'auto'">
								    </select>
									
									  <a id="btnQueryAlarmData" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >查询</a>
									  <a id="btnResetAlarm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >重置</a>
		  							 <a id="alarmExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'">导出</a><!--调用utility.js-->
									  <input type="checkbox"  id="autoRefreshAlarmGrid"/>自动刷新表格
									<input type="checkbox" id="muteAlarmSound"/>静音&nbsp;&nbsp;
									<input type="checkbox"  id="disableAlarmWindow"/>禁止弹窗
								</div>
					          	<div id="alarmDataGrid"></div>
						   </div>
						    <div title="终端命令" style="padding:0px">
						     <div id="tmnlGridToolbar" style=" margin :0px; padding :5px;">     
							    &nbsp;&nbsp;&nbsp;车牌号：
								<input id="tmnlPlateNo" name="alarmPlateNo" type="text" onfocus="" style="width:80px;"/>&nbsp;&nbsp;&nbsp;
								 <a id="btnQueryTmnlData" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >查询</a>
								 <a id="btnResetTmnl" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >重置</a>
							     <a id="tmnlExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'">导出</a>
							     </div>
					          <div id="terminalCommandGrid"></div>
							</div>
							
						    <div title="报警督办" style="padding:0px">
							  <div id="alarmToDoGridToolbar" style=" margin :0px; padding :5px;"> 
							      <span style="color:red">双击进行报警督办应答</span>&nbsp;&nbsp;|&nbsp;
							     &nbsp;车牌号：
								<input id="todoPlateNo" name="alarmPlateNo" type="text" onfocus="" style="width:80px;"/>&nbsp;&nbsp;&nbsp;
								 <a id="btnQueryTodo" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >查询</a>
								 <a id="btnResetTodo" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >重置</a>
							     <a id="todoExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'">导出</a>
							     <input type="checkbox" id="autoRefresh809AlarmGrid" />自动刷新
							  </div>
					          <div id="alarmToDoGrid"></div>
							</div>
							
						    <div title="上级政府平台" style="padding:0px">
							   <div id="jt809GridToolbar" style=" margin :0px; padding :5px;">     
									  <a id="btnConnectMainLink" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >连接主链路</a>
									  <a id="btnCloseMainLinkRequest" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-function'" >下发主链路注销请求</a>
									  <a id="btnCloseMainLinkNotify" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-function'" >下发主链路断开通知</a>
									  <a id="btnCloseLinkNotify" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-no'" >下发主动关闭主从链路通知消息</a>
									  &nbsp;&nbsp;
									   <a id="jt809Export" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'">导出</a>
									  &nbsp;&nbsp;
							       主链路状态:<img id="mainLinkState" src="<%=ApplicationPath%>/image/no.png" align="absmiddle" />&nbsp;| 
									从链路状态:<img id="subLinkState" src="<%=ApplicationPath%>/image/no.png" align="absmiddle" />

								</div>
					            <div id="jt809Grid"></div>
							</div>

					   </div><!--realdatatab-->
					   <div id="tab-tools">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'" onclick="hideRealDataTab()"></a>
						</div>

					</div>
				</div>

			</div><!--end of tab1-->
			

	    </div><!--end of mainTab-->
	
	</div><!--end of center-->
	<div id="commandWindow" style="width:0;height:0;">
	<iframe scrolling="auto" id='commandIframe' frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
	</div>
	<div id="childWindow" style="width:0;height:0;">
	<iframe scrolling="auto" id='childIframe' frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
	</div>

	<!--弹出报警窗口--> 
	<div id="alarmWindow" class="easyui-window" title="报警窗口" data-options="iconCls:'icon-alarm',minimizable:false,tools:'#tt'" style="width:320px;height:200px;padding:10px;">
		<div id="alarmBox" class="alarm_box" contenteditable="false"><br /></div>
	</div>
	<div id="tt">
		<a href="javascript:void(0)" class="icon-clear" onclick="javascript:AlarmGrid.clearWindow()"></a>
	</div>
	<!--GPS实时监控时，显示的GPS信息-->
	<div id="gpsInfoWindow">
	    <table id="pg" style="width:300px"></table>
	</div>

<div id="routePlanWindow" class="easyui-window" title="路线规划" data-options="iconCls:'icon-route'" style="width:400px;height:200px;padding:10px;">
		<table width="100%">
		  <tr>
		     <td width="10%">起点:</td>
			 <td width="90%"><input type="text" id="startPOI" style="width:300px;"/> </td>
		  </tr>
		     <td>终点:</td>
			 <td><input type="text" id="endPOI" style="width:300px;"/>
			 </td>
		  </tr>
		  </tr>
		    <td colspan=2 align=center>
		     <a id="btnPlanRoute" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >
			 路径规划</a>
			 </td>
		  </tr>
		</table>
</div>

<div id="infoWindowTemplateOutput" style="display: none;"></div>
<!--地图对象信息窗口的模板，json数据可以填充到模板中，生成Html-->

<div id="infoWindowTemplate" style="display: none;">    
	<table width=510 class=maptable>
	<tr><td width=16% class="tdheader">[车牌号码]:</td><td align=left>{{plateNo}}</td><td class="tdheader" width=16%>[所属部门]:</td><td>{{depName}}</td></tr>
	<tr><td class="tdheader">[经度纬度]:</td><td>{{orgLongitude}},{{orgLatitude}}</td><td class="tdheader">[速度方向]:</td><td>{{velocity}}(km/h) {{directionDescr}}</td></tr>
	<tr><td class="tdheader">[海拔(米)]:</td><td>{{altitude}} 米</td><td class="tdheader">[当前油量]:</td><td>{{gas}} L</td></tr>
	<tr><td class="tdheader">[上报时间]:</td><td>{{sendTime}}</td><td class="tdheader">[里程(km)]:</td><td>{{mileage}}</td></tr>
	<tr><td class="tdheader">[车辆状态]:</td><td colspan=3>{{status}}</td></tr>
	 <tr><td class="tdheader">[设备报警]:</td><td colspan=3 style="color:red;">{{alarmStateDescr}}</td></tr>
	<tr><td class="tdheader">[车辆位置]:</td><td style="border:solid #A6B3D2 !important;border-width:3px 0 0 0  !important;" id="address_{id}}" colspan=3>{{location}}</td></tr>
	</table>
</div>
<div id="infoWindowTemplate2" style="display: none;">    
		<table width=600 class=maptable>
		 <tr><td width=11% class="tdheader">车牌号:</td><td align=left>{{plateNo}}</td><td width=15%  class="tdheader">颜色:</td><td align=left width=15%>{{plateColor}}</td><td class="tdheader" width=15%>车组:</td><td width=20%>{{depName}}</td></tr>
		<tr><td class="tdheader">业户:</td><td>{{memberName}}</td><td class="tdheader">车辆类型:</td><td>{{vehicleType}}</td><td class="tdheader">行业类型:</td><td>{{industryType}}</td></tr>
		 <tr><td class="tdheader">经纬度:</td><td>{{orgLongitude}},{{orgLatitude}}</td><td class="tdheader">GPS速度:</td><td>{{velocity}}(km/h)</td><td class="tdheader">记录仪速度:</td><td>{{recordVelocity}}(km/h)</td></tr>
		 <tr><td class="tdheader">有效性:</td><td>{{valid}}</td><td class="tdheader">方向:</td><td>{{directionDescr}}</td><td class="tdheader">海拔(米):</td><td>{{altitude}}</td></tr>
		 <tr><td class="tdheader">状态:</td><td colspan=3>{{status}}</td><td class="tdheader">Sim卡号:</td><td>{{simNo}}</td></tr>
		 <tr><td class="tdheader">报警:</td><td colspan=5 style="color:red;">{{alarmStateDescr}}</td></tr>
		 <tr><td class="tdheader">GPS时间:</td><td>{{sendTime}}</td><td class="tdheader">里程(km):</td><td>{{mileage}}</td><td class="tdheader">油量:</td><td>{{gas}}(升)</td></tr>
		 <tr><td class="tdheader">地址:</td><td id="address_{id}}">{{location}}</td><td class="tdheader">驾驶员:</td><td><a href="javascript:InfoWindow.viewDriverInfo({driverId}})">{{driverName}}</a></td><td class="tdheader">电子运单:</td><td>{{ewayBill}}</td></tr>
		</table>

	</div>

	

</body>

<script type="text/javascript" src="<%=ApplicationPath%>/media/swfobject.js"></script>
	<div style="z-index:0;bottom:0px;right:0px;width:0;height:0">
		<object type="application/x-shockwave-flash" data="<%=ApplicationPath%>/media/dewplayer.swf" 
			width="0" height="0" id="dewplayerjs">
			<param name="wmode" value="transparent" />
			<param name="movie" value="<%=ApplicationPath%>/media/dewplayer.swf" />
			<param name="flashvars" value="mp3=<%=ApplicationPath%>/media/AlarmSound.mp3&amp;autostart=0&javascript=on&autoreplay=0" />
		</object>
	</div>

<script id="realDataTemplate2" type="text/x-jquery-tmpl">
<table width=700 class=maptable>
 <tr><td width=11% class="tdheader">车牌号:</td><td align=left>${plateNo}</td><td width=15%  class="tdheader">颜色:</td><td align=left width=15%>${plateColor}</td><td class="tdheader" width=15%>车组:</td><td>${depName}</td></tr>
<tr><td class="tdheader">业户:</td><td>${memberName}</td><td class="tdheader">车辆类型:</td><td>${vehicleType}</td><td class="tdheader">行业类型:</td><td>${industryType}</td></tr>
 <tr><td class="tdheader">经纬度:</td><td>${orgLongitude},{orgLatitude}</td><td class="tdheader">GPS速度:</td><td>${velocity}(km/h)</td><td class="tdheader">记录仪速度:</td><td>${recordVelocity}(km/h)</td></tr>
 <tr><td class="tdheader">有效性:</td><td>${valid}</td><td class="tdheader">方向:</td><td>${directionDescr}</td><td class="tdheader">海拔(米):</td><td>${altitude}</td></tr>
 <tr><td class="tdheader">状态:</td><td colspan=3>${status}</td><td class="tdheader">Sim卡号:</td><td>${simNo}</td></tr>
 <tr><td class="tdheader">报警:</td><td colspan=5 style="color:red;">${alarmStateDescr}</td></tr>
 <tr><td class="tdheader">GPS时间:</td><td>${sendTime}</td><td class="tdheader">里程(km):</td><td>${mileage}</td><td class="tdheader">油量:</td><td>${gas}(升)</td></tr>
 <tr><td class="tdheader">地址:</td><td id="address_{id}">${location}</td><td class="tdheader">驾驶员:</td><td><a href="javascript:InfoWindow.viewDriverInfo({driverId})">${driverName}</a></td><td class="tdheader">电子运单:</td><td>${ewayBill}</td></tr>
</table>

</script>
<script id="realDataTemplate" type="text/x-jquery-tmpl">

</script>
<div id="templateContent" style="display:none"></div>


<script>
	var globalConfig = {webPath:"<%=ApplicationPath%>"};
   //当前登录用户信息
    var userInfo = ${onlineUserInfo};
	var mapType = userInfo.mapType;
	var randomnumber=Math.floor(Math.random()*100000);  
	var mapPath = "map/"+mapType+".jsp?randomnumber="+randomnumber;
	globalConfig.mapPath = mapPath;
	globalConfig.mapType = mapType;
</script>

<script type="text/javascript" src="<%=jsPath%>/jquery/jquery1.8.min.js"></script>
<script type="text/javascript" src="<%=ApplicationPath%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=jsPath%>/jquery/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=jsPath%>/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=jsPath%>/tree.js"></script>
<script type="text/javascript" src="<%=jsPath%>/realDataGrid.js"></script>
<script type="text/javascript" src="<%=jsPath%>/InfoWindow.js"></script>
<script type="text/javascript" src="<%=jsPath%>/historyRoute.js"></script>
<script type="text/javascript" src="<%=jsPath%>/jquery.tmpl.js"></script>
<script type="text/javascript" src="<%=jsPath%>/alarmGrid.js"></script><!-- 报警 -->
<script type="text/javascript" src="<%=jsPath%>/menu.js"></script>
<script type="text/javascript" src="<%=jsPath%>/md5.js"></script>
<script type="text/javascript" src="<%=jsPath%>/AlarmToDoGrid.js"></script><!-- 报警督办 -->
<script type="text/javascript" src="<%=jsPath%>/jt809CommandGrid.js"></script><!-- 上级政府平台 -->
<script type="text/javascript" src="<%=jsPath%>/terminalCommandGrid.js"></script>
<script type="text/javascript" src="<%=jsPath%>/alarmGrid.js"></script>
<script type="text/javascript" src="<%=jsPath%>/alarmSound.js"></script>
<script type="text/javascript" src="<%=jsPath%>/maptree.js"></script>
<script type="text/javascript" src="<%=jsPath%>/utility.js"></script>
<script type="text/javascript" src="<%=jsPath%>/myMap.js"></script><!--调用iframe窗口里面的地图方法-->
<script type="text/javascript" src="<%=jsPath%>/jquery/jquery.timers.js"></script><!--定时器-->
<script type="text/javascript" src="<%=jsPath%>/json2template.js"></script><!--json数据按照html模板格式填充到html中-->


<script type="text/javascript">
	/**
	 * 主菜单
	 */
	var mainMenuData = ${MainMenu}; //将session中的菜单数据的java集合对象转换成json菜单对象
	//权限功能数据
	var funcList = ${WebFunc}; //将session中的菜单数据的java集合对象转换成json菜单对象
	var funcMap = {};
	if(funcList.length > 0)
	{
		//funcList = funcList[0].items;
		$.each(funcList, function (i, sm) {
			funcMap[sm.funcName]=sm;
		});
	}
	//判断用户是否有这个功能权限
	function isFuncAllowed(funcName)
	{
		return funcMap[funcName];
	}

	/**
	 * 创建快捷菜单
	 */
	var shortCutMenu = ${ShortCutMenu}; //将session中的菜单数据的java集合对象转换成json菜单对象
	//命令工具菜单
	var commandToolMenu = ${CommandToolMenu}; //将session中命令工具菜单数据输出成json对象
	//车辆树的右键菜单数据
	var rightMenuData = ${RightMenu}; //将session中右键菜单数据输出成json对象
	
    var isReady = false;
    $(document).ready(function () {
        //关闭AJAX相应的缓存
        $.ajaxSetup({ cache: false });
        //创建实时数据表格
		RealDataGrid.create();
		//加载地图
		$("#mapFrame").attr("src", mapPath);
		//创建主菜单
		MyMenu.createMainMenu(mainMenuData);
		//创建快捷菜单
		MyMenu.createShortCutMenu(shortCutMenu);
		//创建命令工具栏
		MyMenu.createCommandToolBar(commandToolMenu);
		//创建右键菜单
		var treeRightMenu = MyMenu.createRightMenu(rightMenuData);
		//创建车辆树
		var vehicelTreeId = "vehicleTree";
		var treeHeight = 300;
		//创建车辆树
		VehicleTree.createTree(vehicelTreeId,treeHeight,treeRightMenu);
		//创建报警表格
		AlarmGrid.create();
		if(isFuncAllowed("Jt809CommandGrid"))
		{
		   Jt809CommandGrid.create();
		}else
		{
			$('#realDataTab').tabs('close',"上级政府平台");
		}
		if(isFuncAllowed("AlarmToDoGrid"))
		{
		   AlarmToDoGrid.create();
		}else
		{
			$('#realDataTab').tabs('close',"报警督办");
		}
		if(isFuncAllowed("TerminalCommandGrid"))
		{
		    TerminalCommandGrid.create();
		}else
		{
			$('#realDataTab').tabs('close',"终端命令");
		}


		//车辆树过滤条件下拉框触发事件
		$('#filterType').combobox(
		{
			onChange :function(newValue,oldValue){ 
				var filterType = newValue;
				if(filterType == "all")
				{
					//$("#filterType").combobox('setValue','');
					$('#searchBox').searchbox('setValue', null);
					VehicleTree.clearFilter();//清除过滤条件，重新查询
					VehicleTree.load(false);
				}else if(filterType == "online")
				{
					 var params = {online:1};
			         VehicleTree.filter(params);
				}else if(filterType == "offline")
				{
					 var params = {online:0};
			         VehicleTree.filter(params);
				}
		    }
		});
		$('#filterType').combobox("setValue","plateNo");
		$("#LoginName").html(userInfo.roleName+':'+userInfo.name);
		isReady = true;
		//创建地图图元树
		MapTree.createTree();
		
		$("#spanLoginTime").html(userInfo.loginTime);
		$('#routePlanWindow').window('close');
	});
	

	 var index = 0;
		function addPanel(){
			index++;
			$('#mainTab').tabs('add',{
				title: 'Tab'+index,
				content: '<div style="padding:10px">Content'+index+'</div>',
				closable: true
			});
		}
	//历史轨迹
	function onMainTabLoaded(p)
	{
		$.parser.parse(p);
		HistoryRoutePanel.init("hisDataGrid");
		
		var plateNo = VehicleTree.getSelectedPlateNo();
		HistoryRoutePanel.setPlateNo(plateNo);
	}
	
	function onMainTabClosed(title)
	{
	    if(title == '历史轨迹')
		{
		    HistoryRoutePanel.stopPlay();
		}
	}
	var tabId = 1;
	function addTab(title,href,icon){  
		var tt = $('#mainTab');  
		if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab          
			tt.tabs('select', title);  
			
			var plateNo = VehicleTree.getSelectedPlateNo();
			HistoryRoutePanel.setPlateNo(plateNo);
			//refreshTab({tabTitle:title,url:href});  
		} else {  
			if(title == '历史轨迹')
			{
				tt.tabs('add',{  
					title:title,  
					id:tabId,
					closable:true,  
					href:'hisroute.html',
					//content:content,  
					iconCls:icon||'icon-default'  
				});  
				
					
			}else
			{
				if (href){  
					var content = '<iframe scrolling="auto" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';  
				} else {  
					var content = '未实现';  
				}  
				tt.tabs('add',{  
					title:title,  
					id:tabId,
					closable:true,  
					content:content,  
					iconCls:icon||'icon-default'  
				});  
			}
		}  
    }  

	function refreshTab(cfg){  
		var refresh_tab = cfg.tabTitle?$('#mainTab').tabs('getTab',cfg.tabTitle):$('#mainTab').tabs('getSelected');  
		if(refresh_tab && refresh_tab.find('iframe').length > 0){  
			var _refresh_ifram = refresh_tab.find('iframe')[0];  
			var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;  
			//_refresh_ifram.src = refresh_url;  
			_refresh_ifram.contentWindow.location.href=refresh_url;  
		}  
    } 
	//关闭命令窗口
	function closeCommandWindow()
	{
		$('#commandWindow').window('close');
	}


	function openIFrameWindow(url, width, height,  title)
	{
		//$('#commandIframe')[0].src = "about:blank";
		//清空iframe的内容,避免缓存
		$('#commandIframe')[0].contentWindow.document.body.innerText = "";
		$('#commandIframe')[0].src=url;
					$('#commandWindow').dialog({    
						width:width,    
						height:height,    
						title:title,
						minimizable: false,
						modal:false   
					});  
		$('#commandWindow').window('open');
	}
	function openIFrameChildWindow(url, width, height,  title)
	{
		//$('#commandIframe')[0].src = "about:blank";
		//清空iframe的内容,避免缓存
		var childIframe = $('#childIframe');
		childIframe[0].contentWindow.document.body.innerText = "";
		childIframe[0].src=url;
	    $('#childWindow').dialog({    
						width:width,    
						height:height,    
						title:title,
			minimizable: false,
						modal:false   
					});  
		$('#childWindow').window('open');
	}


	/**
	 * 主窗口函数，主要是当子窗口的编辑窗口中数据保存后，
	 * 重新刷新Iframe子窗口中的页面中提供的refreshTable的刷新表格函数
	 */
	function refreshDataWindow()
	{ 
		var curTab = $('#mainTab').tabs('getSelected');
	    var tabId = curTab.id;
	    if(curTab && curTab.find('iframe').length > 0){  
			var iframeWindow = curTab.find('iframe')[0];  
			//调用子窗口的刷新表格函数 函数在表格分页js文件中,paginateUtil.js
			 if(iframeWindow && iframeWindow.contentWindow.refreshTable)
		          iframeWindow.contentWindow.refreshTable(); 

		}  

	}
 
function openRoutePlanWindow()
{
   $('#routePlanWindow').window('open');
}
	/**
  * 打开围栏设置窗口,在地图中画围栏或者线路时调用，弹出窗口，录入参数，保存。
  */
  var enclosureWindow;
function openRouteWindow(url, width, height, title, closeCallback)
{
		$('#commandIframe')[0].contentWindow.document.body.innerText = "";
		$('#commandIframe')[0].src=url;
		enclosureWindow = $('#commandWindow').window({    
						width:width,    
						height:height,    
						title:title,
						modal:false,
						onClose:function()
						{ 
							if(closeCallback)
								closeCallback();
						}
		});  
		$('#commandWindow').window('open');
}

//创建围栏
function createExtendEnclosure(ec, strPoints)
{
	var id = ec.entityId;
	 if(id > 0 && strPoints.length > 0)
	{
		 var curTab = $('#mainTab').tabs('getSelected');
	     var tabId = curTab.id;
	     if(curTab && curTab.find('iframe').length > 0){  
			var iframeWindow = curTab.find('iframe')[0];  
			 if(iframeWindow && iframeWindow.contentWindow.createExtendEnclosure)
			{
				 iframeWindow.contentWindow.createExtendEnclosure(strPoints, ec.radius, id, ec.enclosureType,ec.name,  ec.centerLat, ec.centerLng);
			}
		}
	}
	 closeEnclosureWindow();		
}


function createPolyline(ec, strPoints)
{
	var id = ec.entityId;
	 if(id > 0)
	{
		  var curTab = $('#mainTab').tabs('getSelected');
	     var tabId = curTab.id;
	     if(curTab && curTab.find('iframe').length > 0){  
			var iframeWindow = curTab.find('iframe')[0];  
			 if(iframeWindow && iframeWindow.contentWindow.createExtendPolyline)
			{
				 iframeWindow.contentWindow.createExtendPolyline(strPoints, id, ec.name, ec.centerLat, ec.centerLng);
			}
		}

	   //window.frames['tab_map-frame'].createExtendPolyline(strPoints, id, ec.name, ec.centerLat, ec.centerLng);
	}
	
	 closeEnclosureWindow();	
}



function createKeyPoint(ec, strPoints)
{
	var id = ec.entityId;
	 if(id > 0)
	{
         var curTab = $('#mainTab').tabs('getSelected');
	     var tabId = curTab.id;
	     if(curTab && curTab.find('iframe').length > 0){  
			var iframeWindow = curTab.find('iframe')[0];  
			 if(iframeWindow && iframeWindow.contentWindow.createExtendKeyPoint)
			{
	           iframeWindow.contentWindow.createExtendKeyPoint(ec.centerLat, ec.centerLng, ec.raidus,  id, ec.name);
			}
		 }
	}
	
	 closeEnclosureWindow();		
}
/**
 * 创建地标
 */
function createMarker(ec, strPoints)
{
	var id = ec.entityId;
	 if(id > 0)
	{  var curTab = $('#mainTab').tabs('getSelected');
	     var tabId = curTab.id;
	     if(curTab && curTab.find('iframe').length > 0){  
			var iframeWindow = curTab.find('iframe')[0];  
			 if(iframeWindow && iframeWindow.contentWindow.createExtendKeyPoint)
			{
	            iframeWindow.contentWindow.createExtendMarker(ec.centerLat, ec.centerLng, ec.raidus,  id, ec.name,ec.icon);
			}
		 }
	}
	
	 closeEnclosureWindow();		
}


//关闭区域设置窗口
function closeEnclosureWindow()
{
	 if(enclosureWindow)
			 enclosureWindow.window('close');
}

	
function renderTemplate(opt)
{	
	//if(globalConfig.mapType != "baidu")
		//return renderTemplate2(opt);
	if(opt.latitude)
	{
		var strLatitude = ""+opt.latitude;
		strLatitude = strLatitude.substring(0,9);
		opt.latitude = strLatitude;//opt.latitude.toFixed(6); 
	}
	if(opt.longitude)
	{
		var strLongitude = ""+opt.longitude;
		strLongitude = strLongitude.substring(0,9);
		opt.longitude = strLongitude;//opt.longitude.toFixed(6); 
	}
	//调用模板引擎，将json数据填充到模板中，转成html
    var d = $("#infoWindowTemplateOutput").bindTemplate(
    {
        source : opt
      , template : $("#infoWindowTemplate")
    });  
	var html = d.html();// d.prop("outerHTML");//appendTo("#templateContent");
	// var html =$("#templateContent").html();
	return html;   
}


function renderTemplate2(opt)
{

	if(opt.latitude)
	{
		var strLatitude = ""+opt.latitude;
		strLatitude = strLatitude.substring(0,9);
		opt.latitude = strLatitude;//opt.latitude.toFixed(6); 
	}
	if(opt.longitude)
	{
		var strLongitude = ""+opt.longitude;
		strLongitude = strLongitude.substring(0,9);
		opt.longitude = strLongitude;//opt.longitude.toFixed(6); 
	}
	 var d = $("#infoWindowTemplateOutput").bindTemplate(
    {
        source : opt
      , template : $("#infoWindowTemplate2")
    });  
		var html = d.html();
	 //var html = $("#realDataTemplate2").tmpl(opt).html();
	 //var html =$("#templateContent").html();
	return html;   
}

     //过滤树
     function doSearchTree(value){
		 var filterType =  $("#filterType").combobox('getValue');

		 if(filterType == "all")
		 {
			 $.messager.alert('提示','请选择过滤类型');
			 
		 }else
		 {
			 if(value == null || value.length == "")
			 {
				 $.messager.alert('提示','请输入过滤条件');
			 }
			 var params = {};
			 params[filterType] = value;
			 VehicleTree.filter(params);
		 }
            //alert('You input: ' + value);
     }

	 function hideRealDataTab()
	 {
		 $('#centerLayout').layout('collapse','south');
	 }

	
	 function onTabSelect(title)
	 {
		 //var pp = $('#realDataTab').tabs('options');
		 //alert(pp.height);
		 //var width =  $('#realDataTab').tabs('width');
		 //alert(width);
	 }

    //当历史轨迹标签调整尺寸时，调整标签页中的表格的高度和宽度
	 function onRouteTabResize(width, height)
	 {
		 if(isReady == false)
			 return;
		 //alert(width+','+height);
		 //$("#hisDataGrid").datagrid('resize',{width:width-10,height:height-2,left:2,top:2});

	 }

	 /**
	  * 当用户点击打开修改密码的按钮时，弹出修改密码的窗口
	  */
	 function openUpdatePasswordWindow()
	 {
		 InfoWindow.open('<%=ApplicationPath%>/user/updatePassword.action?input=true',400,260,"修改用户密码");
	 }

</script>
</html>
