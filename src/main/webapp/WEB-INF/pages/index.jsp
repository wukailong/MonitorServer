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
	            	
	            	$("#result2").append("<h1>New Status: </h1>");
	            	$("#result2").append(JSON.stringify(msg));   	
	            
	            }});
    	}
    
    </script>
    
    
</head>
<body>

<h1>Test Sample</h1>


<div id="result1">
	Result1
</div>


<div id="result2">
	Result2
</div>

</body>
</html>
