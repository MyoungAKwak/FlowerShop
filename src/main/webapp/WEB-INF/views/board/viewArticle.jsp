<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="article"  value="${articleVO}"  />


 
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
   <meta charset="UTF-8">
   <title>글보기</title>
   <style>
     #tr_file_upload{
       display:none;
     }
     #tr_btn_modify{
       display:none;
     }
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
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   <script type="text/javascript" >
     function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
     }
 
	 function fn_enable(obj){
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
	 }
	 
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/board/modArticle.do";
		 obj.submit();
	 }
	 
	 function fn_remove_article(url,articleNO){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
		 
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
	 }
	
function fn_reply_form(url,parentNO,type){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
		 
	     var parentNOInput = document.createElement("input");
	     parentNOInput.setAttribute("type","hidden");
	     parentNOInput.setAttribute("name","parentNO");
	     parentNOInput.setAttribute("value",parentNO);
	     form.appendChild(parentNOInput);

	     var typeInput = document.createElement("input");
	     typeInput.setAttribute("type","hidden");
	     typeInput.setAttribute("name","type");
	     typeInput.setAttribute("value",type);
	     form.appendChild(typeInput);
	     
	     document.body.appendChild(form);
		 form.submit(); 
	 }
	 
	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
		
 </script>
</head>
<body>
<div class="container">
<div class="banner w-50" align ="center">
	            <img src="${contextPath}/resources/image/Q&A.png" class="img-fluid" alt="Q&A">
	        </div>

  <form name="frmArticle" method="post"  action="${contextPath}"  enctype="multipart/form-data" >
  <hr class="border border border-2 opacity-50 ">
  
       <table class="table  table-borderless" >
              <thead class="table">
                <tr>
                    <th scope="col" ><p class="fs-3"><i class="bi bi-pencil-square"></i>&nbsp;글 조회</p></th>
                 
                    
                </tr>
               </thead>
  
    		<tbody>
    		<tr>
    		<th scope="row">
    		글번호
    		</th>
    		<td>
    		<input type="text"   class="form-control" aria-label="Sizing example input" 
    		 aria-describedby="inputGroup-sizing-sm" value="${article.articleNO }"  disabled style="width:200px; background:white; ">
    		
   			<input type="hidden" name="articleNO" value="${article.articleNO}"  />
    		</td>
    		</tr>
		  	
		  	<tr>
		  	<th scope="row">
		  	작성자
		  	</th>
		  	<td> 
		  	<input type="text"  class="form-control" aria-label="Sizing example input"
    		 aria-describedby="inputGroup-sizing-sm" value="${article.member_id }" name="writer"  disabled style="width:200px; background:white;">
		  
		  	</td>
		  	</tr>
		  	
		  	<tr>
		  	<th scope="row">
		  	글제목
		  	</th>
		  	<td>
		  	<input type="text"  class="form-control" aria-label="Sizing example input"
    		 aria-describedby="inputGroup-sizing-sm" value="${article.title}" name="title" id="i_title" disabled style="background:white;" >
		  	
		  	</td>
		  	</tr>
		  	
		  	<tr>
		  	<th scope="row">
		  	글내용
		  	</th>
		  	<td>
		  	  <textarea class="form-control" placeholder="꽃 말을 작성해 주세요" name="content" id="i_content"  disabled
		  	  style="height: 300px; width: 600px; background:white; resize: none">${article.content}</textarea>
		  	
		  	
		  	</td>
		  	</tr>
		  	
		  	<tr>
		  	<th scope="row">
		  	작성일
		  	</th>
		  	<td>
		  	  	<input type="text"  class="form-control" aria-label="Sizing example input"
    		 aria-describedby="inputGroup-sizing-sm" value="${article.writeDate}" name="title" id="i_title" disabled style="width:200px; background:white; ">
		  	
		  	</td>
		  	</tr>
			
			<tr id="tr_btn_modify">
		  	<th scope="row">
		  	</th>
		  	<td>
		  	<input type="button" class="btn btn-secondary btn-sm " style="background-color:#BEACC4; border-color:white; " value="수정반영하기" onClick="fn_modify_article(frmArticle)">
		  	<input type="button" class="btn btn-secondary btn-sm" style="background-color:#BEACC4; border-color:white; " value="취소" onClick="backToList(frmArticle)">
		  
		  	</td>
		    </tr>
		    
		  	
		    
		    <tr id="tr_btn">
		    <th scope="row">
		    </th>
		    <td>
		     <c:if test="${memberInfo.member_id == article.member_id ||memberInfo.member_id=='admin' }">
		     <input type="button"  class="btn btn-secondary btn-sm" style="background-color:#BEACC4; border-color:white; " value="수정하기" onClick="fn_enable(this.form)">
		    
		  	 <input type="button"  class="btn btn-secondary btn-sm " style="background-color:#BEACC4; border-color:white; " value="삭제하기" onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">
		  
	         </c:if>
	         <input type="button"   class="btn btn-secondary btn-sm " style="background-color:#BEACC4; border-color:white; " value="리스트로 돌아가기" onClick="backToList(this.form)" >
		    <c:if test="${memberInfo.member_id=='admin'}">
		      <input type="button" class="btn btn-secondary btn-sm " style="background-color:#BEACC4; border-color:white; " value="답글쓰기" onClick="fn_reply_form('${contextPath}/board/replyForm.do',${article.articleNO},${article.type})">  
	        </c:if>
		    </td>
		    </tr>
		    
		    
		  	</tbody>
		  	
		  	</table>
  	</form>
  	

 </div>
</body>