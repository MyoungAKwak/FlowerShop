<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
function search_goods_list(fixeSearchPeriod){
	var formObj=document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name="fixedSearchPeriod";
	i_fixedSearch_period.value=searchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/admin/goods/adminGoodsMain.do";
    formObj.submit();
}


function  calcPeriod(search_period){
	var dt = new Date();
	var beginYear,endYear;
	var beginMonth,endMonth;
	var beginDay,endDay;
	var beginDate,endDate;
	
	endYear = dt.getFullYear();
	endMonth = dt.getMonth()+1;
	endDay = dt.getDate();
	if(search_period=='today'){
		beginYear=endYear;
		beginMonth=endMonth;
		beginDay=endDay;
	}else if(search_period=='one_week'){
		beginYear=dt.getFullYear();
		beginMonth=dt.getMonth()+1;
		dt.setDate(endDay-7);
		beginDay=dt.getDate();
		
	}else if(search_period=='two_week'){
		beginYear = dt.getFullYear();
		beginMonth = dt.getMonth()+1;
		dt.setDate(endDay-14);
		beginDay=dt.getDate();
	}else if(search_period=='one_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-1);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='two_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-2);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='three_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-3);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='four_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-4);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}
	
	if(beginMonth <10){
		beginMonth='0'+beginMonth;
		if(beginDay<10){
			beginDay='0'+beginDay;
		}
	}
	if(endMonth <10){
		endMonth='0'+endMonth;
		if(endDay<10){
			endDay='0'+endDay;
		}
	}
	endDate=endYear+'-'+endMonth +'-'+endDay;
	beginDate=beginYear+'-'+beginMonth +'-'+beginDay;
	//alert(beginDate+","+endDate);
	return beginDate+","+endDate;
}



	
</script>

<style>
.adminGoodsMainContainer{
display:flex;
justify-content: center;
flex-direction: column;
align-items: center;
margin-top:150px;
margin-left: auto;
margin-right:auto;



}

.page-link{
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 

}

.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
.banner{
	
	margin-top:100px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
.tableContainer{
width:1100px;
}
.tableContainer2{
width:1100px;
}
</style>
</head>
<body>
	<div class="adminGoodsMainContainer">
<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/admin_goods.png" class="img-fluid" alt="admin">
	        </div>

	   
	   	<div class="tableContainer mt-3">
	     <form  method="post">	 
	      <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col">	   <p class="fs-3 "><i class="bi bi-gift"></i>&nbsp;상품  조회 / 등록</p></th>
             <th scope="col"></th>
             <th scope="col"></th>
           </tr>
         </thead>	
         
		  <tbody class="table-group-divider">
          <tr>
          <th scope="row">
          <input type="radio" name="r_search"  checked/> 등록일조회 
		  <input type="radio" name="r_search" /> 상세조회
          </th>
          <td></td>
          <td></td>
          </tr>
          
		
				<TR >
					<TD>
					  <select name="curYear">
					    <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${endYear==endYear-i}">
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
					        <c:when test="${endDay==i}">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${i }">${i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>일  &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp; 
					<a href="javascript:search_goods_list('today')">
					   <img   src="${contextPath}/resources/image/btn_search_one_day.jpg">
					</a>
					<a href="javascript:search_goods_list('one_week')">
					   <img   src="${contextPath}/resources/image/btn_search_1_week.jpg">
					</a>
					<a href="javascript:search_goods_list('two_week')">
					   <img   src="${contextPath}/resources/image/btn_search_2_week.jpg">
					</a>
					<a href="javascript:search_goods_list('one_month')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_1_month.jpg">
					</a>
					<a href="javascript:search_goods_list('two_month')">
					   <img   src="${contextPath}/resources/image/btn_search_2_month.jpg">
					</a>
					<a href="javascript:search_goods_list('three_month')">
					   <img   src="${contextPath}/resources/image/btn_search_3_month.jpg">
					</a>
					<a href="javascript:search_goods_list('four_month')">
					   <img   src="${contextPath}/resources/image/btn_search_4_month.jpg">
					</a>
					&nbsp;까지 조회
					</TD>
					<td></td>
					<td></td>
				</TR>
				<tr>
				  <td>
				    <select name="search_condition" disabled >
						<option value="전체" checked>전체</option>
						<option value="제품번호">상품번호</option>
						<option value="제품이름">상품이름</option>
						<option value="제조사">제조사</option>
					</select>
					<input  type="text"  size="30"  disabled/>  
						 <a class="btn btn-dark btn-sm mb-1" style="background-color:#BEACC4; border-color:white; " href="#" role="button" disabled>조회</a>
				  </td>
				  <td></td>
				  <td></td>
				</tr>
				<tr>
				  <td>
					조회한 기간:<input  type="text"  size="4" value="${beginYear}" />년
							<input  type="text"  size="4" value="${beginMonth}"/>월	
							 <input  type="text"  size="4" value="${beginDay}"/>일	
							 &nbsp; ~
							<input  type="text"  size="4" value="${endYear }" />년 
							<input  type="text"  size="4" value="${endMonth }"/>월	
							 <input  type="text"  size="4" value="${endDay }"/>일							 
				  </td>
				  <td></td>
				  <td></td>
				</tr>
			</TBODY>
		</TABLE>
	
</form>	
</div>

		<div class="tableContainer2  mt-1">
		   <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col">상품번호</th>
             <th scope="col">상품이름</th>
             <th scope="col">상품가격</th>
             <th scope="col">생산일</th>
           </tr>
         </thead>
	
   <c:choose>
     <c:when test="${empty newGoodsList }">			
		  <tbody class="table-group-divider">
          <tr>
          <th scope="row">조회된 상품이 없습니다</th>
          <td></td>
          <td></td>
          <td></td>
          </tr>
         
	 </c:when>
	 <c:otherwise>
     <c:forEach var="item" items="${newGoodsList }">
			 
			   <tr>  
				<td scope="row">
				 ${item.goods_id }
				</td>
				
				<td>
				 <a href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}">
				
				   ${item.goods_title }
			
				 </a> 
				</td>
				
				<td>
				  ${item.goods_sales_price }
				</td>
				
				<td>
				 ${item.goods_credate }
				</td>

			</TR>

	</c:forEach>
	</c:otherwise>
  </c:choose>

	
	</TBODY>
	</TABLE>
	</div>
			<nav aria-label="Page navigation example ">
			  <ul class="pagination justify-content-center  ">
			    <c:forEach   var="page" begin="1" end="10" step="1" >
			     <c:if test="${section >1 && page==1 }">
			    <li class="page-item"><a class="page-link  " href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }" ></a></li>
			   	</c:if>
			    <li class="page-item"><a class="page-link" href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}" >${(section-1)*10 +page }</a></li>
			     <c:if test="${page ==10 }">
			    <li class="page-item"><a class="page-link" href="${contextPath}/admin/goods/adminGooodsMain.do?chapter=${section+1}&pageNum=${section*10+1}" >Next</a></li>
			     </c:if> 
			     	</c:forEach> 
				  </ul>
			</nav>
	
	
	

<DIV id="search" class="mt-3">

	<form action="${contextPath}/admin/goods/addNewGoodsForm.do">
	
	<button class="btn btn-dark btn-lg " type="submit" id="button-addon1"style="background-color:#BEACC4; border-color:white; ">상품 등록하기</button>
	</form>
</DIV>

</div>

</body>
</html>