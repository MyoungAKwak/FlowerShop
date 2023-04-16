<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 
<!-- 별점 -->
<link href=" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet"> rel="stylesheet">
<link href=" media="all" rel="stylesheet" type="text/css" />
<!-- optionally if you need to use a theme, then include the theme file as mentioned below -->
<link href=" media="all" rel="stylesheet" type="text/css" />
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
    obj.action="${contextPath}/review/reviewList.do";
    obj.submit();
  }
  
  var cnt=1;
  function fn_addFile(){
	  document.getElementById("d_fileList").style.display="block";
	  $("#d_file").append("<br>"+"<input type='file' name='file' class='form-control' "+cnt+"' />");
	  cnt++;
  }  

  var loopSearch=true;
  function keywordSearch(){
  	if(loopSearch==false)
  		return;
   var value=document.myform.goods_id.value;
   	console.log(value);
  	$.ajax({
  		type : "get",
  		async : true, //false인 경우 동기식으로 처리한다.
  		url : "${contextPath}/goods/keywordSearch.do",
  		data : {keyword:value},
  		success : function(data, textStatus) {
  			if(data !=null && data != "")
  		    var jsonInfo = JSON.parse(data);
  			displayResult(jsonInfo);
  		},
  		error : function(data, textStatus) {
  			alert("에러가 발생했습니다."+data);
  		},
  		complete : function(data, textStatus) {
  			//alert("작업을완료 했습니다");
  			
  		}
  	}); //end ajax	
  }
  
  
  function displayResult(jsonInfo){
		if(jsonInfo !=null && jsonInfo != "")
		var count = jsonInfo.keyword.length;
		if(count > 0) {
		    var html = '';
		    for(var i in jsonInfo.keyword){
			   html += "<a id='aaa' href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
  
  function select(selectedKeyword) {
	  document.myform.goods_id.value=selectedKeyword;
		 /* loopSearch = false; */
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}
  
  
  
  $('#input-id').on('review_star:change', function(event, value, caption) {
	    console.log(value);
	    console.log(caption);
	});
  
  $('#input-id').on('review_star:hover', function(event, value, caption, target) {
	    console.log(value);
	    console.log(caption);
	    console.log(target);
	});
</script>
 <title>글쓰기창</title>
 <style>
 .newReviewContainer{
 	display:flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margin-top:50px;
 }
 .form-control{
 resize:none;
 }
 select{
  width: 50px;
  height: 50px;
  background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
  background-size: 20px;
  padding: 5px 30px 5px 10px;
  border-radius: 4px;
  outline: 0 none;
}
#d_fileList{
display:none;
}
#preview{
border-radius: 30px;
}
fieldset{
 margin: 0px 70px 20px;
}
#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/1
    border: 0; /* 필드셋 테두리 제거 */
}
#myform input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#myform label{
    font-size: 3em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
       
}
#myform label:hover{
    text-shadow: 0 0 0 #BEACC4; /* 마우스 호버 */
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 #BEACC4; /* 마우스 호버 뒤에오는 이모지들 */
}
#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl; /* 이모지 순서 반전 */
    border: 0; /* 필드셋 테두리 제거 */
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #ffc107; /* 마우스 클릭 체크 */
}
.banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 50%;
	
}
.myformContainer{
margin-top:50px;

}
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
.fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
   #aaa:hover {
	color : #C1AEEE;
}
 </style>
</head>
<body>
 	
    <!-- 부트 -->
   
   
    <div class="newReviewContainer">
    
    <div class="banner " align ="center">
	<img src="${contextPath}/resources/image/review.png" class="img-fluid" alt="review">
	</div>
    <div class="myformContainer">
    <form name="myform" id= "myform" method="post"   action="${contextPath}/review/addNewReview.do"   enctype="multipart/form-data">
 	<table class="table table-hover ">
 
 	<thead>
    <tr>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
    
      
    </tr>
  </thead>
 	
 		 <tbody class="table-group-divider">
 		 <p class="fs-3 mb-3"><i class="bi bi-pencil"></i>&nbsp;리뷰 작성</p>
 		 <tr>
 		  <th scope="row">작성자</th>
 		 <td><input name ="member_name" type="text" size="20" maxlength="100"  value="${memberInfo.member_name}" readonly class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"/></td>
 			<input type="hidden" name ="member_id" value="${memberInfo.member_id}">
 		
 		<tr>
 		<th scope="row">상품</th>
 		<td><input type="text" size="67"  maxlength="500" name="goods_id" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" onKeyUp="keywordSearch()"/>
 			<div id="suggest">
			 <div class="row mt-1 justify-content-center">
			<div id="suggestList" class="col-4" ></div>
			</div>
			</div>
			</td>
 		</tr>
 		
 		<tr>
 		<th scope="row">리뷰 내용</th>
 		<td>
 		<textarea name="review_content" rows="10" cols="65" maxlength="4000"  class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" resize: none;></textarea>
 		</td>
 		</tr>
 		
 		<tr>
 		<th scope="row">별점</th>
 		<td>
 			
   		 <fieldset>
        <legend></legend>
        <label for="rate1">⭐</label><input type="radio" name="review_star" value="1" id="rate1">
        <label for="rate2">⭐</label><input type="radio" name="review_star" value="2" id="rate2">
        <label for="rate3">⭐</label><input type="radio" name="review_star" value="3" id="rate3">
        <label for="rate4">⭐</label><input type="radio" name="review_star" value="4" id="rate4">
        <label for="rate5">⭐</label><input type="radio" name="review_star" value="5" id="rate5">
		</fieldset>
			 
</td>
 		</tr>
 		
 		<tr>
 		<th scope="row">이미지파일 첨부</th>
 		<td> <input type="file" name="imageFileName"  onchange="readURL(this);" class='form-control'/></td>
 		<input type="hidden" ></
 		</tr>
 		
 		<tr>
 		<th scope="row">미리보기</th>
 		<td><img  id="preview" src="#"   margin=0px 70px 20px; width=500 height=200 onerror="this.src='${contextPath}/resources/image/noPhoto.jpg';" /></td>
 		</tr>
 		
 		<tr>
 		<th scope="row">추가 이미지</th>
		<td align="left"> <input type="button" value="파일 추가" class="btn btn-sm btn-danger "onClick="fn_addFile()" style="background-color:#BEACC4; border-color:white; " /></td> 
 		</tr>
 		
 		<tr id="d_fileList">
 		<th scope="row"></th>
 		<td id="d_file"></td>
 		</tr>
 		
 		
 		<tr>
 		<th scope="row">완료</th>
 		<td><input type="submit" value="글쓰기" class="btn btn-sm btn-danger"style="background-color:#BEACC4; border-color:white; " /> 
 		<input type=button value="목록보기" class="btn btn-sm btn-danger" onClick="backToList(this.form)" style="background-color:#BEACC4; border-color:white; "/><td>
 		</tr>
 		
 		 </tbody>
 	</table> <!-- table table-hover -->
 	</form>
	</div>
	</div>
	
</body>
</html>