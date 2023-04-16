<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Shadows+Into+Light&display=swap');



.logofont{
	font-family: 'Shadows Into Light', cursive;

	  color: gray; 
 	  margin-right:auto;
 	  margin-left:auto;
 	
}


.collapse{
	margin-right:180px;
}


.rounded{

	margin-left:180px;
	width: 130px;
}



</style>
<body>
<div id="head_link">
	   <nav class="navbar navbar-expand-md navbar-light fixed-top bg-white">
	    	 <a class="navbar-brand" href="${contextPath}/main/main.do"><img src="${contextPath}/resources/image/flower_logo.png" class="rounded  d-block" alt="logo"></a>
	    	
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="true" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      
  
      <div class="collapse navbar-collapse justify-content-end" id="navbarCollapse">
 		 <p class="logofont fs-4 mt-3">everyday beautiful</p>
        <ul class="navbar-nav">
    	
        <c:choose>
		   <c:when test="${isLogOn==true and not empty memberInfo }">
          <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/member/logout.do"><p class="menuFont fs-6 mt-3 fw-semibold">로그아웃</p></a><!-- 로그아웃 -->
          </li>
       
          <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/mypage/myPageMain.do"><p class="menuFont fs-6 mt-3 fw-semibold">마이페이지</p></a><!-- 마이페이지 -->
          </li>
          
           <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/cart/myCartList.do"><p class="menuFont fs-6 mt-3 fw-semibold">장바구니</p></a><!-- 장바구니 -->
          </li>
          </c:when>
		  <c:otherwise>
           <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/member/loginForm.do"><p class="menuFont fs-6 mt-3 fw-semibold">로그인</p></a><!-- 로그인 -->
          </li>
        
           <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/member/memberForm.do"><p class="menuFont fs-6 mt-3 fw-semibold">회원가입</p></a>
          </li> 
          </c:otherwise>
		 </c:choose>
		 
		
		 
         <li class="nav-item">
           <a class="nav-link mt-2" href="${contextPath}/board/listArticles.do"><p class="menuFont fs-6 mt-3 fw-semibold">Q&A</p></a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/review/reviewList.do"><p class="menuFont fs-6 mt-3 fw-semibold">리뷰게시판</p></a>
          </li>
           <c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">  
        	
            <li class="nav-item">
        
            <a class="nav-link mt-2" href="${contextPath}/admin/goods/adminGoodsMain.do"><p class="menuFont fs-6 mt-3 fw-semibold">상품관리</p></a>
          </li>
            <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/admin/order/adminOrderMain.do"><p class="menuFont fs-6 mt-3 fw-semibold">주문관리</p></a>
          </li>
            <li class="nav-item">
            <a class="nav-link mt-2" href="${contextPath}/admin/member/adminMemberMain.do"><p class="menuFont fs-6 mt-3 fw-semibold">회원관리</p></a>
          </li>
           </c:if>
        </ul>
 
     </div>
    
    </nav>
     
 </div>
  
</body>
</html>