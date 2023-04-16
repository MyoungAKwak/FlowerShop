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
 <script>
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

   
   window.onload=function()
    {
      selectBoxInit();
    }

    function selectBoxInit(){
    
     var tel1='${memberInfo.tel1 }';
     var hp1='${memberInfo.hp1}';
     var selTel1 = document.getElementById('tel1');
     var selHp1 = document.getElementById('hp1');
     var optionTel1 = selTel1.options;
     var optionHp1 = selHp1.options;
     var val;
     for(var i=0; i<optionTel1.length;i++){
       val = optionTel1[i].value;
       if(tel1 == val){
    	   optionTel1[i].selected= true;
        break;
       }
     }  
     
     for(var i=0; i<optionHp1.length;i++){
         val = optionHp1[i].value;
         if(hp1 == val){
        	 optionHp1[i].selected= true;
          break;
         }
       } 
     
   }


function fn_modify_member_info(attribute){
	var value;
	// alert(member_id);
	// alert("mod_type:"+mod_type);
		var frm_mod_member=document.frm_mod_member;
		if(attribute=='member_pw'){
			value=frm_mod_member.member_pw.value;
			//alert("member_pw:"+value);
		}else if(attribute=='member_gender'){
			var member_gender=frm_mod_member.member_gender;
			for(var i=0; member_gender.length;i++){
			 	if(member_gender[i].checked){
					value=member_gender[i].value;
					break;
				} 
			}
			
		}else if(attribute=='member_birth'){
			var member_birth_y=frm_mod_member.member_birth_y;
			var member_birth_m=frm_mod_member.member_birth_m;
			var member_birth_d=frm_mod_member.member_birth_d;
			var member_birth_gn=frm_mod_member.member_birth_gn;
			
			for(var i=0; member_birth_y.length;i++){
			 	if(member_birth_y[i].selected){
					value_y=member_birth_y[i].value;
					break;
				} 
			}
			for(var i=0; member_birth_m.length;i++){
			 	if(member_birth_m[i].selected){
					value_m=member_birth_m[i].value;
					break;
				} 
			}
			
			for(var i=0; member_birth_d.length;i++){
			 	if(member_birth_d[i].selected){
					value_d=member_birth_d[i].value;
					break;
				} 
			}
			
			//alert("수정 년:"+value_y+","+value_m+","+value_d);
			for(var i=0; member_birth_gn.length;i++){
			 	if(member_birth_gn[i].checked){
					value_gn=member_birth_gn[i].value;
					break;
				} 
			}
			//alert("생년 양음년 "+value_gn);
			value=+value_y+","+value_m+","+value_d+","+value_gn;
		}else if(attribute=='tel'){
			var tel1=frm_mod_member.tel1;
			var tel2=frm_mod_member.tel2;
			var tel3=frm_mod_member.tel3;
			
			for(var i=0; tel1.length;i++){
			 	if(tel1[i].selected){
					value_tel1=tel1[i].value;
					break;
				} 
			}
			value_tel2=tel2.value;
			value_tel3=tel3.value;
			value=value_tel1+","+value_tel2+", "+value_tel3;
		}else if(attribute=='hp'){
			var hp1=frm_mod_member.hp1;
			var hp2=frm_mod_member.hp2;
			var hp3=frm_mod_member.hp3;
			var smssts_yn=frm_mod_member.smssts_yn;
			
			for(var i=0; hp1.length;i++){
			 	if(hp1[i].selected){
					value_hp1=hp1[i].value;
					break;
				} 
			}
			value_hp2=hp2.value;
			value_hp3=hp3.value;
			value_smssts_yn=smssts_yn.checked;
			value=value_hp1+","+value_hp2+", "+value_hp3+","+value_smssts_yn;
		}else if(attribute=='email'){
			var email1=frm_mod_member.email1;
			var email2=frm_mod_member.email2;
			var emailsts_yn=frm_mod_member.emailsts_yn;
			
			value_email1=email1.value;
			value_email2=email2.value;
			value_emailsts_yn=emailsts_yn.checked;
			value=value_email1+","+value_email2+","+value_emailsts_yn;
			//alert(value);
		}else if(attribute=='address'){
			var zipcode=frm_mod_member.zipcode;
			var roadAddress=frm_mod_member.roadAddress;
			var jibunAddress=frm_mod_member.jibunAddress;
			var namujiAddress=frm_mod_member.namujiAddress;
			
			value_zipcode=zipcode.value;
			value_roadAddress=roadAddress.value;
			value_jibunAddress=jibunAddress.value;
			value_namujiAddress=namujiAddress.value;
			value=value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
		}
		console.log(attribute);
	 
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/modifyMyInfo.do",
			data : {
				attribute:attribute,
				value:value,
			},
			success : function(data, textStatus) {
				if(data.trim()=='mod_success'){
					alert("회원 정보를 수정했습니다.");
				}else if(data.trim()=='failed'){
					alert("다시 시도해 주세요.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
				
			}
		}); //end ajax
}
</script>

<style>

.myDetailContainer{
	display:flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margin-top:150px;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
   color:gray;
   }
   .banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
</style>
</head>

<body>
<div class="myDetailContainer">
<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/mypage.png" class="img-fluid" alt="mypage">
	        </div>

		<form  name="frm_mod_member">	
	
	
	<table class="table table-hover mt-5 ">
  <thead>
    <tr>
      <th scope="col"><p class="fs-3"><i class="bi bi-person" style="font-size:2rem;"></i>&nbsp;내 상세 정보</p></th>
      
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    
      

     
    
      
    </tr>
  </thead>
  
  
  <tbody class="table-group">
    <tr>
      <th scope="row">아이디</th>
      <td class="col-md-3"><input type="text"  name="member_id"  value="${memberInfo.member_id }" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
     <td></td>
     	<td></td>
     	<td></td>
     
    </tr>
    
    <tr>
      <th scope="row">비밀번호</th>
      <td><input type="password" name="member_pw"  value="${memberInfo.member_pw }" class="form-control mt-2" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" maxlength="15">
      <button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" style="background-color:#BEACC4; border-color:white; "id="btnOverlapped"  onClick="fn_modify_member_info('member_pw')"  >비밀번호 수정하기</button>
      </td>
  	<td></td>
  	<td></td>
    
    </tr>
    
    <tr>
      <th scope="row">이름</th>
      <td><input type="text"  name="member_name" value="${memberInfo.member_name }"  disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
   
  <td></td>
  	<td></td>
    
    </tr>
    
    <%-- 성별을 왜 수정해요?? <tr>
      <th scope="row">성별</th>
      <td>
        <c:choose>
		<c:when test="${memberInfo.member_gender =='101' }">
      <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_gender"  value="102" >
	  <label class="form-check-label" for="inlineRadio1">여자</label>
	   <input class="form-check-input" type="radio"  name="member_gender"  value="101" checked >
	  <label class="form-check-label" for="inlineRadio1">남자</label>
      </div>
       </c:when>
       
	 <c:otherwise>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_gender"  value="102" checked>
	  <label class="form-check-label" for="inlineRadio2">여자</label>
	  <input class="form-check-input" type="radio"  name="member_gender"  value="101" >
	  <label class="form-check-label" for="inlineRadio2">남자</label>
	  </div>
	  </c:otherwise>
		 </c:choose>
		   <button type="button" class="btn btn-outline-secondary btn-sm mt-1 mr-auto" id="btnOverlapped"  onClick="fn_modify_member_info('member_gender')"  >수정하기</button>
		     </td>
	 
  
	   <td></td>
	    <td></td>
    </tr> --%>
   
   
     <tr>
      <th scope="row">생년월일</th>

      	<td>
      	
      	   <select class="form-select " name="member_birth_y" aria-label="Default select example">
      	    <c:forEach var="year" begin="1" end="100">
			<c:choose>
			      <c:when test="${memberInfo.member_birth_y==1920+i }">
			<option value="${ 1920+i}" selected>${ 1920+i} </option>
			</c:when>
			<c:otherwise>
			<option value="${ 1920+i}" >${ 1920+i} </option>
			</c:otherwise>
			</c:choose>
			</c:forEach> 
			</select>
		 </td>
	 
      <td>
      	<select class="form-select mr-auto" name="member_birth_m" aria-label="Default select example">
		  <c:forEach var="i" begin="1" end="12">
		 <c:choose>
		<c:when test="${memberInfo.member_birth_m==i }">
		<option value="${i }" selected>${i }</option>
		</c:when>
		<c:otherwise>
		<option value="${i }">${i }</option>
		</c:otherwise>
		</c:choose>
		</c:forEach>
    	</select>
	   </td>
	   
	   
	    <td>
	    <select class="form-select" name="member_birth_d" aria-label="Default select example">
      	<c:forEach var="i" begin="1" end="31">
	    <c:choose>
		<c:when test="${memberInfo.member_birth_d==i }">
		<option value="${i }" selected>${i }</option>
		</c:when>
		<c:otherwise>
		<option value="${i }">${i }</option>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		</select>
		
		</td>
		
   	  
  	    
		</tr>

      <tr>
      <th scope="row">양력/음력</th>
      <td>
       <c:choose>
		<c:when test="${memberInfo.member_birth_gn=='2' }"> 
      <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn" value="2" checked>
	  <label class="form-check-label" for="inlineRadio1">양력</label>
      </div>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn" value="1">
	  <label class="form-check-label" for="inlineRadio2">음력</label>
	  </div>
	  </c:when>
	  <c:otherwise>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn"  value="2" >
	  <label class="form-check-label" for="inlineRadio1">양력</label>
      </div>
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn"  value="1" checked>
	  <label class="form-check-label" for="inlineRadio2">음력</label>
	  </div>
	 
	  </c:otherwise>
	  </c:choose>
	   <button type="button" class="btn btn-secondary btn-sm mt-1 mr-auto" style="background-color:#BEACC4; border-color:white; "id="btnOverlapped"  onClick="fn_modify_member_info('member_birth')"  >생년월일 수정하기</button>
      </td>
      <td></td>
  	<td></td>
      </tr>
      
     <tr>
      <th scope="row">연락처</th>
      <td>
      	<select class="form-select"  name="hp1" id="hp1" aria-label="Default select example">
		<option selected value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
    	</select> 
    	
      </td>
      <td><input type="text"  name="hp2" value="${memberInfo.hp2 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" maxlength="4">
     </td>
   	  <td><input type="text"  name="hp3" value="${memberInfo.hp3 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" maxlength="4"></td>
  	  
    </tr>
    
    
    
    
      <tr>
      <th scope="row">SMS 수신여부 </th>
      <td>
       <c:choose> 
	   <c:when test="${memberInfo.smssts_yn=='true' }">
     
	  <input class="form-check-input" type="checkbox"  name="smssts_yn" value="Y"  id="defaultCheck1" checked>
       </c:when>
		<c:otherwise>
	   <input class="form-check-input" type="checkbox"  name="smssts_yn" value="N"  id="defaultCheck1" >
	   </c:otherwise>
	  </c:choose>	
	   <input type="button" class="btn btn-secondary btn-sm "style="background-color:#BEACC4; border-color:white; " value="연락처 수정하기" onClick="fn_modify_member_info('hp')" />
	  </td>
	  <td></td>
  	<td></td>
    </tr>
	  
     
     <tr>
      <th scope="row">이메일</th>
  
      <td><input type="text"  name="email1" value="${memberInfo.email1}" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">    
      </td>

       <td class="col-md-3"><input type="text"  name="email2" value="${memberInfo.email2 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="@를 입력해주세요">
     </td>
	  <td></td>
  
		
    </tr>
    
      <tr>
      <th scope="row">E-MAIL 수신여부</th>
      <td>
    
	  <input class="form-check-input" type="checkbox"  name="emailsts_yn" value="Y"  id="defaultCheck2" checked>
	  <input type="button" value="E-MAIL수정하기" class="btn btn-secondary btn-sm"style="background-color:#BEACC4; border-color:white; " onClick="fn_modify_member_info('email')" />
	  
	 	
	  
	  </td>
	    <td></td>
	       <td></td>
	           <td></td>
     
    </tr>
    
    <!--  zip -->
     <tr>
      <th scope="row">주소</th>
      <td> <input type="text"  id="zipcode" name="zipcode" value="${memberInfo.zipcode }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td><p class="fw-light mt-2" ><a href="javascript:execDaumPostcode()">우편번호검색</a></p></td>
 	   <td></td>
    </tr>
    
     <tr>
      <th scope="row">지번</th>
      <td colspan="3"> <input type="text"  id="roadAddress" value="${memberInfo.roadAddress }"  name="roadAddress" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
    </tr>
    
    
     <tr>
      <th scope="row">도로명</th>
      <td colspan="3"> <input type="text"  id="jibunAddress" name="jibunAddress"  value="${memberInfo.jibunAddress }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
    </tr>
    
     <tr>
      <th scope="row">나머지</th>
      <td colspan="3"> <input type="text"  name="namujiAddress" value="${memberInfo.namujiAddress }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
      <input type="button" value="주소 수정하기" class="btn btn-secondary btn-sm mt-1" style="background-color:#BEACC4; border-color:white; "onClick="fn_modify_member_info('address')" /></td>
    
    </tr>

  </tbody>
</table>







	<div class="row justify-content-center mt-3">
		<input type="hidden" name="command"  value="modify_my_info" /> 
	 <a class="btn btn-secondary btn-md w-50 mt-2" href="${contextPath}/main/main.do" role="button"style="background-color:#BEACC4; border-color:white; ">쇼핑계속하기</a>
	</div>
		<input  type="hidden" name="h_hp1" value="${memberInfo.hp1}" />		


	</form>


</div>	
</body>
</html>