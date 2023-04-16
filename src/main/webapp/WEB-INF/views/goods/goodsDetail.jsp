<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />
<c:set var="lenList"  value="${goodsMap.lenList }"  />
<c:set var="reviewList"  value="${goodsMap.reviewList }"  />


 <%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<html>
<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 150px;
	background-color: #f0f4f4;
	border: 2px ridge gray;
	border-radius: 15px;
	opacity: 0.7;
}

#close {
	z-index: 4;
	float: right;
}


.myGoodsContainer{
	display: flex;
	justify-content:space-evenly;
	flex-direction: row;
	align-items: center;
	margin-top:150px;
	
}


.tabs_container{
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top:70px;
	 
}

.tab_container{
    display: flex;
	justify-content: center;
	align-items: center;
	

}

.goodsTitleFont{
	font-family: 'Gowun Batang', serif;

}
li{
 float:left;
 margin-right: 20px;
 
}

.card:hover{
border-color : #BEACC4;
border-radius: 0.375rem;
border-width: 2.5px;

}
.imgbox{
width: 250px;
height: 250px;
}




</style>
<script type="text/javascript">
function add_cart(goods_id){
	   var order_goods_qty = document.getElementsByName("order_goods_qty")[0].value; 
	  
	    $.ajax({
	        type : "post",
	        async : false, //false인 경우 동기식으로 처리한다.

	        // Ajax를 이용해 장바구니에 추가할 상품 번호를 전송합니다.
	        url : "${contextPath}/cart/addGoodsInCart.do",
	        data : {goods_id:goods_id,
	            order_goods_qty:order_goods_qty},

	        success : function(data, textStatus) {
	            //alert(data);
	        //    $('#message').append(data);
	            // 장바구니에 추가하면 알림창을 표시합니다.
	            if(data.trim()=='add_success'){
	                imagePopup('open', '.layer01');

	            }else if(data.trim()=='already_existed'){
	                alert("이미 카트에 등록된 상품입니다.");
	            }

	        },
	        error : function(data, textStatus) {
	            alert("로그인 후 장바구니에 담을 수 있습니다.");
	        },
	        complete : function(data, textStatus) {
	            //alert("작업을완료 했습니다");
	        }
	    }); //end ajax
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
	
	var total_price,final_total_price;
	
	var order_goods_qty = document.getElementById("order_goods_qty");
		
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=			goods_id;
    i_order_goods_qty.value=	order_goods_qty.value;
    i_goods_title.value=		goods_title;
    i_goods_sales_price.value=	goods_sales_price;
    i_fileName.value=			fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}	
</script>
</head>
<body>

<div class="myGoodsContainer">
	
	<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}"  class="img-fluid rounded float-start ml-4 shadow p-3 mb-5 bg-body rounded-0" style=" width:440px;">

	<div id="detail_table">

		<table class="table table-hover">
			<thead>
		    <tr>
		      <th scope="col"><p class="fs-5 fst-italic">[${goods.goods_sort}]</p>
		      			      <h2 class="goodsTitleFont">${goods.goods_title}</h2></th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody class="table-group-divider">
		  
	  	<tr>
	      <th scope="row">정가</th>
	      <td></td>
	      <td><fmt:formatNumber  value="${goods.goods_price}" type="number" var="goods_price" />
 				 <p class="text-decoration-line-through">${goods_price}원 </p></td>
	   	  <td></td>
	    </tr>
	    
	    <tr>
	      <th scope="row">판매가</th>
	      <td></td>
	      <td><fmt:formatNumber  value="${goods.goods_sales_price}" type="number" var="goods_sales_price" />
	     	  <p>${goods_sales_price}원 </p></td>
	   	  <td></td>
	    </tr>
    	
    
      	<tr>
	      <th scope="row">포인트적립</th>
	      <td></td>
	      <td>${goods.goods_point}P</td>
	   	  <td></td>
	    </tr>
	    
	    	<tr>
	      <th scope="row">생산일</th>
	      <td></td>
	      <td><c:set var="pub_date" value="${goods.goods_published_date}" />
			  <c:set var="arr" value="${fn:split(pub_date,' ')}" />
			  <c:out value="${arr[0]}" /></td>
	   	  <td></td>
	    </tr>
    
    
    	<tr>
	      <th scope="row">배송비</th>
	      <td></td>
	      <td>${goods.goods_delivery_price}원</td>
	   	  <td></td>
	    </tr>
	    
	    <tr>
	      <th scope="row">배송안내</th>
	      <td></td>
	      <td><strong>[일반배송]</strong> 오늘 주문 시 내일 도착<br> 
	      	   <strong>[예약배송]</strong> 원하는 날짜에 도착
	   	  <td></td>
	    </tr>
	    
	     <tr>
	      <th scope="row">수량</th>
	       <td></td>
	      <td><select class="form-select"  aria-label="Default select example" id="order_goods_qty" name="order_goods_qty">
			<option selected value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
    		</select> </td>
	   	  <td></td>
	    </tr>
    
    	</tbody>
		</table>
		
		<div class="row">
		<a class="btn btn-dark mt-2" style="background-color:#BEACC4; border-color:white; " href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');" role="button">구매하기</a>
		<a class="btn btn-dark mt-2" style="background-color:#BEACC4; border-color:white; " href="javascript:add_cart('${goods.goods_id }')" role="button">장바구니담기</a>
		</div>
		
	</div>
	
	</div>
	
	
	
	<!-- 내용 들어 가는 곳 -->
	
		
		<div class="tabs_container mt-1">
		
		<ul class="tabs pb-auto">
			<li style="list-style:none;"><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab1" role="button"><i class="bi bi-flower3"></i>&nbsp;상품소개&nbsp;&nbsp;</a></li>
			<li style="list-style:none;"><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab2" role="button"><i class="bi bi-flower3"></i>&nbsp;꽃말&nbsp;&nbsp;</a></li>	
			<li style="list-style:none;"><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab3" role="button"><i class="bi bi-flower3"></i>&nbsp;리뷰&nbsp;&nbsp;</a></li>
		</ul> 
		</div> 
		
<div class="tab_container">
			<div class="tab_content" id="tab1">
				<c:forEach var="image" items="${imageList}">
					<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}" class="rounded mx-auto d-block w-75 mt-5 " >
				</c:forEach>
				
			</div>
			
			<div class="tab_content" id="tab2">
				<!-- <h4>꽃말</h4> -->
				 <c:forEach var="lenimage" items="${lenList}">
					<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${lenimage.lenfileName}" class="rounded mx-auto d-block w-75 mt-5" >
				</c:forEach> 
				
				
			</div>
			
			<div class="tab_content" id="tab3">
				<h4>리뷰</h4>
				
		<c:forEach  var="review" items="${reviewList}">
	<div class="card"  style="width: 18rem; float:left; margin: 10px 30px; ">
	<div class="imgbox">
	<br>
   <a href="${contextPath}/review/viewReview.do?review_no=${review.review_no}">
   <img 
   style="width:100%;
height:100%;
border-radius:0.375rem;
display: block;
    margin-left: 18px;
    margin-top: -10px;"
   src="${contextPath}/thumbnails.do?goods_id=${review.goods_id}&fileName=${review.fileName}" class="card-img-top" onerror="this.src='${contextPath}/resources/image/noPhoto.jpg';"> 
   </a>
  	</div>
  <div class="card-body">
    <p class="card-text"><a href="${contextPath}/review/viewReview.do?review_no=${review.review_no}">${review.review_content}</a></p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">작성자  : ${review.member_id }</li>
    <li class="list-group-item">
    <c:forEach begin="1" end="${review.review_star}">
	⭐
    </c:forEach>
    </li>
    <li class="list-group-item">조회수 :  ${review.cnt} </li>
    <li class="list-group-item">등록일  : ${review.review_date}</li>
  </ul>
 
</div>
	</c:forEach>
				
			</div>

		
</div>
		
	
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
			 <img
			src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br><p class="fs-6 fst-italic">장바구니에 담겼습니다</p>
			
<form action='${contextPath}/cart/myCartList.do'>				
		<h2><i class="bi bi-cart4"></i></h2>&nbsp;<button type="submit" class="btn btn-secondary ">장바구니 보러가기</button>
</form>

</div>
</div>
	


	


		
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>