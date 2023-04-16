<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
	window.onload=function()
	{
	  init();
	}
	
	function init(){
		alert("주문을 취소했습니다.");
	}
	</script>
</c:if>
<script>
function fn_cancel_order(order_id){
	var answer=confirm("주문을 취소하시겠습니까?");
	if(answer==true){
		var formObj=document.createElement("form");
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
		
	    formObj.appendChild(i_order_id);
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
	    formObj.submit();	
	}
}

</script>
<style>
.myPageContainer{

display:flex;
justify-content: center;
flex-direction: column;


margin-top:150px;
width : 1100px;
margin-left: auto;
margin-right: auto;
}
.banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
   
</style>
</head>
<body>
<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/mypage.png" class="img-fluid" alt="mypage">
	        </div>

<div class="myPageContainer">
	 
	 
	  <p class="fs-3 ">최근 주문 내역
	  <a class="btn btn-secondary btn-sm " style="background-color:#BEACC4; border-color:white; " href="${contextPath}/mypage/listMyOrderHistory.do" role="button"
	    style= "--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem; ">더 보기</a>
	   </p>
	
      <table class="table table-hover">
       
        <thead class="table">
          <tr>
            <th scope="col">주문번호</th>
            <th scope="col">주문일자</th>
            <th scope="col">주문상품</th>
            <th scope="col">주문상태</th>
            <th scope="col">주문취소</th>
          </tr>
        </thead>
        <c:choose>
       <c:when test="${ empty myOrderList  }">
       <tbody class="table-group">
           <tr>
		      <th scope="col">
		        	<p>주문한 상품이 없습니다.</p>
		      </th>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		   </tr>
		</tbody>
	  </c:when>
      <c:otherwise>
      <c:forEach var="item" items="${myOrderList }"  varStatus="i">
       <c:choose> 
           <c:when test="${ pre_order_id != item.order_id}">
              <c:choose>
              <c:when test="${item.delivery_state=='delivery_prepared' }">
                <tr  bgcolor="lightgreen">    
              </c:when>
              <c:when test="${item.delivery_state=='finished_delivering' }">
                <tr  bgcolor="lightgray">    
              </c:when>
              <c:otherwise>
                <tr  bgcolor="orange">   
              </c:otherwise>
            </c:choose> 
		   
        <tbody class="table-group">
          <tr>
            <th scope="row">   <a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span>  </a></th>
            <td>${item.pay_order_time }</td>
            <td>
              <c:forEach var="item2" items="${myOrderList}" varStatus="j">
              <c:if  test="${item.order_id ==item2.order_id}" >
                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }/${item.order_goods_qty }개</a><br>
             </c:if>   
      		 </c:forEach>
            </td>
            <td>
              <c:choose>
		        <c:when test="${item.delivery_state=='delivery_prepared' }">
		  	    	    배송준비중
		        </c:when>
		        <c:when test="${item.delivery_state=='delivering' }">
			   	        배송중
		        </c:when>
		        <c:when test="${item.delivery_state=='finished_delivering' }">
		   		        배송완료
		        </c:when>
		        <c:when test="${item.delivery_state=='cancel_order' }">
		  		         주문취소
		        </c:when>
		        <c:when test="${item.delivery_state=='returning_goods' }">
				           반품완료
		        </c:when>
		      </c:choose>
            </td>
            <td>
              <c:choose>
		       <c:when test="${item.delivery_state=='delivery_prepared'}">
		        <button type="button" class="btn btn-Secondary btn-sm" style="background-color:#BEACC4; border-color:white; "onClick="fn_cancel_order('${item.order_id}')" value="주문취소">주문취소</button>
		       </c:when>
		       <c:otherwise>	
		       <button type="button" class="btn btn-Secondary btn-sm" style="background-color:#BEACC4; border-color:white; "onClick="fn_cancel_order('${item.order_id}')" value="주문취소" disabled>주문취소</button>
             </c:otherwise>
     		 </c:choose>  
            </td>
          </tr>
             <c:set  var="pre_order_id" value="${item.order_id}" />
         </c:when>
          </c:choose>
		   </c:forEach>
		  </c:otherwise>
		  </c:choose> 	    
	</tbody>
	</table>
     
 
   
   	   <p class="fs-3  mt-5 ">나의 정보
	  <a class="btn btn-secondary btn-sm  "style="background-color:#BEACC4; border-color:white; "  href="${contextPath}/mypage/myDetailInfo.do" role="button"
	    style= "--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">더 보기</a>
	   </p>
      <table class="table table-hover mb-5">
        <thead class="table">
          <tr>
          
            <th scope="col">이메일</th>
            <th scope="col">연락처</th>
            <th scope="col">주소</th>
            <th scope="col">포인트</th>
          </tr>
        </thead>
        
        <tbody class="table-group">
          <tr>
            <th scope="row">${memberInfo.email1 }@${memberInfo.email2 }</th>
            <td>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</td>
            <td> 도로명:   ${memberInfo.roadAddress }<br>
  			지번: ${memberInfo.jibunAddress } </td>
  			<!-- 포인트 -->
            <td>${memberInfo.member_point}</td>
          
          </tr>
          </tbody>
          </table>





</div>

	


</body>
</html>