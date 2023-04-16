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
function search_member(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
	//alert("beginDate:"+beginDate+",endDate:"+endDate);
	//return ;
	
	var formObj=document.createElement("form");
    
	var formObj=document.createElement("form");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
    
	i_beginDate.name="beginDate";
	i_beginDate.value=beginDate;
	i_endDate.name="endDate";
	i_endDate.value=endDate;
	
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="/flower/admin/member/adminMemberMain.do";
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
		if(endDay-7<1){
			beginMonth=dt.getMonth();	
		}else{
			beginMonth=dt.getMonth()+1;
		}
		
		dt.setDate(endDay-7);
		beginDay=dt.getDate();
		
	}else if(search_period=='two_week'){
		beginYear = dt.getFullYear();
		if(endDay-14<1){
			beginMonth=dt.getMonth();	
		}else{
			beginMonth=dt.getMonth()+1;
		}
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



function fn_member_detail(joinDate){
	//alert(order_id);
	var frm_member_list=document.frm_member_list;

	var formObj=document.createElement("form");
	var joinDate = document.createElement("input");
	
	joinDate.name="joinDate";
	joinDate.value=joinDate;
	
    formObj.appendChild(joinDate);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/flower/admin/member/memberDetail.do";
    formObj.submit();
	
}


function fn_enable_detail_search(r_search){
	var frm_member_list=document.frm_member_list;
	
	t_beginYear=frm_member_list.beginYear;
	t_beginMonth=frm_member_list.beginMonth;
	t_beginDay=frm_member_list.beginDay;
	t_endYear=frm_member_list.endYear;
	t_endMonth=frm_member_list.endMonth;
	t_endDay=frm_member_list.endDay;
	s_search_type=frm_member_list.s_search_type;
	t_search_word=frm_member_list.t_search_word;
	btn_search=frm_member_list.btn_search;
	
	if(r_search.value=='detail_search'){
		//alert(r_search.value);
		t_beginYear.disabled=false;
		t_beginMonth.disabled=false;
		t_beginDay.disabled=false;
		t_endYear.disabled=false;
		t_endMonth.disabled=false;
		t_endDay.disabled=false;
		
		s_search_type.disabled=false;
		t_search_word.disabled=false;
		btn_search.disabled=false;
		
	}else{
		t_beginYear.disabled=true;
		t_beginMonth.disabled=true;
		t_beginDay.disabled=true;
		t_endYear.disabled=true;
		t_endMonth.disabled=true;
		t_endDay.disabled=true;
		
		s_search_type.disabled=true;
		t_search_word.disabled=true;
		btn_search.disabled=true;
	}
		
}

//상세조회 버튼 클릭 시 수행
function fn_detail_search(){
	var frm_delivery_list=document.frm_delivery_list;
	
	beginYear=frm_member_list.beginYear.value;
	beginMonth=frm_member_list.beginMonth.value;
	beginDay=frm_member_list.beginDay.value;
	endYear=frm_member_list.endYear.value;
	endMonth=frm_member_list.endMonth.value;
	endDay=frm_member_list.endDay.value;
	search_type=frm_member_list.s_search_type.value;
	search_word=frm_member_list.t_search_word.value;

	var formObj=document.createElement("form");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
	var i_search_type = document.createElement("input");
	var i_search_word = document.createElement("input");
    
	
    i_beginDate.name="beginDate";
    i_endDate.name="endDate";
    i_search_type.name="search_type";
    i_search_word.name="search_word";
    
	i_beginDate.value=beginYear+"-"+beginMonth+"-"+beginDay;
    i_endDate.value=endYear+"-"+endMonth+"-"+endDay;
    i_search_type.value=search_type;
    i_search_word.value=search_word;
	
    formObj.appendChild(i_command);
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    formObj.appendChild(i_search_type);
    formObj.appendChild(i_search_word);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/flower/admin/member/memberDetail.do";
    formObj.submit();
	
}
</script>
<style>
.adminContainer{
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
margin-top:50px;
width:1100px;
}
.tableContainer2{
width:1100px;

}
</style>
</head>
<body>
	<div class="adminContainer">
<div class="banner " align ="center">
	<img src="${contextPath}/resources/image/admin_member.png" class="img-fluid" alt="admin">
	</div>
	   
	   	<div class="tableContainer">
	     <form name="frm_member_list" method="post">	 
	      <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col"><p class="fs-3"><i class="bi bi-people" style="font-size:2rem;"></i>&nbsp;회원 조회 /등록</p></th>
             <th scope="col"></th>
             <th scope="col"></th>
           </tr>
         </thead>	
         
		  <tbody class="table-group-divider">
          <tr>
          <th scope="row">
          <input type="radio" name="r_search" value="simple_search" checked onClick="fn_enable_detail_search(this)"/> 간단조회 &nbsp;&nbsp;&nbsp;
          </th>
          <td></td>
          <td></td>
          </tr>
				<TR >
					<TD>
					  <select name="curYear" >
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
					</select>년 <select name="curMonth"  >
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
					
					 <select name="curDay" >
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
					<a href="javascript:search_member('today')">
					   <img  src="${contextPath}/resources/image/btn_search_one_day.jpg">
					</a>
					<a href="javascript:search_member('one_week')">
					   <img   src="${contextPath}/resources/image/btn_search_1_week.jpg">
					</a>
					<a href="javascript:search_member('two_week')">
					   <img   src="${contextPath}/resources/image/btn_search_2_week.jpg">
					</a>
					<a href="javascript:search_member('one_month')">
					   <img   src="${contextPath}/resources/image/btn_search_1_month.jpg">
					</a>
					<a href="javascript:search_member('two_month')">
					   <img   src="${contextPath}/resources/image/btn_search_2_month.jpg">
					</a>
					<a href="javascript:search_member('three_month')">
					   <img   src="${contextPath}/resources/image/btn_search_3_month.jpg">
					</a>
					<a href="javascript:search_member('four_month')">
					   <img   src="${contextPath}/resources/image/btn_search_4_month.jpg">
					</a>
					&nbsp;까지 조회
					</TD>
					<td></td>
					<td></td>
				</TR>
				
				<tr>
				 <th scope="row">
                <input type="radio" name="r_search" value="detail_search"  onClick="fn_enable_detail_search(this)" /> 상세조회 &nbsp;&nbsp;&nbsp;
                 </th>
                  <td></td>
				  <td></td>
				</tr>
				<tr>
				    <td>
					조회 기간:
					<select name="beginYear" disabled>
					 <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${beginYear==beginYear-i }">
					          <option value="${2023-i }" selected>${2023-i  }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${beginYear-i }">${beginYear-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 
					<select name="beginMonth" disabled >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${beginMonth==i }">
					          <option value="${i}"  selected>${i}</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					 <select name="beginDay" disabled >
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${beginDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>일  &nbsp; ~
					
					<select name="endYear" disabled >
					 <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${endYear==endYear-i }">
					          <option value="${2016-i }" selected>${2016-i  }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${2016-i }">${2016-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 
					<select name="endMonth" disabled >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${endMonth==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					 <select name="endDay" disabled >
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${endDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i<10}">
					              <option value="0${i}">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i}">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>
												 
				  </td>
				  <td></td>
				  <td></td>
				</tr>
				
				<tr>
				  <td>
				    <select name="s_search_type" disabled>
						<option value="all" checked>전체</option>
						<option value="member_name">회원이름</option>
						<option value="member_id">회원아이디</option>
						<option value="member_hp_num">회원휴대폰번호</option>
					  </select>
					 <input  type="text" size="30" name="t_search_word" disabled/>  
	                <a class="btn btn-dark btn-sm mb-1" name="btn_search" onClick="fn_detail_search()" role="button" disabled style="background-color:#BEACC4; border-color:white; " >조회</a>
				  </td>
				</tr>
				
			</TBODY>
		</TABLE>
	
</form>	
</div>

		<div class="tableContainer2  mt-1">
		   <table class="table table-hover">
		 <thead>
           <tr>
             <th scope="col">아이디</th>
             <th scope="col">이름</th>
             <th scope="col">휴대폰번호</th>
             <th scope="col">주소</th>
             <th scope="col">가입일</th>
             <th scope="col">활동</th>
           </tr>
         </thead>
	
   <c:choose>
     <c:when test="${empty member_list }">			
		  <tbody class="table-group-divider">
          <tr>
          <th scope="row">조회된 회원이 없습니다</th>
          <td></td>
          <td></td>
          <td></td>
          </tr>
         
	 </c:when>
	 
	 <c:otherwise>
	 
     <c:forEach var="item" items="${member_list }">
			   <tr>  
			   
				<td scope="row">
				<a href="${pageContext.request.contextPath}/admin/member/memberDetail.do?member_id=${item.member_id}">${item.member_id}</a> 
				</td>
				<td>
				   ${item.member_name }
				</td>
				<td>
				${item.hp1}-${item.hp2}-${item.hp3}
				</td>
				<td>
	             ${item.roadAddress}<br>
				 ${item.jibunAddress}<br>
			     ${item.namujiAddress}<br>
				</td>
				
				<td>
			      <c:set var="join_date" value="${item.joinDate}" />
					   <c:set var="arr" value="${fn:split(join_date,' ')}" />
					<c:out value="${arr[0]}" />
				</td>
				<td>
				<c:choose>
				         <c:when test="${item.del_yn=='N' || item.del_yn=='n'}">
				           <strong>활동중</strong>  
				         </c:when>
				         <c:otherwise>
				           <strong>탈퇴</strong>
				         </c:otherwise>
				       </c:choose>
				</td>


			</TR>

	</c:forEach>
	</c:otherwise>
  </c:choose>
	
	</TBODY>
	</TABLE>
	</div>
			<nav aria-label="Page navigation example pb-3">
			  <ul class="pagination justify-content-center ">
			    <c:forEach   var="page" begin="1" end="10" step="1" >
			     <c:if test="${section >1 && page==1 }">
			    <li class="page-item"><a class="page-link" href="${pageContext}/admin/member/adminMemberMain.do?chapter=${chapter-1}&pageNum=${(chapter-1)*10 +1 }"></a></li>
			   	</c:if>
			    <li class="page-item"><a class="page-link" href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
			     <c:if test="${page ==10 }">
			    <li class="page-item"><a class="page-link" href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section+1}&pageNum=${section*10+1}">Next</a></li>
			     </c:if> 
			     	</c:forEach> 
				  </ul>
			</nav>	
	
	

</div>

</body>
</html>