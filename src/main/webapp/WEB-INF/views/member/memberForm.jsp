<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
.memberContainer{
	   display: flex;
       justify-content: center;
       align-items: center; 
       margin-top:150px;
       
}
.memberFont{
font-family: 'Gowun Dodum', sans-serif;
	font-weight:bold;
	color:gray;

}

{

</style>
<script>
window.onload = function(){
	hide('E.C');
	
}

var _emData="";
var emailC="no";

function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }
      
     
    }
  }).open();
}

function fn_overlapped(){
    var _id=$("#_member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#btnOverlapped').prop("disabled", false); 
       	    $('#_member_id').prop("disabled", false);
       	    $('#member_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
 
function fn_mailCheck(){
	var _email = $('#em1').val();
	 _email += $('#em2').val();
	 
	
	 if(_email==''){
	   	 alert("email을 입력하세요");
	   	 return;
	    }
	 
	 
	 
	
	    $.ajax({
	        type:"post",
	        async:false,  
	        url:"${contextPath}/member/navermailtest.do",
	        dataType:"text",
	        data: {email:_email},
	        success:function (data,textStatus){
	          _emData=data;
	          show("E.C");
	        	alert('인증번호가 전송되었습니다.');
	        	hide('inputEmail');
	          
	          	
	        },
	        error:function(data,textStatus){
	           alert("메일을 다시 입력해주세요.");
	        },
	        complete:function(data,textStatus){
	           

	        }
	     });  //end ajax	
 
}


function emcheck(){
	
	var emailCheck = $('#emailCheck').val();
	var gck = document.getElementById('goodCK');
	emailC="yes"; 
	
	if(emailCheck !=_emData){
		alert("인증번호를 다시 확인해주세요");
	}else{
		hide('E.C');
		gck.innerHTML="인증이 완료되었습니다.";
		
		
		
		
	}
		
		
	
	
	
} 


	 
	 function show(elementId) {
	 var element =document.getElementById(elementId);
	 if(element) {
	  element.style.display = '';
	 }
	}

function hide(elementId){
  var element = document.getElementById(elementId);
  if(element){
	  element.style.display = 'none';
  }
}

function validateForm() {
	  let x = emailC
	  if (x =='no') {
	    alert("이메일 인증을 해주세요.");
	    return false;
	  }
	}
 

</script>
</head>
<body>


<div class="memberContainer">
	
	<form action="${contextPath}/member/addMember.do" class= "needs-validation" method="post" onsubmit="return validateForm()">	
	
	
	<table class="table table-hover ">
  <thead>
    <tr>
      <th scope="col"><p class="memberFont fs-3 mb-3 "><i class="bi bi-flower3" style="font-size: 2rem;color:#BEACC4;"></i>&nbsp;회원가입</p></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
    
      
    </tr>
  </thead>
  
  
  <tbody class="table-group-divider">
    <tr>
      <th scope="row">아이디</th>
      <td class="col-md-3 required"><input type="text"  name="member_id" id="_member_id" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" required="required" ></td>
      <td><button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" id="btnOverlapped"  onClick="fn_overlapped()" style="background-color:#BEACC4; border-color:white; " >중복확인</button></td>
      <td></td>
    </tr>
    <!-- onsubmit="return validateForm()" -->
    
    <tr>
      <th scope="row">비밀번호</th>
      <td><input type="password" name="member_pw"  class="form-control mt-2" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" required="required"></td>
  	   <td></td>
  	    <td></td>
    
    </tr>
    
    <tr>
      <th scope="row">이름</th>
      <td><input type="text"  name="member_name" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
   	 <td></td>
   	  <td></td>
    
    </tr>
    
     <tr>
      <th scope="row">성별</th>
      <td>
      <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_gender" id="inlineRadio1" value="101" >
	  <label class="form-check-label" for="inlineRadio1">남자</label>
      </div>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_gender" id="inlineRadio2" value="102">
	  <label class="form-check-label" for="inlineRadio2">여자</label>
	  </div>
      </td>
	   <td></td>
	    <td></td>
     
    </tr>
   
   
     <tr>
      <th scope="row">생년월일</th>

      	<td>
      	
      	   <select class="form-select " name="member_birth_y" aria-label="Default select example">
      	    <c:forEach var="year" begin="1" end="100">
			<c:choose>
			<c:when test="${year==80}">
			<option value="${ 1920+year}" selected>${ 1920+year} </option>
			</c:when>
			<c:otherwise>
			<option value="${ 1920+year}" >${ 1920+year} </option>
			</c:otherwise>
			</c:choose>
			</c:forEach> 
			</select>
			
		 </td>
	 
      <td>
      	<select class="form-select mr-auto" name="member_birth_m" aria-label="Default select example">
		  <c:forEach var="month" begin="1" end="12">
		<c:choose>
		<c:when test="${month==5 }">
		<option value="${month }" selected>${month }</option>
		</c:when>
		<c:otherwise>
		<option value="${month }">${month}</option>
		</c:otherwise>
		</c:choose>
		</c:forEach>
    	</select>
	   </td>
	   
	   
	    <td>
	    <select class="form-select" name="member_birth_d" aria-label="Default select example">
      	<c:forEach var="day" begin="1" end="31">
		<c:choose>
		<c:when test="${day==10 }">
		<option value="${day}" selected>${day}</option>
	    </c:when>
		<c:otherwise>
		<option value="${day}">${day}</option>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		</select>
		</td>
		
		</tr>

      <tr>
      <th scope="row">양력/음력</th>
      <td>
      <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn" id="inlineRadio3" value="2" checked>
	  <label class="form-check-label" for="inlineRadio1">양력</label>
      </div>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn" id="inlineRadio4" value="1">
	  <label class="form-check-label" for="inlineRadio2">음력</label>
	  </div>
      </td>
       <td></td>
        <td></td>
 
    
      </tr>
      
    
     
   
    
     <tr>
      <th scope="row">연락처</th>
      <td>
      	<select class="form-select"  name="hp1" aria-label="Default select example">
		<option selected value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
    	</select> 
      </td>
      <td><input type="text"  name="hp2" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
   	  <td><input type="text"  name="hp3" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
  
     
    </tr>
    
    
    
    
      <tr>
      <th scope="row">SMS 수신여부</th>
      <td>
     
	  <input class="form-check-input" type="checkbox"  name="smssts_yn" value="Y"  id="defaultCheck1" checked>

	  </td>
	  <td></td>
	  <td></td>
    </tr>
	  
     
     <tr>
      <th scope="row">이메일</th>
  
      <td><input type="text"  id="em1" name="email1" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
      <a id="inputEmail" href="javascript:fn_mailCheck();">
							이메일 인증하기</a></td>
      
       <td class="col-md-3"><input type="text" id="em2" name="email2" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="@를 입력해주세요"></td>
		
		<td id="goodCK"></td>
		
    </tr>
    
    
     <tr id="E.C">
      <th scope="row">인증번호</th>
      <td class="col-md-3"><input type="text"  name="emailCheck" id="emailCheck" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td><button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" id="btnOverlapped" onClick="emcheck()"  style="background-color:#BEACC4; border-color:white; " >인증확인</button>
      <button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" id="btnOverlapped" onClick="fn_mailCheck()"  style="background-color:#BEACC4; border-color:white; " >재전송</button></td>
      <!-- <td><button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" id="btnOverlapped"   style="background-color:#BEACC4; border-color:white; " >재전송</button></td>
      <td></td> -->
      <td></td>
      
    </tr>
    
   
    
      <tr>
      <th scope="row">E-MAIL 수신여부</th>
      <td>
    
	  <input class="form-check-input" type="checkbox"  name="emailsts_yn" value="Y"  id="defaultCheck2" checked>
	
	  
	 
	  
	  </td>
	   <td></td>
	    <td></td>
     
    </tr>
    
    <!--  zip -->
     <tr>
      <th scope="row">주소</th>
      <td> <input type="text"  id="zipcode" name="zipcode" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td><p class="fw-light mt-2" ><a href="javascript:execDaumPostcode()">우편번호검색</a></p></td>
 	   <td></td>
    </tr>
    
     <tr>
      <th scope="row">지번</th>
      <td colspan="3"> <input type="text"  id="roadAddress"  name="roadAddress" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
   
    </tr>
    
    
     <tr>
      <th scope="row">도로명</th>
      <td colspan="3"> <input type="text"  id="jibunAddress" name="jibunAddress"  class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
    </tr>
    
     <tr>
      <th scope="row">나머지</th>
      <td colspan="3"> <input type="text"  name="namujiAddress" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
    </tr>

  </tbody>
</table>

	<div class="row justify-content-center mt-3">
	<input type="submit"  value="회원가입" class="btn btn-secondary btn-md col-2" style="background-color:#BEACC4; border-color:white; ">&nbsp;&nbsp;
	<button type="reset" class="btn btn-secondary btn-md col-2" style="background-color:#BEACC4; border-color:white; ">다시입력</button>
	</div>
	
	</form>
	</div>
	
	<!-- hidden -->
	 <input type="hidden" name="member_id"  id="member_id" />
	 <input type="hidden" value="no" id="emailC"/>

	
</body>
</html>