<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>Sample App Sign-up Page</title>
    
    <script type="text/javascript" src='<c:url value="/main/js/jquery-2.0.0.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/main/js/jquery.timer.js"></c:url>'></script>
    <script type="text/javascript">
    
    	var mac_address = '2C:26:20:52:41:53';
    	
    	$(document).ready(function(){
    		
    		//每10秒执行，无限次，并命名计时器名称为C
    		//若时间间隔抵到，但函式程序仍未完成则需等待执行函式完成后再继续计时
    		//$('body').everyTime('1das','C',function(){
    		$('body').everyTime('5s','C',function(){
    			refreshUser();
    			refreshCommand();
    		},0,true);
    		
    	});
    	
    	function refreshUser() {
    		$.ajax({
	            type: "get",
	            dataType: "json",
	            url: "http://staging.marketboomer.cn:18080/monitorserver/services/hostInfo/hostStatusInfoService/allHost/1",
	            complete :function() {
	            },
	            success: function(hostInfoArray){
					$("#statusPanel1").html(JSON.stringify(hostInfoArray));
	            	
	            	var tablecontent = "<table border='1'><tr style='font-weight:bold;'><td>Host Name</td><td>Mac Address</td><td>CPU Total Used</td><td>Command</td></tr>";
	            		
	            	$.each(hostInfoArray, function(i, hostInfo){   
	            	    tablecontent += "<tr><td>"+hostInfo.hostname+"</td><td>"+hostInfo.macAddress+
	            		"</td><td>"+hostInfo.cpuTotalUsed+"</td><td><button type='button' onclick='runCommand(\"" + hostInfo.macAddress + "\")'>Run Tasklist Command</button></td></tr>";
	            	});  	
	            	
	            	tablecontent += "</table>";
	            	
	            	$("#statusPanel2").html(tablecontent);
	            }});
    	}
    	
    	function runCommand(macAddress) {
    		
			$.ajax({
				type: "POST",
				url: "http://staging.marketboomer.cn:18080/monitorserver/services/command/userCommandService/create",
				data: JSON.stringify({hostMacAddress:macAddress,commandStr:"tasklist",status:"Created"}),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(data){alert(data);},
				failure: function(errMsg) {
					
				}
			});
    		
    	}
    	
    	function refreshCommand() {
    		$.ajax({
	            type: "get",
	            dataType: "json",
	            url: "http://staging.marketboomer.cn:18080/monitorserver/services/command/userCommandService/allcommand/"+mac_address,
	            complete :function() {
	            },
	            success: function(commandArray){
	            	$("#statusPanel3").html(JSON.stringify(commandArray));
	            	
	            	var tablecontent = "<table border='1'><tr style='font-weight:bold;'><td>Id</td><td>Mac Address</td><td>Command</td><td>Status</td><td>Result</td><td>End Date</td></tr>";
	            		
	            	$.each(commandArray, function(i, command){   
	            	    tablecontent += "<tr><td>"+command.id+"</td><td>"+command.hostMacAddress+"</td><td>"+
	            	    	command.commandStr+"</td><td>" +	            	    	 
	            	    	command.status+"</td><td>" + 
	            	    	"<span title='" + command.resultStr + "'>Command Result</span></td><td>" + command.endDate + "</td></tr>";
	            	});  	
	            	
	            	tablecontent += "</table>";
	            	
	            	$("#statusPanel4").html(tablecontent);
	            }});
    	}
    
    </script>
    
    
</head>
<body>

<h1>Host Status Info List: </h1>

<div id="statusPanel2"> Test2 </div>
<div id="statusPanel1"> Test1 </div>

<h1>User Command List: </h1>

<div id="statusPanel4"> Test4 </div>
<div id="statusPanel3"> Test3 </div>

</body>
</html>
