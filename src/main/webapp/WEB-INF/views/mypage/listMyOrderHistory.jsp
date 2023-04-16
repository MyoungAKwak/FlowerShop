<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">
<script>
function search_order_history(fixedSearchPeriod){
	var formObj=document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name="fixedSearchPeriod";
	i_fixedSearch_period.value=fixedSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/mypage/listMyOrderHistory.do";
    formObj.submit();
}

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
.myHistoryContainer{

display:flex;
justify-content: center;
flex-direction: column;
align-items: center;
margin-top:150px;
margin-left: auto;
margin-right:auto;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
   .wrap1{
   width: 1100px;
   }
   .wrap2{

	width: 1100px;

	}
   .banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}

</style>
</head>
<body>
<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/mypage.png" class="img-fluid" alt="mypage">
	        </div>
	  <div class="myHistoryContainer">
	   
  
        <div class="wrap1">
        <form  method="post">	    
        <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col"><p class="fs-3"><i class="bi bi-box-seam"></i>&nbsp;주문/배송 조회</p></th>
             <th scope="col"></th>
             <th scope="col"></th>
           </tr>
         </thead>
         
          <tbody class="table-group-divider">
          <tr>
          <th scope="row">
          <input type="radio" name="simple"  checked/> 간단조회 
		  <input type="radio" name="simple" /> 일간
		  <input type="radio" name="simple" /> 월간
          </th>
          <td></td>
          <td></td>
          </tr>
          
          <tr>
          <th scope="row">
          	  <select name="curYear">
					    <c:forEach   var="i" begin="0" end="5" >
					      <c:choose>
					        <c:when test="${endYear==endYear-i }">
					          <option value="${endYear}" selected>${endYear}</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${endYear-i }">${endYear-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 <select name="curMonth" >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${endMonth==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${i }">${i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					
					 <select name="curDay">
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${endDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${i }">${i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>일  &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp; 
					<a href="javascript:search_order_history('today')">
					   <img   src="${contextPath}/resources/image/btn_search_one_day.jpg">
					</a>
					<a href="javascript:search_order_history('one_week')">
					   <img   src="${contextPath}/resources/image/btn_search_1_week.jpg">
					</a>
					<a href="javascript:search_order_history('two_week')">
					   <img   src="${contextPath}/resources/image/btn_search_2_week.jpg">
					</a>
					<a href="javascript:search_order_history('one_month')">
					   <img   src="${contextPath}/resources/image/btn_search_1_month.jpg">
					</a>
					<a href="javascript:search_order_history('two_month')">
					   <img   src="${contextPath}/resources/image/btn_search_2_month.jpg">
					</a>
					<a href="javascript:search_order_history('three_month')">
					   <img   src="${contextPath}/resources/image/btn_search_3_month.jpg">
					</a>
					<a href="javascript:search_order_history('four_month')">
					   <img   src="${contextPath}/resources/image/btn_search_4_month.jpg">
					</a>
					&nbsp;까지 조회
					</th>
					  <td></td>
        	  <td></td>
        	  </tr>
        	  
        	  <tr>
        	  <th scope="row">
        	     <select name="search_condition">
					<option value="2015" checked>전체</option>
					<option value="2014">수령자</option>
					<option value="2013">주문자</option>
					<option value="2012">주문번호</option>
					</select>
					
					<input  type="text"  size="30" />  
					 <a class="btn btn-dark btn-sm mb-1"style="background-color:#BEACC4; border-color:white; " href="#" role="button">조회</a>
					
        	  </th>
        	    <td></td>
        	  <td></td>
        	  </tr>
        	  
        	  
        	  <tr>
        	  <th scope="row">
        	  	조회한 기간:<input  type="text"  size="4" value="${beginYear}" />년
				<input  type="text"  size="4" value="${beginMonth}"/>월	
				<input  type="text"  size="4" value="${beginDay}"/>일	
				 &nbsp; ~
				<input  type="text"  size="4" value="${endYear}" />년 
				<input  type="text"  size="4" value="${endMonth}"/>월	
				 <input  type="text"  size="4" value="${endDay}"/>일		
        	  </th>
        	  <td></td>
        	  <td></td>
         
          </tbody>
          </table>
          </form>
          </div>
          <div class="wrap2 mt-5">
          <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col">주문번호</th>
             <th scope="col">주문일자</th>
             <th scope="col">주문내역</th>
             <th scope="col">주문금액/수량</th>
             <th scope="col">주문상태</th>
             <th scope="col">주문자</th>
             <th scope="col">수령인</th>
             <th scope="col">주문취소</th>
           </tr>
         </thead>
         <c:choose>
    	 <c:when test="${empty myOrderHistList }">			
          <tbody class="table-group-divider">
          <tr>
          <th scope="row"> <p class="fs-5 ">주문한 상품이 없습니다.</p></th>
          <td></td>
         <td></td>	
         <td></td>
          <td></td>	
         <td></td>
          <td></td>	
         <td></td>
          </tr>
          </c:when>
          <c:otherwise> 
          <c:forEach var="item" items="${myOrderHistList }" varStatus="i">
          <c:choose>
          <c:when test="${item.order_id != pre_order_id }">   
          
          <tr>
          <th scope="row">  <a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }">
          <strong>${item.order_id }</strong></a>
          </th>
          
          <td>
          		 <strong>${item.pay_order_time }</strong> 
          </td>
          <td> 
			<c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
			<c:if  test="${item.order_id ==item2.order_id}" >
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }</a><br>
			</c:if>   
			</c:forEach>
		  </td>
		  
		  <td>
		     <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
			<c:if  test="${item.order_id ==item2.order_id}" >
			 ${item.goods_sales_price*item.order_goods_qty }원/${item.order_goods_qty }<br>
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
					       반품
					    </c:when>
				  </c:choose>
			  </td>
		  
			<td>
			${item.orderer_name }
		 	</td>
		  
		  	<td>
			${item.receiver_name }
			</td>
			<td></td>
         	
			<td>
			<c:choose>
			<c:when test="${item.delivery_state=='delivery_prepared'}">
			<input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소"  />
			</c:when>
			<c:otherwise>
			<input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소" disabled />
			</c:otherwise>
			</c:choose>
			</td>
		
         	 </tr>
          	<c:set  var="pre_order_id" value="${item.order_id }" />
			</c:when>	
			 </c:choose>		
			</c:forEach>
			</c:otherwise>
		   </c:choose>	
			   
          </tbody>
          </table>
        
       	</div>
       	   <a class="btn btn-secondary btn-md w-25 mt-5"style="background-color:#BEACC4; border-color:white; " href="${contextPath}/main/main.do" role="button">쇼핑계속하기</a>
   </div>
</body>
</html>