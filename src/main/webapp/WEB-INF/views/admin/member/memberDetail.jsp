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
function fn_modify_member_info(member_id,mod_type){
	var value;
	// alert(member_id);
	// alert("mod_type:"+mod_type);
		var frm_mod_member=document.frm_mod_member;
		if(mod_type=='member_pw'){
			value=frm_mod_member.member_pw.value;
			//alert("member_pw:"+value);
		}else if(mod_type=='member_gender'){
			var member_gender=frm_mod_member.member_gender;
			for(var i=0; member_gender.length;i++){
			 	if(member_gender[i].checked){
					value=member_gender[i].value;
					break;
				} 
			}
			//alert("member_gender111:"+value);
			
		}else if(mod_type=='member_birth'){
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
		}else if(mod_type=='hp'){
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
			
		}else if(mod_type=='email'){
			var email1=frm_mod_member.email1;
			var email2=frm_mod_member.email2;
			var emailsts_yn=frm_mod_member.emailsts_yn;
			
			value_email1=email1.value;
			value_email2=email2.value;
			value_emailsts_yn=emailsts_yn.checked;
			
			value=value_email1+","+value_email2+","+value_emailsts_yn;
			//alert(value);
		}else if(mod_type=='address'){
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
	 
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "http://localhost:8090/flower/admin/member/modifyMemberInfo.do",
			data : {
				member_id:member_id,
				mod_type:mod_type,
				value:value
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

function fn_delete_member(member_id ,del_yn){
	var frm_mod_member=document.frm_mod_member;
	var i_member_id = document.createElement("input");
	var i_del_yn = document.createElement("input");
    
	
    i_member_id.name="member_id";
    i_del_yn.name="del_yn";
    i_member_id.value=member_id;
    i_del_yn.value=del_yn;
    
    frm_mod_member.appendChild(i_member_id);
    frm_mod_member.appendChild(i_del_yn);
    frm_mod_member.method="post";
    frm_mod_member.action="/flower/admin/member/deleteMember.do";
    frm_mod_member.submit();
}
</script>
<style>

.myDetailContainer{
	display:flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margint-top:150px;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
.banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
.table{
width:1100px;
margin-top:50px;
}
</style>
</head>

<body>
<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/admin_member.png" class="img-fluid" alt="admin">
	        </div>
<div class="myDetailContainer">
	
	
		<form  name="frm_mod_member">	
	
	
	<table class="table table-hover ">
  <thead>
    <tr>
      <th scope="col"><p class="fs-3"><i class="bi bi-people" style="font-size:2rem;"></i>&nbsp;회원/수정</p></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
    
      
    </tr>
  </thead>
  
  
  <tbody class="table-group-divider">
    <tr>
      <th scope="row">아이디</th>
      <td class="col-md-3"><input type="text"  name="member_id" value="${member_info.member_id}" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td></td>
    </tr>
    
    <tr>
      <th scope="row">비밀번호</th>
      <td><input type="password" name="member_pw"  value="${member_info.member_pw }" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" >
     
      </td>
  	   <td></td>
  	    <td></td>
    
    </tr>
    
    <tr>
      <th scope="row">이름</th>
      <td><input type="text"  name="member_name" value="${member_info.member_name}"  disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
   	 <td></td>
   	  <td></td>
    
    </tr>
   

     <tr>
      <th scope="row">생년월일</th>

      	<td>	
     <input type="text"  disabled class="form-control" name="member_birth_y" value="${member_info.member_birth_y}" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		 </td>
	 
      <td>
      <input type="text"  disabled class="form-control" name="member_birth_m" value="${member_info.member_birth_m}" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	   </td>
	    <td>
	    <input type="text"  disabled class="form-control" name="member_birth_d" value="${member_info.member_birth_d}" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</td>
		</tr>

      <tr>
      <th scope="row">양력/음력</th>
      <td>
      
       <c:choose>
		<c:when test="${member_info.member_birth_gn=='2' }"> 
		
      <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn" value="2" checked id="y">
	  <label class="form-check-label" for="y">양력</label>
      </div>
<!--       
	  <input  disabled class="form-control" type="radio"  name="member_birth_gn" value="1"> -->
	  <div class="form-check form-check-inline">
	    <input class="form-check-input" type="radio"  name="member_birth_gn" value="1" checked id="m">
	  <label class="form-check-label" for="m">음력</label>
	  </div>
	  </c:when>
	  <c:otherwise>
	  <div class="form-check form-check-inline">
	  <input disabled class="form-control" type="radio"  name="member_birth_gn"  value="2" id="y" >
	  <label class="form-check-label" for="y">양력</label>
      </div>
      
	  <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio"  name="member_birth_gn"  value="1" checked id="m">
	  <label class="form-check-label" for="m">음력</label>
	  </div>
	 
	  </c:otherwise>
	  </c:choose>
	  
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
      <td><input type="text"  name="hp2" value="${member_info.hp2 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
     </td>
   	  <td><input type="text"  name="hp3" value="${member_info.hp3 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
  	  <td></td>
    </tr>
    
    
    
    
      <tr>
      <th scope="row">SMS 수신여부 </th>
      <td>
       <c:choose> 
	   <c:when test="${member_info.smssts_yn=='true' }">
     
	  <input class="form-check-input" type="checkbox"  name="smssts_yn" value="Y"  id="defaultCheck1" checked>
       </c:when>
		<c:otherwise>
	   <input class="form-check-input" type="checkbox"  name="smssts_yn" value="N"  id="defaultCheck1" >
	   </c:otherwise>
	  </c:choose>	
	   <input type="button" class="btn btn-secondary btn-sm " value="연락처 수정하기" style="background-color:#BEACC4; border-color:white; " onClick="fn_modify_member_info('hp1')" />
	  </td>
	  <td> </td>
	  <td></td>
    </tr>
	  
     
     <tr>
      <th scope="row">이메일</th>
  
      <td><input type="text"  name="email1" value="${member_info.email1}" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">    
      </td>

       <td class="col-md-3"><input type="text"  name="email2" value="${member_info.email2 }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="@를 입력해주세요">
     </td>
	
		<td></td>
		
    </tr>
    
      <tr>
      <th scope="row">E-MAIL 수신여부</th>
      <td>
    
	  <input class="form-check-input" type="checkbox"  name="emailsts_yn" value="Y"  id="defaultCheck2" checked>
	  <input type="button" value="E-MAIL수정하기" class="btn btn-secondary btn-sm" style="background-color:#BEACC4; border-color:white; " onClick="fn_modify_member_info('email')" />
	  
	 
	  
	  </td>
	   <td></td>
	    <td></td>
     
    </tr>
    
    <!--  zip -->
     <tr>
      <th scope="row">주소</th>
      <td> <input type="text"  id="zipcode" name="zipcode" value="${member_info.zipcode }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td><p class="fw-light mt-2" ><a href="javascript:execDaumPostcode()">우편번호검색</a></p></td>
 	   <td></td>
    </tr>
    
     <tr>
      <th scope="row">지번</th>
      <td colspan="3"> <input type="text"  id="roadAddress" value="${member_info.roadAddress }"  name="roadAddress" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
      <td></td>
      <td></td>
    </tr>
    
    
     <tr>
      <th scope="row">도로명</th>
      <td colspan="3"> <input type="text"  id="jibunAddress" name="jibunAddress"  value="${member_info.jibunAddress }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
    
    </tr>
    
     <tr>
      <th scope="row">나머지</th>
      <td colspan="3"> 
      <input type="text"  name="namujiAddress" value="${member_info.namujiAddress }" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
      <input type="button" value="주소 수정하기" class="btn btn-secondary btn-sm mt-1" style="background-color:#BEACC4; border-color:white; " onClick="fn_modify_member_info('address')" /></td>
       <td> </td>
    </tr>
    
       <div>
        <tr>
        <th scope="row">
			<td colspan="3">
			<input type="hidden" name="command"  value="modify_my_info" /> 
			<c:choose>
			  <c:when test="${member_info.del_yn=='Y' }">
			   <input type="button" value="회원복원" class="btn btn-secondary btn-sm mt-1" style="background-color:#BEACC4; border-color:white; " onClick="fn_delete_member('${member_info.member_id }','N')" />
			  </c:when>
			  <c:when  test="${member_info.del_yn=='N' }">
			  <input type="button" value="회원탈퇴" class="btn btn-secondary btn-sm mt-1" style="background-color:#BEACC4; border-color:white; " onClick="fn_delete_member('${member_info.member_id }','N')" />
			  </c:when>
			</c:choose>		
		 </td>
		  </tr>
        </div>
        
  </tbody>
</table>

		<input  type="hidden" name="h_hp1" value="${member_info.hp1}" />		
	</form>


</div>	
</body>
</html>