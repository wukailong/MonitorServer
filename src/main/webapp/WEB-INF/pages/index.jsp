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
	            url: "http://127.0.0.1:8090/MonitorServer-1.0/services/hostInfo/hostStatusInfoService/hostInfo/1",
	            complete :function() {
	            },
	            success: function(msg){
	            	$("#statusPanel1").html(JSON.stringify(msg));
	            	
	            	var tablecontent = "<table border='1'><tr style='font-weight:bold;'><td>Host Name</td><td>Mac Address</td><td>CPU Total Used</td><td>Command</td></tr>" +
	            		"<tr><td>"+msg.hostname+"</td><td>"+msg.macAddress+
	            		"</td><td>"+msg.cpuTotalUsed+"</td><td><button type='button' onclick='runCommand()'>Run Tasklist Command</button></td></tr></table>";
	            		
	            		$("#statusPanel2").html(tablecontent);
	            }});
    	}
    	
    	function runCommand() {
    		alert("Run Command ing...");
    		
    		$.ajax({
				type: "POST",
				url: "http://127.0.0.1:8090/MonitorServer-1.0/services/command/userCommandService/create",
				data: JSON.stringify({hostMacAddress:"B4:B0:20:52:41:53",commandStr:"",status:"Created"}),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(data){alert(data);},
				failure: function(errMsg) {
					alert(errMsg);
				}
			});
    		
    	}
    	
    	function refreshCommand() {
    		$.ajax({
	            type: "get",
	            dataType: "json",
	            url: "http://127.0.0.1:8090/MonitorServer-1.0/services/command/userCommandService/allcommand/B4:B0:20:52:41:53",
	            complete :function() {
	            },
	            success: function(commandArray){
	            	$("#statusPanel3").html(JSON.stringify(commandArray));
	            	
	            	var tablecontent = "<table border='1'><tr style='font-weight:bold;'><td>Id</td><td>Mac Address</td><td>Command</td><td>Status</td><td>Result</td></tr>";
	            		
	            	$.each(commandArray, function(i, command){   
	            	    tablecontent += "<tr><td>"+command.id+"</td><td>"+command.hostMacAddress+"</td><td>"+
	            	    	command.commandStr+"</td><td>" +	            	    	 
	            	    	command.status+"</td><td>" + 
	            	    	command.resultStr+"</td></tr>";
	            	});  	
	            	
	            	tablecontent += "</table>";
	            	
	            	$("#statusPanel4").html(tablecontent);
	            }});
    	}
    
    </script>
    
    
</head>
<body>

<h1>Host Status Info List: </h1>

<div id="statusPanel1"> Test1 </div>
<div id="statusPanel2"> Test2 </div>

<h1>User Command List: </h1>

<div id="statusPanel3"> Test3 </div>
<div id="statusPanel4"> Test4 </div>

</body>
</html>
