<%@ page language="java" pageEncoding="UTF-8"%>
<!--分页查询共用的页面-->
<%@ include file="/common/paginateUtil.jsp"%>

</head>

<script type="text/javascript" charset="utf-8">

			//弹窗选择部门
function doSelectDep()
{
	InfoWindow.selectDep();
}
function onDepSelected(depId,depName)
{
	$("#depId").combotree("setValue", depId);
}

				
//删除表格的某一行，删除后，会自动刷新表格			
			function getOnlineColumn(value, rowData, rowIndex)
			{  
				var online = rowData.online;
				var html = online == "在线" ? "<span style='color:green;font-weight:bold;'>在线</span>" : "<span style='color:red'>离线</span>";
			    return html;
			}
			//编辑列
			function getEditActionColumn(value, rowData, rowIndex)
			{
				var entityId = rowData.vehicleId;
				var html =  "<a href=\"javascript:InfoWindow.viewVehicle('" + entityId+ "&input=true');\">" +" 查看</a>";
				return html;
			}
			$(document).ready(function() {
			     
				$("#btnQuery").click(function(){
				        Utility.loadGridWithParams();
				});
				Utility.loadGridWithParams();
				  
				//创建下拉部门树
				Utility.createDepTree("depId");
				$("#status").change(function()
				{
				       var txt = $("#status").find("option:selected").text(); 
					   $("#statusName").val(txt);
				});
			} );
		</script>
<body>
	<div id="toolbar">
		<form id="queryForm"
			action="<%=ApplicationPath%>/report/onlineVehicleList.action">
			<input type="hidden" name="queryId" value="selectOnlineVehicles" />
			<input type="hidden" name="fileName" value="车辆上线状态" /> <input
				type="hidden" name="statusName" id="statusName" value="所有" />
			<table width="100%" class="TableBlock">
				<tr>
					<td>车牌号码:</td>
					<td><input type="text" name="plateNo" size="10" id="plateNo">
					</td>
					<td>终端卡号</td>
					<td><input type="text" name="simNo" size="20"></td>
					<td>车辆组:</td>
					<td><select id="depId" name="depId" style="width:200px;"></select>
						<a id="btnSelectVehicle" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="doSelectDep();"></a>
					</td>
				</tr>
				<tr>


					<td>上线状态</td>
					<td><select name="status" id="status">
							<option value="">所有</option>
							<option value="online">上线</option>
							<option value="offline">离线</option>
					</select> 
					<select name="offlineTimeSpan" id="offlineTimeSpan">
							<option value="">离线时长</option>
							<option value="-1">超过1天</option>
							<option value="-2">超过2天</option>
							<option value="-3">超过3天</option>
							<option value="-4">超过4天</option>
							<option value="-7">超过7天</option>
							<option value="-10">超过10天</option>
					</select></td>
					<td colspan="4" align="left"><a id="btnQuery" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>&nbsp;
						<a id="btnReset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-clear'">重置</a>&nbsp; <a
						id="btnExport" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-excel'"
						onclick="Utility.excelExport('<%=ApplicationPath%>/data/excelExport.action');">导出</a>
					<!--调用utility.js<span style="color:red;">(*离线状态下自动按照离线时长排序)</span>--> 
					</td>
				</tr>
			</table>
		</form>

	</div>
	<table id="queryGrid" class="easyui-datagrid" title=""
		style="width:100%;"
		data-options="pagination:true,pageSize:15,singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						pageList: [15, 20, 50, 100, 150, 200],fit:true,toolbar:'#toolbar',
						url:'<%=ApplicationPath%>/report/onlineVehicleList.action',method:'post'">
		<thead>
			<tr>
				<th data-options="field:'plateNo'" width="6%">车牌号</th>
				<th data-options="field:'plateColor'" width="6%">车牌颜色</th>
				<th data-options="field:'simNo'" width="8%">终端卡号</th>
				<th data-options="field:'depName1'" width="12%">车组</th>
				<th data-options="field:'online',formatter:getOnlineColumn" width="5%">上线状态</th>
				<th data-options="field:'sendTime'" width="11%">上线时间</th>
				<th data-options="field:'offlineTimeSpan'" width="10%">离线时长</th>
				<th data-options="field:'runStatus'" width="6%">运行状态</th>
				<th data-options="field:'vehicleTypeName'" width="8%">车辆类型</th>
				<th data-options="field:'installDate'" width="12%">入网时间</th>
				<th data-options="field:'vehicleId',formatter:getEditActionColumn"
					width="6%">查看</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</body>

