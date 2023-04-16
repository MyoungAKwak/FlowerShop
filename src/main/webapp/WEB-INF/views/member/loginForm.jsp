<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
<script>
window.onload=function()
{
  result();
}

function result(){
	alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
}

</script>
</c:if>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
.login_container{
	display:flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top:200px;
	margin-bottom: 150px;
	
	
	
			}
	.longinFont{
	font-family: 'Shadows Into Light', cursive;
	font-weight:bold;
	}		
	</style>

</head>
<body>

	
	<div class="login_container">
	<p class="longinFont fs-2"><i class="bi bi-flower1"  style="font-size: 2.5rem;color:#BEACC4;"></i>&nbsp;LOGIN</p>
	<p class="fst-italic mb-4">오늘의꽃, 일상에 싱그러움을 더하다.</p>
	
	<form action="${contextPath}/member/login.do" method="post" style="width:500px;">
		
			
	<div class="input-group input-group-lg ">
	<input type="text"  name="member_id" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="아이디" value="${rememberId}" >
	</div>
	<div class="input-group input-group-lg">
    <input type="password" name="member_pw"class="form-control mt-2" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="비밀번호">
	</div>
	<br>
	<div class="form-check form-switch">
	<input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" name="remember-me" style="background-color:#BEACC4";>
	  	 <label class="form-check-label" for="flexSwitchCheckDefault">아이디 기억하기</label> 	
	  	 </div>
	
	<button type="submit" class="btn btn-secondary btn-lg mt-2 w-100" style="background-color:#BEACC4; border-color:white; ">로그인</button>
	</form>		
	
	<p class="fs-6 mt-2">아직 회원이 아니신가요?<a href="${contextPath}/member/memberForm.do">&nbsp;회원가입</a></p>
	
	
	</div>

</body>
</html>