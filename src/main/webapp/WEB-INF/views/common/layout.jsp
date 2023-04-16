<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("utf-8");
%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>오늘의 꽃</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<link href="${contextPath}/resources/css/basic-jquery-slider.css" rel="stylesheet" type="text/css" media="screen">
<script src="${contextPath}/resources/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/stickysidebar.jquery.js" type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/basic-jquery-slider.js" type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/tabs.js" type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/carousel.js" type="text/javascript"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&family=Gowun+Dodum&display=swap" rel="stylesheet">

<script>
	// 슬라이드 
	$(document).ready(function() {
		$('#ad_main_banner').bjqs({
			'width' : 1253,
			'height' : 532,
			'showMarkers' : true,
			'showControls' : false,
			'centerMarkers' : false
		});
	});
	// 스티키 		
	$(function() {
		$("#sticky").stickySidebar({
			timer : 100,
			easing : "easeInBounce"
		});
	});
</script>

	<title><tiles:insertAttribute name="title" /></title>
	
</head>
<body>
	
	<!-- <div id="outer_wrap"> -->
	
		<!-- <header> -->
			<tiles:insertAttribute name="header" />
		<!-- </header> -->
	
	<!--<div id="wrap">  -->	
		<!-- 	<article> -->
			 	<tiles:insertAttribute name="body" />
		<!--</article>  -->	
			
			<footer>
        		<tiles:insertAttribute name="footer" />
        	</footer>
	<!-- 	</div> -->
		
 <!--    </div> -->
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>     	
</body>