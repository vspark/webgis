<%@ page language="java" pageEncoding="UTF-8"%>
<!--分页查询共用的页面-->
<%@ include file="/common/paginateUtil.jsp"%>
<!--日期控件-->
<%@ include file="/common/dateUtil.jsp"%>
  
</head>

		<script type="text/javascript" charset="utf-8">			
			

			$(document).ready(function() {
				
				   var now = Utility.today(1);
				  $("#endDate").val(now + " 23:59:00");
				  var now = Utility.today();
				  $("#startDate").val(now + " 00:00:00");

			    
				$("#btnQuery").click(function(){
				        Utility.loadGridWithParams();
				});
				 Utility.loadGridWithParams();
			} );
		</script>
<body>
		<div id="toolbar" >		
			
			<form id="queryForm" action="<%=ApplicationPath%>/system/operationLog.action">
			   <input type="hidden" name="queryId" value="selectOperationLog" />	   
			   <input type="hidden" name="fileName" value="用户操作日志" />	       	   
			  <table width="100%"  class="TableBlock">
			   			   <tr>
			   <td> 用户登录名: </td>
			    <td>			    <input type="text" name="userName" size="10"  id="userName">   </td>
            <td>操作时间:</td>
			    <td>			    <input type="text" name="startDate" id="startDate" size="10" class="datepicker">  
				至    <input type="text" name="endDate" id="endDate" size="10" class="datepicker">
				</td>
          
        <td  align="left">
	      <a id="btnQuery" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>&nbsp;
		   <a id="btnReset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" >重置</a>&nbsp;
		   <a id="btnExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" onclick="Utility.excelExport('<%=ApplicationPath%>/data/excelExport.action');">导出</a><!--调用utility.js-->
        </td>
    </tr>
		</form>	 
		</table>
		</div>

				<table id="queryGrid" class="easyui-datagrid" title="" style="width:100%;height:480px"
						data-options="pagination:true,pageSize:15,singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						pageList: [15, 20, 50, 100, 150, 200],fit:true,toolbar:'#toolbar',
						url:'<%=ApplicationPath%>/system/operationLog.action',method:'post'">
					<thead>
						<tr>	
							<th data-options="field:'userName'" width="7%">用户名称</th>
							<th data-options="field:'detail'" width="25%">操作</th>
							<th data-options="field:'createDate'" width="11%">操作时间</th>
							<th data-options="field:'url'" width="25%">http地址</th>
							<th data-options="field:'ip'" width="22%">用户IP</th>
						</tr>
					</thead>				
				</table>

</body>

