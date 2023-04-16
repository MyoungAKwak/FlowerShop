<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<c:set var="reviewList" value="${reviewsMap.reviewList}"/>
<c:set var="section" value="${reviewsMap.section}"/>
<c:set var="pageNum" value="${reviewsMap.pageNum}"/>
<c:set var="totArticles" value="${reviewsMap.totArticles}"/>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script type="text/javascript">



function fn_review_add(isLogOn,reviewForm,loginForm){
	if(isLogOn !='' && isLogOn !='false'){
		location.href=reviewForm;
	}else{
		alert("로그인 후에 리뷰작성이 가능합니다.");
		location.href=loginForm+'?action=/review/addNewReviewForm.do';
		
	}
	
	
}
function fn_enable(obj){
	 document.getElementById("i_title").disabled=false;
	 document.getElementById("i_content").disabled=false;
	 document.getElementById("i_imageFileName").disabled=false;
	 document.getElementById("tr_btn_modify").style.display="block";
	 document.getElementById("tr_file_upload").style.display="block";
	 document.getElementById("cnt").style.display="block";
	 document.getElementById("tr_btn").style.display="none";
	 
}

function fn_remove_review(url,reviewNO){
	 var form = document.createElement("form");
	 form.setAttribute("method", "post");
	 form.setAttribute("action", url);
    var reviewNOInput = document.createElement("input");
    reviewNOInput.setAttribute("type","hidden");
    reviewNOInput.setAttribute("name","reviewNO");
    reviewNOInput.setAttribute("value", reviewNO);
	 
    form.appendChild(reviewNOInput);
    document.body.appendChild(form);
    form.submit();

}

	
function reviewList(url){
	
	var form = document.createElement("form");
	 form.setAttribute("method", "get");
	 form.setAttribute("action", url);
	
	 /*별점  전송*/
	var review_star = $('#star').val();
	console.log(review_star);
	console.log(typeof star);
	 var review_starIn = document.createElement("input");
	 review_starIn.setAttribute("type","get");
	 review_starIn.setAttribute("name","review_star");
	 review_starIn.setAttribute("value", review_star);
	 
	  form.appendChild(review_starIn);
	  document.body.appendChild(form);
	  form.submit();
	
}
	
</script>
<style>
.reviewListcontainer{
	
 	margin-bottom: 150px; 
	    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;


}
.row{
margin: 100px 300px;
display: flex;
    flex-direction: row;
    justify-content: center;
}
.card{
float:left;
margin: 10px 30px;
}
.card:hover{
border-color : #6c757d;
border-radius: 0.375rem;

}
.imgbox{
width: 250px;
height: 250px;
}
img{
width:100%;
height:100%;
border-radius:0.375rem;
display: block;

}
#i_title{
text-overflow: ellipsis;
white-space: nowrap;
}

table tr td span{
text-overflow: ellipsis;
white-space: nowrap;
max-width: 10px;
}
.textReview{
margin-top: 40px;
}
.cls2{
	display:flex;
	justify-content:center;
	margin-top: 50px;
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
   
.searchTable{

margin-left : auto;
margin-right: auto;
}
</style>
</head>
<body>
	<div class="banner " align ="center">
	<img src="${contextPath}/resources/image/review.png" class="img-fluid" alt="review">
	 </div>
	<div class="reviewListcontainer">
	
		
	<div class="row"> 
			<p class="fs-3 pb-3 text-center"><i class="bi bi-image"></i>&nbsp;검색 결과</p>
			
	<table class="searchTable table table-borderless w-75">
	
 	<thead>
    <tr>
    
    <!-- 
      <th scope="col">
      <form class="starList">
      <select id ="star"  class="form-select form-select-md mb-3" aria-label=".form-select-lg example" onchange="reviewList('${contextPath}/review/reviewList.do')">
		<option>구분</option>
		<option value="0">ALL</option>
		<option value="1">⭐</option>
		<option value="2">⭐⭐</option>
		<option value="3">⭐⭐⭐</option>
		<option value="4">⭐⭐⭐⭐</option>
		<option value="5">⭐⭐⭐⭐⭐</option>
		</select>
		</form>
		</th>
		 -->
		
      <th scope="col">	
      	<form  name = "reviewSearch" action="${contextPath}/review/searchReview.do">
      <select  class="form-select form-select-md mb-3" aria-label=".form-select-lg example" name="search">
       <option value="goods">상품</option>
       <option value="member">작성자</option>
   	</select>
   	</th>
   	
      <th scope="col">	
      <input type="text" class="form-control mb-3" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="detail">
      </th>
      
      <th scope="col">	
      <input type="submit" value="검색"  class="btn btn-secondary btn-md  w-100 mb-3" style="background-color:#BEACC4; border-color:white; ">
      </th>
 	 <th>
   	<a class="btn btn-secondary btn-md w-100 mb-3 " style="background-color:#BEACC4; border-color:white; "
		href="javascript:fn_review_add('${isLogOn}','${contextPath}/review/addNewReviewForm.do','${contextPath}/member/loginForm.do')">리뷰 작성</a>
    
  </th>
    </tr>
  </form>
  </thead>
 
  </table>
	<c:choose>
		<c:when test="${empty reviewsList}">
		<div style="margin-left: 40px; text-align: center;">검색 결과가 없습니다.</div>
		</c:when>
		
	<c:otherwise>
	<c:forEach  var="review" items="${reviewsList}">

	<div class="card col-12"  style="width: 18rem;">
	<div class="imgbox">
	<br>
   <a href="${contextPath}/review/viewReview.do?review_no=${review.review_no}">
   <img src="${contextPath}/thumbnails.do?goods_id=${review.goods_id}&fileName=${review.fileName}" class="card-img-top" onerror="this.src='${contextPath}/resources/image/noPhoto.jpg';"> 
   </a>
  	</div>
  	<br>
  <div class="card-body">
    <h5 class="card-title" style= white-space:normal><a href="${contextPath}/goods/goodsDetail.do?=${review.goods_id}" id = "i_title">${review.goods_title} </a></h5>
	<br>

    <p class="card-text"><a href="${contextPath}/review/viewReview.do?review_no=${review.review_no}">${review.review_content}</a></p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">작성자  : ${review.member_id }</li>
    <li class="list-group-item">등록일  : ${review.review_date}</li>
    <li class="list-group-item">
      <c:forEach begin="1" end="${review.review_star}">
	⭐
    </c:forEach>
    </li>
    <li class="list-group-item">조회수 :  ${review.cnt} </li>
  </ul>
 
</div>
	</c:forEach>
	</c:otherwise>
	</c:choose>
   <div class="cls2">
  <nav aria-label="Page navigation example ">
			  <ul class="pagination justify-content-center  ">
			    <c:if test="${totArticles != null }" >
			    <c:forEach   var="page" begin="1" end="10" step="1" > 
			     <c:if test="${section >1 && page==1 }">
			    <li class="page-item"><a class="page-link  " href="${contextPath }/review/reviewList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }" >pre</a></li>
			   	</c:if>
			    <li class="page-item"><a class="page-link" href="${contextPath }/review/reviewList.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
			     <c:if test="${page ==10 }">
			    <li class="page-item"><a class="page-link" href="${contextPath }/review/reviewList.do?section=${section+1}&pageNum=${section*10+1}" >Next</a></li>
			     </c:if> 
			     	</c:forEach> 
			     	</c:if>
				  </ul>
			</nav>
</div>
</div>
	
	
	</div>
</body>
</html>