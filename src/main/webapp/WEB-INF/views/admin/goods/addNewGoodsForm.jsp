<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>

<meta charset="utf-8">
<head>
<script type="text/javascript">
  var cnt=0;
  function fn_addFile(){
	 
	  if(cnt == 0){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' class='form-control ' />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image' class='form-control '"+cnt+"' />");
	  }
  	
  	cnt++;
  }
  
  
  function fn_add_new_goods(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }
		 
	}
</script>    

<style>

.addNewContainer{
	display: flex;
	justify-content:center;
	flex-direction: column;
	align-items: center;
	margin-top:150px;
	margin-left: auto;
	margin-right:auto;


}

.buttonContainer{
	display:flex;
	justify-content:center;
	align-items: center;


}

.banner{
	
	margin-top:100px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
</style>

</head>

<BODY>
<div class="addNewContainer ">


	<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/admin_goods.png" class="img-fluid" alt="admin">
	        </div>

<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">

		
		
			<div class="tabs_container mt-5 ">
			<ul class="tabs pb-auto">
			<li style="list-style:none; float:left; margin: 0px 5px ;" ><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab1" role="button"><i class="bi bi-flower3"></i>&nbsp;상품정보&nbsp;&nbsp;</a></li>&nbsp;
			<li style="list-style:none; float:left; margin: 0px 5px ;"><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab2" role="button"><i class="bi bi-flower3"></i>&nbsp;꽃말&nbsp;&nbsp;</a></li>&nbsp;
			<li style="list-style:none; float:left; margin: 0px 5px ;"><a class="btn btn-dark btn-lg" style="background-color:#BEACC4; border-color:white; " href="#tab3" role="button"><i class="bi bi-flower3"></i>&nbsp;상품이미지&nbsp;&nbsp;</a></li>		
			</ul>
			</div>
			<!--  tab1  상품정보 FORM-->
		
		<div class="tab_container">
		 
			<div class="tab_content" id="tab1">
			<table class="table table-hover">
			
			<thead>
		    <tr>
		      <th scope="col"></th>
		      
		    </tr>
		     </thead>
		    <tbody class="table-group-divider">
		    	<tr>
			      <th scope="row">꽃 종류</th>
			      <td> <input type="text"  name="goods_sort" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
			   
			    </tr>
			    
			    <tr>
			    <th scope="row">꽃 이름</th>
			    <td><input type="text"  name="goods_title" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
			  
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">상품종류</th>
		    	<td>
		    	<select name="goods_status" class="form-select">
				  <option value="bestseller"  >BEST</option>
				  <option value="steadyseller" >STEADY</option>
				  <option value="newbook" selected >NEW</option>
				</select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">정가</th>
		    	<td><input type="text"  name="goods_price" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">판매가</th>
		    	<td> <input type="text"  name="goods_sales_price" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
		    	
			   	 
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">적립포인트</th>
		    	<td> <input type="text"  name="goods_point" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
		    	
			   	 
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">생산일</th>
		    	<td><input type="text"  name="goods_published_date" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>
		    	
			   
		    	</tr>
		    	
		    	<tr>
		    	<th scope="row">배송비</th>	
		    	<td> <input type="text"  name="goods_delivery_price" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"></td>

		    	</tr>
		    </tbody>
		    </table>
		    </div>

		    
		    <div class="tab_content" id="tab2">
			<table class="table table-hover">
			<thead>
		    <tr>
		      <th scope="col"></th>
		
		    </tr>
		     </thead>
		    <tbody class="table-group-divider">
		    	<tr>
			      <th scope="row">꽃말</th>
			      <td>
			      <div class="form-floating">
				  <textarea class="form-control" placeholder="꽃 말을 작성해 주세요" name="goods_intro" id="floatingTextarea2" style="height: 200px; width: 400px;"></textarea>
				  <label for="floatingTextarea2">꽃말을 작성해 주세요</label>
				 </div>
			      </td>
			  
			    </tr>
			</tbody>
			</table>
			</div>
			
			<div class="tab_content" id="tab3">
				<table class="table table-hover">
			<thead>
		    <tr>
		      <th scope="col"></th>
		  
		    </tr>
		     </thead>
		     
		    <tbody class="table-group-divider">
		    	<tr>
			      <th scope="row">상품이미지</th>
			     
			      <td>  <input type="button" class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; "  value="파일 추가" onClick="fn_addFile()">
			      <div id="d_file">  </div>
			      </td>
			   
			    </tr>
			</tbody>
			</table>
			</div>
			
			
			
			
			</div>
			<div class="buttonContainer mt-4">
			
			
			<input type="button" class="btn btn-dark btn-lg " style="background-color:#BEACC4; border-color:white; " value="상품 등록하기" onClick="fn_add_new_goods(this.form)">
			</div>
	
</form>	 

</div>


</BODY>