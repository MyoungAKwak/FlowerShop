<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
<title>글쓰기창</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview').attr('src', e.target.result);
          }
         reader.readAsDataURL(input.files[0]);
      }
  }  
  function backToList(obj){
    obj.action="${contextPath}/board/listArticles.do";
    obj.submit();
  }
  
  var cnt=1;
  function fn_addFile(){
	  $("#d_file").append("<br>"+"<input type='file' name='file"+cnt+"' />");
	  cnt++;
  }  

</script>
<style>
.container{
  display: flex;
	justify-content:center;
	flex-direction: column;
	align-items: center;
	margin-top:150px;
	margin-left: auto;
	margin-right:auto;
	width : 100%;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
   color:gray;
   }
</style>
 <title>글쓰기창</title>
</head>
<body>

<div class="container">
<div class="banner w-50" align ="center">
	            <img src="${contextPath}/resources/image/Q&A.png" class="img-fluid" alt="Q&A">
	        </div>

	
  <form name="articleForm" method="post" action="${contextPath}/board/addNewArticle.do"   enctype="multipart/form-data">
     <hr class="border border border-2 opacity-50 ">
    <table class="table-borderless">
    <thead class="table">
    <tr>
    <th scope="col"><p class="fs-3"><i class="bi bi-pencil-square" ></i>&nbsp;글작성</p></th>
    </tr>
    </thead>
    <c:choose>
       <c:when test="${memberInfo.member_id=='admin'}">
       		<tbody>
            <tr>
		    <th class="row"></th>
		 

			<td><input type="radio" name="type" value="f" /><label>공지글&nbsp;</label>
			<input type="radio" name="type" value="t" /><label>일반글</label></td>
			</tr>
			</c:when>
			
			 <c:otherwise>
			 <tr>
		    <th class="row">분류</th>
			 <td><input type="radio" name="type" value="t" checked /><label>일반글</label></td>
			</tr>
			
			 </c:otherwise>
      </c:choose>
		
			
      		<tr >
			<th scope="row">작성자</th>
			
			<td>
			<input type="text"   class="form-control mt-3" aria-label="Sizing example input"
    		 aria-describedby="inputGroup-sizing-sm" value="${memberInfo.member_name }"  disabled  style="width:200px; background:white; ">
			</td>
			
			</tr>
			
	     	<tr>
	     	<th scope="row">글제목</th>
			<td>
			<input type="text"   name="title" class="form-control mt-3" aria-label="Sizing example input"
    		 aria-describedby="inputGroup-sizing-sm" >
    		 </td>
			 </tr>
			 
	 		<tr>
	 			<th scope="row">글내용</th>
				<td>
				 <textarea    class="form-control mt-3"  name="content"  
		  		  style="height: 300px; width: 600px; resize: none;">${article.content}</textarea>
				</td>
   			</tr>

	    <tr>
	      <th scope="row"></th>
	    	<td>
	    	<div class="wrap mt-3">
	    	 <input type="submit" class="btn btn-secondary  btn-sm "style="background-color:#BEACC4; border-color:white; " value="글쓰기" >
	      	<input type="button" class="btn btn-secondary btn-sm "style="background-color:#BEACC4; border-color:white; " value="목록보기" onClick="backToList(this.form)">
	      </div>
	      </td>
    	 </tr>
  
  	</tbody>
    </table>
  </form>
  </div>
</body>