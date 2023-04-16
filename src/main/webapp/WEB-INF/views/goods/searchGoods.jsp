<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set  var="item" value="${goodsList}" />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 

<head>
<style>
.searchContainer{
display:flex;
justify-content:center;

flex-direction:column;
margin-top:150px;
margin-left:auto;
margin-right:auto;
width:75%;

}
a{
	  text-decoration: none;
	   	color:grey;
}

.searchFont{
	font-family: 'Gowun Batang', serif;

}
.tabs_container{
display:flex;
 justify-content:flex-end;


} 
</style>


 <title>검색 상품 목록 페이지</title>
</head>
<body>
<div class="searchContainer"> 	
<p class="searchFont fs-2" >"${searchWord}" <span class="fs-4">검색결과 </span></p>


	<div class="tabs_container" >
		<ul class="tabs pb-auto">
		 <li style="list-style:none;float:left;">
		 &nbsp;
		    <a class="btn btn-outline-dark btn-lg" href="#tab1" role="button" aria-current="page" >ALL</a></li>
		 <li style="list-style:none;float:left;">
		 &nbsp;
		   <a class="btn btn-outline-dark btn-lg" href="#tab2" role="button">BEST</a></li>	
		 <li style="list-style:none;float:left;">
		 &nbsp;
		   <a class="btn btn-outline-dark btn-lg" href="#tab3" role="button">STEADY</a></li>	
		 <li style="list-style:none;float:left;">
		 &nbsp;
		    <a class="btn btn-outline-dark btn-lg" href="#tab4" role="button">NEW</a></li>
		   
		</ul>
	</div>

	<c:choose>
	   <c:when test="${empty goodsList  }" >
	    <div class="result mb-5 mt-5">
		 <p class="fs-3 mb-5 mt-5 fst-italic text-center">존재하지 않는 상품입니다.</p>	
		 </div>
	   </c:when>
   <c:otherwise>


<div class="tab_content" id="tab1">
   <c:set  var="goods_count" value="0" />
   
	<div class="row row-cols-1 row-cols-md-5 g-4 mt-3 mb-5">
	 <c:forEach var="item" items="${goodsList }" >
	<c:set  var="goods_count" value="${goods_count+1 }" />
  	<div class="col">
    <div class="card h-100">
    
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
      <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="...">
      </a>
      
      <div class="card-body">
      
     	<p class="card-text fs-5 fst-italic">[${item.goods_sort}]</p>
        <h5 class="card-title">${item.goods_title }</h5>
        
        <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
        <p class="card-text text-decoration-line-through pt-2"> ${goods_price}원</p>
        
        <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
	     <p class="card-text"> ${goods_sales_price}원 </p>
    
      </div>
		</div>
		</div>
		
	 	</c:forEach>
	 	
    </div>
   
	</div>
	
	

<!-- <div class="tab_container"> -->
 <!-- best -->
 <div class="tab_content" id="tab2">
   <h1>BEST</h1>
   
   <c:set  var="goods_count" value="0" />
	<div class="row row-cols-1 row-cols-md-5 g-4 mt-3 mb-5">
	 <c:forEach var="item" items="${goodsList }" >
	   <c:if test="${item.goods_status == 'bestseller'}"> 
	   <c:set  var="goods_count" value="${goods_count+1 }" />
  	<div class="col">
       <div class="card h-100">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
      <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="...">
      </a>
	      <div class="card-body">
	      <p class="card-text fs-5 fst-italic">[${item.goods_sort}]</p>
	      <h5 class="card-title">${item.goods_title }</h5> 
	      <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
	      <p class="card-text text-decoration-line-through pt-2"> ${goods_price}원</p>     
	      <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
		  <p class="card-text"> ${goods_sales_price}원 </p>
	       </div>
	   </div>
      </div>
      </c:if>
	 </c:forEach >

    </div>
    <c:if test="${goods_count == 0}">
    <p class="fs-3 mb-5 mt-5 fst-italic text-center">준비 중입니다.</p>
    </c:if>

 </div>
	
	
 <!-- steady -->
 <div class="tab_content" id="tab3">
   <h1>STEADY</h1>
   
   <c:set  var="goods_count" value="0" />
	<div class="row row-cols-1 row-cols-md-5 g-4 mt-3 mb-5">
	 <c:forEach var="item" items="${goodsList }" >
	   		<c:if test="${item.goods_status == 'steadyseller'}"> 
	<c:set  var="goods_count" value="${goods_count+1 }" />
  	<div class="col">
       <div class="card h-100">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
      <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="...">
      </a>
      <div class="card-body">
      <p class="card-text fs-5 fst-italic">[${item.goods_sort}]</p>
      <h5 class="card-title">${item.goods_title }</h5> 
      <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
      <p class="card-text text-decoration-line-through pt-2"> ${goods_price}원</p>     
      <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
	  <p class="card-text"> ${goods_sales_price}원 </p>
       </div>
	</div>
    </div>
		 </c:if>
	    </c:forEach>
    </div>
    <c:if test="${goods_count == 0}">
  <p class="fs-3 mb-5 mt-5 fst-italic text-center">준비 중입니다.</p>
</c:if>
 </div>




<div class="tab_content" id="tab4">
   <h1>NEW</h1>
   
   <c:set  var="goods_count" value="0" />
	<div class="row row-cols-1 row-cols-md-5 g-4 mt-3 mb-5">
	 <c:forEach var="item" items="${goodsList }" >
	   		<c:if test="${item.goods_status == 'newbook'}"> 
	<c:set  var="goods_count" value="${goods_count+1 }" />
  	<div class="col">
       <div class="card h-100">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
      <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="...">
      </a>
      <div class="card-body">
      <p class="card-text fs-5 fst-italic">[${item.goods_sort}]</p>
      <h5 class="card-title">${item.goods_title }</h5> 
      <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
      <p class="card-text text-decoration-line-through pt-2"> ${goods_price}원</p>     
      <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
	  <p class="card-text"> ${goods_sales_price}원 </p>
       </div>
	</div>
    </div>
		 </c:if>
		 
		 
	 </c:forEach>

    </div>
     <c:if test="${goods_count == 0}">
  <p class="fs-3 mb-5 mt-5 fst-italic text-center">준비 중입니다.</p>
</c:if>
 </div>

	
<!-- 	</div> -->
	
	
   </c:otherwise>
   </c:choose>
  </div>
 

</body>