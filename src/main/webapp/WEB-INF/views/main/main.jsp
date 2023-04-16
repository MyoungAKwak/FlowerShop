<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
 
<%

  request.setCharacterEncoding("UTF-8");
%>  
 
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
.container{
	display: flex;
	flex-direction: column;
	justify-content: center;
	
	
	
}

#aaa:hover{
	 color:#C1AEEE;
}

.statusFont{
font-family: 'Shadows Into Light', cursive;


}
.card-title{
font-family: 'Gowun Dodum', sans-serif;
}
</style>

<script type="text/javascript">
//♣♣♣♣ 시작
var loopSearch=true;
function keywordSearch(){
	if(loopSearch==false)
		return;
 var value=document.frmSearch.searchWord.value;
	$.ajax({
		type : "get",
		async : true, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/goods/keywordSearch.do",
		data : {keyword:value},
		success : function(data, textStatus) {
			if(data !=null && data != "")
		    var jsonInfo = JSON.parse(data);
			displayResult(jsonInfo);
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax	
}

function displayResult(jsonInfo){
	if(jsonInfo !=null && jsonInfo != "")
	var count = jsonInfo.keyword.length;
	if(count > 0) {
	    var html = '';
	    for(var i in jsonInfo.keyword){
		   html += "<a id='aaa' href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
	    }
	    var listView = document.getElementById("suggestList");
	    listView.innerHTML = html;
	    show('suggest');
	}else{
	    hide('suggest');
	} 
}

//♣♣♣♣ 끝

	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 /* loopSearch = false; */
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}

	

</script>



<!-- 캐러셀-->
<br><br><br>
<div id="myCarousel">
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-interval="2000" >
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${contextPath}/resources/image/carousel01.jpg" class="d-block w-100" >
    </div>
    <div class="carousel-item">
      <img src="${contextPath}/resources/image/Carousel02.jpg" class="d-block w-100" >
    </div>
    <div class="carousel-item">
      <img src="${contextPath}/resources/image/Carousel03.jpg" class="d-block w-100" >
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</div>
<!--  -->

<!--♣♣♣♣ 시작-->
<!-- 검색 -->
<div class="container mt-5">
<div class="row mt-1 justify-content-center">
<form class="d-flex col-4" role="search" action="${contextPath}/goods/searchGoods.do" name="frmSearch">
	<input class="form-control me-2 w-10 " type="text" placeholder="오늘의 꽃을 검색해보세요" aria-label="Search"  name="searchWord" onKeyUp="keywordSearch()">
	<button class="btn btn-outline-Secondary " type="submit" style="background-color:#BEACC4; border-color:white; "><i class="bi bi-search" style="color:white;"></i></button>
</form>
</div>
 <div id="suggest">
 <div class="row mt-1 justify-content-center">
<div id="suggestList" class="col-4" ></div>
</div>
</div>
</div>

<!--♣♣♣♣ 끝-->


<!-- // -->  	
 
<div class="container"> 	

<div class="main_book">
   <c:set  var="goods_count" value="0" />
   
   <div class="row mt-5">
	<p class="statusFont fs-2 fw-bold text-decoration-underline">BEST</p>
	<p class="fs-6 fw-lighter" style="color:gray;">고객님들이 셀렉한 베스트 아이템</p>
	
	</div>
	
	<div class="row row-cols-1 row-cols-md-5 g-4  ">
	<c:forEach var="item" items="${goodsMap.bestseller }">
	<c:set  var="goods_count" value="${goods_count+1 }" />
  <div class="col">
    <div class="card h-100 border-light shadow p-3 mb-5 bg-body rounded-0">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"><img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="..."></a>
      <div class="card-body">
        <h5 class="card-title">${item.goods_title }</h5>
        <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
        <fmt:formatNumber value="${item.goods_sales_price}" type="number" var="goods_sales_price"/>
        <p class="card-text pt-2 text-decoration-line-through "> ${goods_price}원</p>
        <p class="card-text"> ${goods_sales_price}원</p>
      </div>
    </div>
  </div>

        

   </c:forEach>
  </div>
</div>
	
	
	
	




<div class="main_book" >
<c:set  var="goods_count" value="0" />
		 <div class="row mt-4">
		
		<p class="statusFont fs-2 fw-bold text-decoration-underline mt-5">NEW </p>
		<p class="fs-6 fw-lighter" style="color:gray;">새롭게 입고된 신상품들을 만나보세요</p>
		</div>
		
		
	<div class="row row-cols-1 row-cols-md-5 g-4">
	<c:forEach var="item" items="${goodsMap.newbook  }">
	<c:set  var="goods_count" value="${goods_count+1 }" />
  <div class="col">
    <div class="card h-100 border-light shadow p-3 mb-5 bg-body rounded-0 ">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"><img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="..."></a>
      <div class="card-body">
        <h5 class="card-title">${item.goods_title }</h5>
        <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
        <fmt:formatNumber value="${item.goods_sales_price}" type="number" var="goods_sales_price"/>
       
        <p class="card-text pt-2 text-decoration-line-through"> ${goods_price}원</p>
       <p class="card-text"> ${goods_sales_price}원</p>
      </div>
    </div>
  </div>
   </c:forEach>
  </div>
	</div>	
	







<div class="main_book" >
<c:set  var="goods_count" value="0" />
		 <div class="row mt-4">
		<p class="statusFont fs-2 fw-bold text-decoration-underline mt-5">STEADY</p>
		<p class="fs-6 fw-lighter" style="color:gray;">고객님들에게 꾸준한 사랑을 받는 아이템</p>
		</div>
		
		<div class="row row-cols-1 row-cols-md-5 g-4 " >
	<c:forEach var="item" items="${goodsMap.steadyseller  }">
	<c:set  var="goods_count" value="${goods_count+1 }" />
	  <div class="col">
	    <div class="card h-100 border-light shadow p-3 mb-5 bg-body rounded-0">
	      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"><img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" class="card-img-top" alt="..."></a>
	      <div class="card-body ">
	        <h5 class="card-title">${item.goods_title }</h5>
	        <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
	        <fmt:formatNumber value="${item.goods_sales_price}" type="number" var="goods_sales_price"/>
	        <p class="card-text pt-2 text-decoration-line-through"> ${goods_price}원</p>
	        <p class="card-text"> ${goods_sales_price}원</p>
	      </div>
	    </div>
	  </div>
	   </c:forEach>
	  </div>
		</div>
		
</div>