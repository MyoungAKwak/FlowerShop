<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="euc-kr"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goods}"  />
<c:set var="imageFileList"  value="${goodsMap.imageFileList}"  />

<c:choose>
<c:when test='${not empty goods.goods_status}'>
<script>
window.onload=function()
{
	init();
}

function init(){
	var frm_mod_goods=document.frm_mod_goods;
	var h_goods_status=frm_mod_goods.h_goods_status;
	var goods_status=h_goods_status.value;
	var select_goods_status=frm_mod_goods.goods_status;
	 select_goods_status.value=goods_status;
}
</script>
</c:when>
</c:choose>
<script type="text/javascript">
function fn_modify_goods(goods_id, attribute){
	var frm_mod_goods=document.frm_mod_goods;
	var value="";
	if(attribute=='goods_sort'){
		value=frm_mod_goods.goods_sort.value;
	}else if(attribute=='goods_title'){
		value=frm_mod_goods.goods_title.value;
	}else if(attribute=='goods_price'){
		value=frm_mod_goods.goods_price.value;
	}else if(attribute=='goods_sales_price'){
		value=frm_mod_goods.goods_sales_price.value;
	}else if(attribute=='goods_point'){
		value=frm_mod_goods.goods_point.value;
	}else if(attribute=='goods_published_date'){
		value=frm_mod_goods.goods_published_date.value;
	}else if(attribute=='goods_delivery_price'){
		value=frm_mod_goods.goods_delivery_price.value;
	}else if(attribute=='goods_status'){
		value=frm_mod_goods.goods_status.value;
	}else if(attribute=='goods_intro'){
		value=frm_mod_goods.goods_intro.value;
	}

	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
		data : {
			goods_id:goods_id,
			attribute:attribute,
			value:value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("상품 정보를 수정했습니다.");
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



  function readURL(input,preview) {
	//  alert(preview);
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+preview).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
  }  

  var cnt =1;
  function fn_addFile(){
	
	  $("#d_file").append("<img  id='previewImage"+cnt+"'   width=200 height=200  />");
	  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' id='detail_image"+cnt+"' class='form-control w-75'  onchange=readURL(this,'previewImage"+cnt+"') />");
	  $("#d_file").append("<input  type='button' value='추가' class='btn btn-outline-dark btn-sm'  onClick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image')  />"+"<br><br>");
	  cnt++;
  }
  
  function modifyImageFile(fileId,goods_id, image_id,fileType){
    // alert(fileId);
	  var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("fileName", $('#'+fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("image_id", image_id);
      formData.append("fileType", fileType);
      
      $.ajax({
        url: '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
	      success: function(result){
	         alert("이미지를 수정했습니다!");
	       }
      });
  }
  
  function addNewImageFile(fileId,goods_id, fileType){
	   //  alert(fileId);
		  var form = $('#FILE_FORM')[0];
	      var formData = new FormData(form);
	      formData.append("uploadFile", $('#'+fileId)[0].files[0]);
	      formData.append("goods_id", goods_id);
	      formData.append("fileType", fileType);
	      
	      $.ajax({
	          url: '${contextPath}/admin/goods/addNewGoodsImage.do',
	                  processData: false,
	                  contentType: false,
	                  data: formData,
	                  type: 'post',
	                  success: function(result){
	                      alert("이미지를 수정했습니다!");
	                  }
	          });
	  }
  
  function deleteImageFile(goods_id,image_id,imageFileName,trId){
	var tr = document.getElementById(trId);

      	$.ajax({
    		type : "post",
    		async : true, //false인 경우 동기식으로 처리한다.
    		url : "${contextPath}/admin/goods/removeGoodsImage.do",
    		data: {goods_id:goods_id,
     	         image_id:image_id,
     	         imageFileName:imageFileName},
    		success : function(data, textStatus) {
    			alert("이미지를 삭제했습니다!!");
                tr.style.display = 'none';
    		},
    		error : function(data, textStatus) {
    			alert("에러가 발생했습니다."+textStatus);
    		},
    		complete : function(data, textStatus) {
    			//alert("작업을완료 했습니다");
    			
    		}
    	}); //end ajax	
  }
</script>
<style>
.modifyContainer{
	display: flex;
	justify-content:center;
	flex-direction: column;
	align-items: center;
	margin-top:50px;
	margin-left: auto;
	margin-right:auto;
}
.banner{
	
	margin-top:170px;
	margin-left:auto;
	margin-right:auto;
	width: 1100px;
	
}
 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
</style>
</HEAD>
<BODY>
	<div class="banner " align ="center">
	            <img src="${contextPath}/resources/image/admin_goods.png" class="img-fluid" alt="admin">
	        </div>
<div class="modifyContainer">
<form  name="frm_mod_goods"  method=post >

	<!-- 내용 들어 가는 곳 -->
		
			<div class="tabs_container  ">
			 <p class="text-center fs-3 "><i class="bi bi-gift"></i>&nbsp;상품 정보 수정</p>
			<ul class="tabs pb-auto">
			<li style="list-style:none; float:left; margin: 0px 5px ;" ><a class="btn btn-dark btn-lg" 
			href="#tab1" role="button" style="background-color:#BEACC4; border-color:white; "><i class="bi bi-flower3"></i>&nbsp;상품정보&nbsp;&nbsp;</a></li>&nbsp;
			
			<li style="list-style:none; float:left; margin: 0px 5px ;"><a class="btn btn-dark btn-lg" 
			href="#tab2" role="button" style="background-color:#BEACC4; border-color:white; "><i class="bi bi-flower3"></i>&nbsp;꽃말&nbsp;&nbsp;</a></li>&nbsp;
			
			<li style="list-style:none; float:left; margin: 0px 5px ;"><a class="btn btn-dark btn-lg" 
			href="#tab3" role="button" style="background-color:#BEACC4; border-color:white; "><i class="bi bi-flower3"></i>&nbsp;상품이미지&nbsp;&nbsp;</a></li>		
			</ul>
			</div>
		
		<DIV class="tab_container">
			<DIV class="tab_content" id="tab1">
			<table class="table table-hover">
			<thead>
		    <tr>
		      <th scope="col"></th>
		      
		    </tr>
		     </thead>
		        <tbody class="table-group-divider">
		    	<tr>
			      <th scope="row">꽃 종류</th>
			      <td> 
			      <input type="text"  name="goods_sort" class="form-control" 
			      aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" 
			      value="${goods.goods_sort }">
			      </td>
			   		<td>
			   		 <input type="button" class="btn btn-dark btn-sm " style="background-color:#BEACC4; border-color:white; " value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_sort')">
			   		
			   		 
			   		</td>
			    </tr>
				
			
			<tr>
				<th scope="row">꽃 이름</th>
			
				<td>		 
			      <input type="text"  name="goods_title" class="form-control" 
			      aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" 
			      value="${goods.goods_title}">
				</td>

				<td>
				 <input type="button" class="btn btn-dark btn-sm " style="background-color:#BEACC4; border-color:white; "value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_title')">
			
				</td>
				
			</tr>
			
		
			<tr>
		    <th scope="row">정가</th>
		    <td><input type="text"  name="goods_price" class="form-control"  value="${goods.goods_price }"
		    aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    </td>	
		    
		    <td>	 
		    	 <input type="button" class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; " value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_price')">
		   
		    </td>
		    </tr>
			
			

				<tr>
		    	<th scope="row">판매가</th>
		    	<td> <input type="text"  name="goods_sales_price" class="form-control"  value="${goods.goods_sales_price }"
		    	aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    	</td>
		    	
		    	<td>
		    	<input type="button" class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; " value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_sales_price')">
		 
		    	</td>
		    	
			   	 
		    	</tr>
		
				
		    	<tr>
		    	<th scope="row">적립포인트</th>
		    	<td> <input type="text"  name="goods_point" class="form-control"  value="${goods.goods_point }" 
		    	aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    	</td>		    
		    	
				<td>
				<input type="button" class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; " value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_point')">
		
				</td>
		    	
		    	</tr>
	

		  	 	<tr>
		    	<th scope="row">생산일</th>
		    	<td><input type="text"  name="goods_published_date" class="form-control" value="${goods.goods_published_date }"
		    	aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    	</td>
		    	<td>
		    		<input type="button" class="btn btn-dark btn-sm " style="background-color:#BEACC4; border-color:white; "value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_published_date')">
		
				
				</td>

		    	</tr>
		    	
			  	<tr>
		    	<th scope="row">배송비</th>	
		    	<td> <input type="text"  name="goods_delivery_price" class="form-control"  value="${goods.goods_delivery_price }"
		    	aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		    	</td>
				<td>
				<input type="button" class="btn btn-dark btn-sm " style="background-color:#BEACC4; border-color:white; "value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_price')">
				 
				</td>
		    	</tr>
		
			

			<tr>
		    	<th scope="row">상품종류</th>
		    	<td>
		    	<select name="goods_status" class="form-select">
				  <option value="bestseller"  >BEST</option>
				  <option value="steadyseller" >STEADY</option>
				  <option value="newbook" selected >NEW</option>
				</select>
				<input  type="hidden" name="h_goods_status" value="${goods.goods_status }"/>
		    	</td>
		    	<td>
		    			<input type="button" class="btn btn-dark btn-sm " style="background-color:#BEACC4; border-color:white; "value="수정 반영" onClick="fn_modify_goods('${goods.goods_id }','goods_status')">
		
		    	</td>
		    	</tr>
			
		
				</tbody>
				</table>	
			</DIV>
		
			<DIV class="tab_content" id="tab2">
			  
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
				  <textarea class="form-control" placeholder="꽃 말을 작성해 주세요" name="goods_intro" id="floatingTextarea2" style="height: 200px; width: 400px;">${goods.goods_intro }</textarea>
				  <label for="floatingTextarea2">꽃말을 작성해 주세요</label>
				 </div>
			      </td>
			  	 <td> 	
			  	  <input  type="button" value="수정반영"   class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; "
			  	  onClick="fn_modify_goods('${goods.goods_id }','goods_intro')"/>
			  	  </td>
			    </tr>
			</tbody>
			</table>
			</div>
			
	
			<DIV class="tab_content" id="tab3">
			  <form id="FILE_FORM" method="post" enctype="multipart/form-data"  >
				<table class="table table-hover">
			<thead>
		    <tr>
		      <th scope="col">
		        
		      </th>
		  
		    </tr>
		     </thead>
		     
		    <tbody class="table-group-divider">
		    	<tr>
		    	 <c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
				 <c:choose>
				<c:when test="${item.fileType=='main_image' }">
			      <th scope="row">메인이미지</th>
			      	
			      <td> 
			      <input  type='file' name='main_image' id='main_image' class='form-control ' onchange="readURL(this,'preview${itemNum.count}');"/>
			     	<input type="hidden"  name="image_id" value="${item.image_id}"  />
			     </td>
			     	
			    
			    <td>
				 <img  id="preview${itemNum.count }"   
				 width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
			   </td>
					
				<td>
				<input type="button" class="btn btn-dark btn-sm " value="수정" style="background-color:#BEACC4; border-color:white; "
			 	   onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')">
			
			   </td> 	   
			    </tr>
			    
			 </c:when>
			<c:otherwise>
			<tr>
			<th scope="row" id="${itemNum.count-1}">상세 이미지${itemNum.count-1 }</th>
			
			 <td>
			 	   <input  type='file' name='detail_image' id='detail_image' class='form-control ' 
			 	      onchange="readURL(this,'preview${itemNum.count}');"/>
		
			    <input type="hidden"  name="image_id" value="${item.image_id }"  />
			 </td>
			    <td>
				 <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}">
			   </td>
			   
			 <td>
			 	  <input type="button" class="btn btn-dark btn-sm " value="수정" style="background-color:#BEACC4; border-color:white; "
			 	  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')">
			 	  	  <input type="button" class="btn btn-dark btn-sm " value="삭제" style="background-color:#BEACC4; border-color:white; "
			 	  	   onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')">
			
			   </td> 
			</tr>
			</c:otherwise>
		  </c:choose>		
		</c:forEach>
		<tr>
		<th scope="row"></th>
		<td>
		 <div id="d_file"></div>
		  <input type="button" class="btn btn-dark btn-sm "style="background-color:#BEACC4; border-color:white; " value="파일 추가" onClick="fn_addFile()">
		 </td>
		 <td></td>
		 <td></td>
		
		</tr>
			</tbody>
			
			</table>
			</form>
			</div>
			
		</DIV>
		</form>
		</div>
		
</BODY>