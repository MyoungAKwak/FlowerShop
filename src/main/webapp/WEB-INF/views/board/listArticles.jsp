<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today" /> <!-- 현재시간을 숫자로 -->
<c:set var="articlesList" value="${articlesMap.articlesList}"/>
<c:set var="section" value="${articlesMap.section}"/>
<c:set var="pageNum" value="${articlesMap.pageNum}"/>
<c:set var="totArticles" value="${articlesMap.totArticles}"/>
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
 <style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:right; font-size:20px;}
table {
  border-collapse: collapse;
  border-spacing: 0;
}
section.notice {
  padding: 80px 0;
}

.page-title {
  margin-bottom: 60px;
}
.page-title h3 {
  font-size: 28px;
  color: #333333;
  font-weight: 400;
  text-align: center;
}

#board-search .search-window {
  padding: 15px 0;
  background-color: #f9f7f9;
}
#board-search .search-window .search-wrap {
  position: relative;
/*   padding-right: 124px; */
  margin: 0 auto;
  width: 80%;
  max-width: 564px;
}
#board-search .search-window .search-wrap input {
  height: 40px;
  width: 100%;
  font-size: 14px;
  padding: 7px 14px;
  border: 1px solid #ccc;
}
#board-search .search-window .search-wrap input:focus {
  border-color: #333;
  outline: 0;
  border-width: 1px;
}
#board-search .search-window .search-wrap .btn {
  position: absolute;
  right: 0;
  top: 0;
  bottom: 0;
  width: 108px;
  padding: 0;
  font-size: 16px;
}

.board-table {
  font-size: 13px;
  width: 100%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.board-table a {
  color: #333;
  display: inline-block;
  line-height: 1.4;
  word-break: break-all;
  vertical-align: middle;
}
.board-table a:hover {
  text-decoration: underline;
}
.board-table th {
  text-align: center;
}

.board-table .th-num {
  width: 100px;
  text-align: center;
}

.board-table .th-date {
  width: 200px;
}

.board-table th, .board-table td {
  padding: 14px 0;
}

.board-table tbody td {
  border-top: 1px solid #e7e7e7;
  text-align: center;
}

.board-table tbody th {
  padding-left: 28px;
  padding-right: 14px;
  border-top: 1px solid #e7e7e7;
  text-align: left;
}

.board-table tbody th p{
  display: none;
}



.btn-dark {
  background: #555;
  color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
  background: #373737;
  border-color: #373737;
  color: #fff;
}

.btn-dark {
  background: #555;
  color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
  background: #373737;
  border-color: #373737;
  color: #fff;
}

* {
  list-style: none;
  text-decoration: none;
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}
.clearfix:after {
  content: '';
  display: block;
  clear: both;
}
.container {
  width: 1100px;
  margin: 0 auto;
  margin-top:100px;
}
.blind {
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  margin: -1px;
  width: 1px;
  height: 1px;
}
.cls2{
	display:flex;
	justify-content:center;
	
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

  </style>
  <meta charset="UTF-8">
  <title>글목록창</title>
</head>
<script>
	function fn_articleForm(isLogOn,articleForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=articleForm;
	  }else{
	    alert("로그인 후 글쓰기가 가능합니다.")
	    location.href=loginForm+'?action=/board/articleForm.do';
	  }
	}
</script>
<body>
<section class="notice" >
	  <div class="page-title mt-5" align="left">
	        <div class="container " align ="center">
	            <img src="${contextPath}/resources/image/Q&A.png" class="img-fluid" alt="Q&A">
	        </div>
	  </div>
<div id="board-list"  >
    <div class="container">
        <table class="board-table mb-5">
              <thead>
                <tr align="left">
                    <th scope="col" class="th-num">번호</th>
                     <th scope="col" class="th-title">작성자</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-date">등록일</th>
                    <th scope="col" class="th-date">조회수</th>
                </tr>
               </thead>
<tbody>
 <c:choose>
  <c:when test="${noticeList!=null }" >
  <c:forEach  var="notice" items="${noticeList}" >
    <tr align="center">
	<td width="5%">공지</td>
	<td width="10%">${notice.member_id}</td>
	<td text-align="left"  width="35%">
	<span style="padding-right:10px"></span>
         <c:choose>
	      <c:when test='${notice.level > 1 }'>  
	         <c:forEach begin="1" end="${notice.level}" step="1">
	              <span style="padding-left:20px"></span>    
	         </c:forEach>
	         <span style="font-size:12px;"></span>
                   <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${notice.articleNO}">${notice.title}</a>
	          </c:when>
	          <c:otherwise>
	            <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${notice.articleNO}">${notice.title }</a>    
	          </c:otherwise>
	        </c:choose>
	  </td>
	  <td  width="10%">${notice.writeDate}</td> 
	  <td  width="10%">${notice.cnt}</td> 
	</tr>
    </c:forEach>
    </c:when>
    </c:choose>
<c:choose>
  <c:when test="${articlesList ==null }" >
    <tr height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  
    <c:when test="${articlesList !=null }">
    <c:forEach  var="article" items="${articlesList}" varStatus="articleNum" >
     <tr align="center">
	<td width="5%">${articleNum.count}</td>
	<td width="10%">${article.member_id}</td>
	<td align='left'  width="35%">
	  <span style="padding-right:30px"></span>
	   <c:choose>
	      <c:when test='${article.level> 1 }'>  
	      
	         <c:forEach begin="1" end="${article.level}" step="1">
	              <span style="padding-left:20px"></span>    
	         </c:forEach>
	         <img src="${contextPath}/resources/image/reply3.png" style="width: 20px; height: 20px">
                   <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>
	          </c:when>
	          <c:otherwise>
	     
	            <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
	          </c:otherwise>
	        </c:choose>
	   </td>
	  <td  width="10%">${article.writeDate}</td> 
	  <td  width="10%">${article.cnt}</td> 
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
   </tbody>
         </table>
         
          <div align="right" > 
		  <a class="cls1 " href="javascript:fn_articleForm('${isLogOn}','${contextPath}/board/articleForm.do','${contextPath}/member/loginForm.do')">
		  <button class="btn btn-secondary btn-lg mb-5 " style="background-color:#BEACC4; border-color:white; ">글쓰기</button></a>
		  
		   </div>
		   
          </div>
          </div>
          
          
  <div class="cls2 mb-3">
  <nav aria-label="Page navigation example ">
			  <ul class="pagination justify-content-center  ">
			    <c:if test="${totArticles != null }" >
			    <c:forEach   var="page" begin="1" end="10" step="1" >
			     <c:if test="${section >1 && page==1 }">
			    <li class="page-item"><a class="page-link  " href="${contextPath }/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }" >pre</a></li>
			   	</c:if>
			    <li class="page-item"><a class="page-link" href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
			     <c:if test="${page ==10 }">
			    <li class="page-item"><a class="page-link" href="${contextPath }/board/listArticles.do?section=${section+1}&pageNum=${section*10+1}" >Next</a></li>
			     </c:if> 
			     	</c:forEach> 
			     	</c:if>
				  </ul>
			</nav>
  
  
</div>    
          </section>
          
       




</body>
</html>