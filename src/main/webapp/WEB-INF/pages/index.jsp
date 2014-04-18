<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>Sample Page</title>
	
    <link href='<c:url value="/main/css/ui.jqgrid.css"/>' type="text/css" rel="stylesheet"></link>
	<link href='<c:url value="/main/css/jquery.ui.theme.css"/>' type="text/css" rel="stylesheet"></link>
	<link href='<c:url value="/main/css/main.css"/>' type="text/css" rel="stylesheet"></link>
	
	<script type="text/javascript" src='<c:url value="/main/js/jquery-1.11.0.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/main/js/jquery.timer.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/main/js/jquery.jqGrid.min.js"></c:url>'></script>
	<script src="js/window.js" type="text/javascript"></script>
    <script type="text/javascript">
    
    	$(document).ready(function(){
		
			$("#hostInfoTable").jqGrid({ 
				datatype: "local", 
				height: 250, 
				colNames:['ID', 'Host Name','Mac Address', 'CPU Used', 'Mem Used', 'Command'], 
				colModel:[ 
					{name:'id',index:'id', width:40, sorttype:"int"}, 
					{name:'hostname',index:'hostname', width:150}, 
					{name:'macAddress',index:'macAddress', width:150}, 
					{name:'cpuTotalUsed',index:'cpuTotalUsed', width:80, formatter: cpuUsedFormatter },
					{name:'totalMem',index:'totalMem', width:80, formatter: memUsedFormatter }, 
					{name:'commandCol',index:'commandCol', width:200, align: 'center', formatter: commandColFormatter}
				], 
				multiselect: false, 
				caption: "Host Info List" 
			});
			
			
			$("#commandsTable").jqGrid({ 
				datatype: "local", 
				height: 250, 
				colNames:['ID', 'Mac Address', 'Command Str', 'Status', 'Result Show'], 
				colModel:[ 
					{name:'id',index:'id', width:40, sorttype:"int"}, 
					{name:'hostMacAddress',index:'hostMacAddress', width:150}, 
					{name:'commandStr',index:'commandStr', width:200 },
					{name:'status',index:'status', width:80 }, 
					{name:'resultShow',index:'resultShow', width:100, align: 'center', formatter: resultShowFormatter}
				], 
				multiselect: false, 
				caption: "Command List" 
			});
    		
			refreshUser();
    		refreshCommand();
			
    		//每10秒执行，无限次，并命名计时器名称为C
    		//若时间间隔抵到，但函式程序仍未完成则需等待执行函式完成后再继续计时
    		//$('body').everyTime('1das','C',function(){
    		$('body').everyTime('5s','C',function(){
    			refreshUser();
    			refreshCommand();
    		},0,true);
			
    		
    	});
		
		function cpuUsedFormatter(cellvalue, options, rowdata) {
			return Number(rowdata.cpuTotalUsed).toFixed(2);
		}
		
		function memUsedFormatter(cellvalue, options, rowdata) {
			return Number(rowdata.freeMem/rowdata.totalMem).toFixed(2);
		}
		
		function commandColFormatter(cellvalue, options, rowdata) {
			return "<button type='button' onclick='showInputCommandPanel(this, \"" + rowdata.id + "\", \"" + rowdata.macAddress + "\")'>Input Command</button>";
			//return "<input type='text' id='" + rowdata.id + "_cmdinput' style='width:200' /><button name='" + rowdata.id + "_cmdinput' type='button' onclick='runCommand(this, \"" + rowdata.macAddress + "\")'>Run Tasklist Command</button>";
		}
		
		function showInputCommandPanel(btn, id, macAddress) {
			$("#cmdinputId").val(id);
			$("#cmdinputMacAddress").val(macAddress);
			$("#cmdinput").val("");
			
			popCenterWindow(btn); 
			//$("#commandInputPanel").show();
		}
		
		function resultShowFormatter(cellvalue, options, rowdata) {
			return "<span title='" + rowdata.resultStr + "'>Result</span>";
		}
    	
    	function refreshUser() {
    		$.ajax({
	            type: "get",
	            dataType: "json",
	            url: "/MonitorServer-1.0/services/hostInfo/hostStatusInfoService/allHost/1",
	            complete :function() {
	            },
	            success: function(hostInfoArray){
					
					$("#hostInfoTable").jqGrid("clearGridData");
					$.each(hostInfoArray, function(i, hostInfo){   
						$("#hostInfoTable").jqGrid('addRowData', i+1, hostInfo);
					});
					
	            }});
    	}
    	
    	function runCommand() {
			//var commandInputStr = $('#' + $(comBtn).attr('name')).val();
			var commandInputStr = $("#cmdinput").val();
			var macAddress = $("#cmdinputMacAddress").val();
			
			if (commandInputStr != '' && macAddress != '') {
			
				$.ajax({
					type: "POST",
					url: "/MonitorServer-1.0/services/command//MonitorServer-1.0/servicesndService/create",
					data: JSON.stringify({hostMacAddress:macAddress,commandStr:commandInputStr,status:"Created"}),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function(data){},
					failure: function(errMsg) {
						
					}
				});			
			}  
				closePopWindow(("#close"));
    	}
    	
    	function refreshCommand() {
    		$.ajax({
	            type: "get",
	            dataType: "json",
	            url: "/MonitorServer-1.0/services/command/userCommandService/allcommand/hostId",
	            complete :function() {
	            },
	            success: function(commandArray){
	            		
					$("#commandsTable").jqGrid("clearGridData");
					$.each(commandArray, function(i, command){   
						$("#commandsTable").jqGrid('addRowData', i+1, command);
					
	            	});
	            }});
    	}
    
    </script>
    
    
</head>
<body>

	<div class="window" id="center" style="z-index:999"> 
		<div id="title" class="title">Run Command Window</div> 
		<div class="content">	
			<input type='hidden' id='cmdinputId'/>
			<input type='hidden' id='cmdinputMacAddress'/>
			Command Input: <input type='text' id='cmdinput' style='width:200' />
			
			<button id='cmdInputBtn' type='button' onclick='runCommand()'>Run Command</button>
			<button id='close' type='button' onclick='closePopWindow()'>Close</button>
		</div> 
	</div> 
	
	<div style="text-align:right;margin-right:10px;">
		<a href="agent-download" target="blank"><button>Download Agent 1.0</button></a>
	</div>  
	
	<table id="hostInfoTable"></table>
		
	<table id="commandsTable"></table>

</body>
</html>
