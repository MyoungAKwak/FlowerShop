<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
<style>
.resultContainer{
display:flex;
justify-content: center;
flex-direction: column;
align-items: center;
margin-top:150px;

}
.orderTitleFont{
	font-family: 'Gowun Batang', serif;
}
</style>
</head>
<BODY>

<div class="resultContainer">
<form name="form_result">

 <p class="fs-3 mb-3 fst-italic"><i class="bi bi-flower1"></i>&nbsp;최종주문내역</p>
	<table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col">주문상품명</th>
             <th scope="col">주문번호</th>
             <th scope="col">수량</th>
             <th scope="col">상품금액</th>
             <th scope="col">배송비</th>
             <th scope="col">포인트적립</th>
             <th scope="col">총 주문금액</th>
           </tr>
         </thead>
       
       <tbody class="table-group-divider">
			<TR>
				<c:forEach var="item" items="${myOrderList}">
				   <th scope="row">
				<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
				<span class="orderTitleFont fs-5 fw-semibold"> &nbsp;&nbsp;&nbsp;&nbsp;${item.goods_title}</span>
				   </a>
				   </th>
				   
				   	 <td> 
				   	 <p class="fs-6 mt-5">${item.order_id }</p>
				   	 </td>
				   	 
				    <td>
				<p class="fs-6 mt-5">${item.order_goods_qty }개</p>
         <%--     <input   type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.order_goods_qty}" /> --%>
                   </td>   
                   
                   <td>
               <p class="fs-6 mt-5">${item.goods_sales_price}원</p> 
                  </td>
                   <td>
                   <c:choose>
                   <c:when test="${item.goods_sales_price * item.order_goods_qty>=100000}">
                   <p class="fs-6 mt-5">무료</p> 
                   </c:when>
                   <c:otherwise>
                  <p class="fs-6 mt-5">${item.goods_delivery_price}원</p> 
                
                </c:otherwise>
                </c:choose>
                 </td>
                 
                  <td>
                  <p class="fs-6 mt-5"> ${item.goods_point*item.order_goods_qty}P</p> 
         	      
                 </td>
                 
                 <td>
            <p class="fs-6 mt-5">${item.goods_sales_price * item.order_goods_qty}원</p> 
            <%--  <input  type="hidden" id="h_each_goods_price"  name="h_each_goods_price" value="${item.goods_sales_price * item.order_goods_qty}" /> --%>
               </td>
               
			</TR>
			  </c:forEach>
		</TBODY>
		
	</TABLE>
	<DIV class="clear"></DIV>
	
	
<p class="fs-3 mb-1 fst-italic mt-5"><i class="bi bi-flower1"></i>&nbsp;배송정보</p>
<div class="detail_table">

<table  class="table table-hover">
		<thead>
		<tr>
		 <th scope="col"></th>
			 <th scope="col"></th>
             <th scope="col"></th>
             <th scope="col"></th>
             <th scope="col"></th>
             <th scope="col"></th>
             <th scope="col"></th>
             <th scope="col"></th>
		</tr>
		</thead>

	<tbody class="table-group-divider">
		<tr>
		<th scope="row">배송방법</th>
		
		<td>
		  ${myOrderInfo.delivery_method }
		</td>
		</tr>
		
		 <tr>
	     <th scope="row">받으실 분</th>
	     <TD>
         ${myOrderInfo.receiver_name }
		</TD>
	     </tr>
	     
	      <tr>
	     <th scope="row">휴대폰번호</th>
	     <TD>
        ${myOrderInfo.receiver_hp1}-${myOrderInfo.receiver_hp2}-${myOrderInfo.receiver_hp3}
		</TD>
	     </tr>
	     
	     <tr>
	     <th scope="row">유선전화(선택)</th>
	     <TD>
         ${myOrderInfo.receiver_tel1}-${myOrderInfo.receiver_tel2}-${myOrderInfo.receiver_tel3}
		</TD>
	     </tr>
	     
	      <tr>
	     <th scope="row">주소</th>
	     <TD>
         ${myOrderInfo.delivery_address}
		</TD>
	     </tr>
	     
	       <tr>
	     <th scope="row">배송 메시지</th>
	     <TD>
          ${myOrderInfo.delivery_message}
		</TD>
	     </tr>
	     
	       <tr>
	     <th scope="row">선물 포장</th>
	     <TD>
         ${myOrderInfo.gift_wrapping}
		</TD>
	     </tr>

	</tbody>
</table>
</div>	
	
<p class="fs-3 mb-1 fst-italic mt-5"><i class="bi bi-flower1"></i>&nbsp;주문고객</p>
<div class="detail_table">
  <table  class="table table-hover">
		<thead >
				<tr>
				  <th scope="col"></th>
				  <th scope="col"></th>
				  <th scope="col"></th>
				</tr>
		</thead>
        <tbody class="table-group-divider">
	        <tr>
			<th scope="row">주문자이름</th>
			<td>
			 <input  type="text" value="${orderer.member_name}" size="15" disabled />
			</td>
			
			</tr>
			<tr>
			<th scope="row">핸드폰</th>
			<td>
		    <input  type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" disabled />
		    </td>
			</tr>
			<tr>
			<th scope="row">이메일</th>
			<td>
			<input  type="text" value="${orderer.email1}${orderer.email2}" size="15" disabled />
			</td>
			</tr>
         </tbody>
</table>
</div>	
	
<p class="fs-3 mb-1 fst-italic mt-5"><i class="bi bi-flower1"></i>&nbsp;결제정보</p>
 <div class="detail_table">
  <table  class="table table-hover">
   <thead>
		<tr>
	   <th scope="col"> </th>
		 <th scope="col"></th>
	   <th scope="col"></th>
		</tr>
		</thead>

   <tbody class="table-group-divider">
        <tr>
		<th scope="row">결제정보</th>
		<td>
		  ${myOrderInfo.delivery_method}
		</td>
		</tr>
		<tr>
		<th scope="row">결제카드</th>
		<td>
		  ${myOrderInfo.card_com_name}
		</td>
		</tr>
		<tr>
		<th scope="row">할부기간</th>
		<td>
		 ${myOrderInfo.card_pay_month}
		</td>
		</tr>
	</tbody>
  </table>
 </div>	


</form>
</div>
</body>