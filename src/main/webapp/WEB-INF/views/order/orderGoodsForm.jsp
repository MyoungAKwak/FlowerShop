<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- 주문자 휴대폰 번호 -->
<c:set var="orderer_hp" value="" />
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="totalDeliveryPrice" value="0" />
<!--총 적립 포인트  -->
<c:set var="total_Point" value="0" />

<head>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('roadAddress').value = fullRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}

	window.onload = function() {
		init();
	}

	function init() {
		var form_order = document.form_order;
		var h_tel1 = form_order.h_tel1;
		var h_hp1 = form_order.h_hp1;
		var tel1 = h_tel1.value;
		var hp1 = h_hp1.value;
		var select_tel1 = form_order.tel1;
		var select_hp1 = form_order.hp1;
		select_tel1.value = tel1;
		select_hp1.value = hp1;
	}

	function reset_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");

		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");

		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");

		e_receiver_name.value = "";
		e_hp1.value = 0;
		e_hp2.value = "";
		e_hp3.value = "";
		e_tel1.value = "";
		e_tel2.value = "";
		e_tel3.value = "";
		e_zipcode.value = "";
		e_roadAddress.value = "";
		e_jibunAddress.value = "";
		e_namujiAddress.value = "";
	}

	function restore_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");

		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");

		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");

		var h_receiver_name = document.getElementById("h_receiver_name");
		var h_hp1 = document.getElementById("h_hp1");
		var h_hp2 = document.getElementById("h_hp2");
		var h_hp3 = document.getElementById("h_hp3");

		var h_tel1 = document.getElementById("h_tel1");
		var h_tel2 = document.getElementById("h_tel2");
		var h_tel3 = document.getElementById("h_tel3");

		var h_zipcode = document.getElementById("h_zipcode");
		var h_roadAddress = document.getElementById("h_roadAddress");
		var h_jibunAddress = document.getElementById("h_jibunAddress");
		var h_namujiAddress = document.getElementById("h_namujiAddress");
		//alert(e_receiver_name.value);
		e_receiver_name.value = h_receiver_name.value;
		e_hp1.value = h_hp1.value;
		e_hp2.value = h_hp2.value;
		e_hp3.value = h_hp3.value;

		e_tel1.value = h_tel1.value;
		e_tel2.value = h_tel2.value;
		e_tel3.value = h_tel3.value;
		e_zipcode.value = h_zipcode.value;
		e_roadAddress.value = h_roadAddress.value;
		e_jibunAddress.value = h_jibunAddress.value;
		e_namujiAddress.value = h_namujiAddress.value;

	}

	function fn_pay_phone() {

		var e_card = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility = "hidden";
		e_phone.style.visibility = "visible";
	}

	function fn_pay_card() {
		var e_card = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility = "visible";
		e_phone.style.visibility = "hidden";
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}

	var goods_id = "";
	var goods_title = "";
	var goods_fileName = "";
	var goods_delivery_price = 0;
	var order_goods_qty
	var each_goods_price;
	var total_order_goods_price;
	var total_order_goods_qty;
	var orderer_name
	var receiver_name
	var hp1;
	var hp2;
	var hp3;

	var tel1;
	var tel2;
	var tel3;

	var receiver_hp_num;
	var receiver_tel_num;
	var delivery_address;
	var delivery_message;
	var delivery_method;
	var gift_wrapping;
	var pay_method;
	var card_com_name;
	var card_pay_month;
	var pay_orderer_hp_num;

	function fn_show_order_detail() {

		goods_id = "";
		goods_title = "";

		var frm = document.form_order;
		var h_goods_id = frm.h_goods_id;
		var h_goods_title = frm.h_goods_title;
		var h_goods_fileName = frm.h_goods_fileName;
		var r_delivery_method = frm.delivery_method;

		/*배송비 */
		var goods_delivery_price = document
				.getElementById("h_order_goods_delivery_price");
		var h_order_goods_qty = document.getElementById("h_order_goods_qty");
		var h_total_order_goods_qty = document
				.getElementById("h_total_order_goods_qty");
		var h_total_sales_price = document
				.getElementById("h_total_sales_price");
		var h_final_total_Price = document
				.getElementById("h_final_total_Price");
		var h_orderer_name = document.getElementById("h_orderer_name");
		var i_receiver_name = document.getElementById("receiver_name");

		if (h_goods_id.length < 2 || h_goods_id.length == null) {
			goods_id += h_goods_id.value;
		} else {
			for (var i = 0; i < h_goods_id.length; i++) {
				goods_id += h_goods_id[i].value + "<br>";

			}
		}

		if (h_goods_title.length < 2 || h_goods_title.length == null) {
			goods_title += h_goods_title.value;
		} else {
			for (var i = 0; i < h_goods_title.length; i++) {
				goods_title += h_goods_title[i].value + "<br>";

			}
		}

		if (h_goods_fileName.length < 2 || h_goods_fileName.length == null) {
			goods_fileName += h_goods_fileName.value;
		} else {
			for (var i = 0; i < h_goods_fileName.length; i++) {
				goods_fileName += h_goods_fileName[i].value + "<br>";

			}
		}

		total_order_goods_price = h_final_total_Price.value;
		total_order_goods_qty = h_total_order_goods_qty.value;

		for (var i = 0; i < r_delivery_method.length; i++) {
			if (r_delivery_method[i].checked == true) {
				delivery_method = r_delivery_method[i].value
				break;
			}
		}

		var r_gift_wrapping = frm.gift_wrapping;

		for (var i = 0; i < r_gift_wrapping.length; i++) {
			if (r_gift_wrapping[i].checked == true) {
				gift_wrapping = r_gift_wrapping[i].value
				break;
			}
		}

		var r_pay_method = frm.pay_method;

		for (var i = 0; i < r_pay_method.length; i++) {
			if (r_pay_method[i].checked == true) {
				pay_method = r_pay_method[i].value
				if (pay_method == "신용카드") {
					var i_card_com_name = document
							.getElementById("card_com_name");
					var i_card_pay_month = document
							.getElementById("card_pay_month");
					card_com_name = i_card_com_name.value;
					card_pay_month = i_card_pay_month.value;
					pay_method += "<Br>" + "카드사:" + card_com_name + "<br>"
							+ "할부개월수:" + card_pay_month;
					pay_orderer_hp_num = "해당없음";

				} else if (pay_method == "휴대폰결제") {
					var i_pay_order_tel1 = document
							.getElementById("pay_order_tel1");
					var i_pay_order_tel2 = document
							.getElementById("pay_order_tel2");
					var i_pay_order_tel3 = document
							.getElementById("pay_order_tel3");
					pay_orderer_hp_num = i_pay_order_tel1.value + "-"
							+ i_pay_order_tel2.value + "-"
							+ i_pay_order_tel3.value;
					pay_method += "<Br>" + "결제휴대폰번호:" + pay_orderer_hp_num;
					card_com_name = "해당없음";
					card_pay_month = "해당없음";
				} //end if
				break;
			}// end for
		}

		var i_hp1 = document.getElementById("hp1");
		var i_hp2 = document.getElementById("hp2");
		var i_hp3 = document.getElementById("hp3");

		var i_tel1 = document.getElementById("tel1");
		var i_tel2 = document.getElementById("tel2");
		var i_tel3 = document.getElementById("tel3");

		var i_zipcode = document.getElementById("zipcode");
		var i_roadAddress = document.getElementById("roadAddress");
		var i_jibunAddress = document.getElementById("jibunAddress");
		var i_namujiAddress = document.getElementById("namujiAddress");
		var i_delivery_message = document.getElementById("delivery_message");
		var i_pay_method = document.getElementById("pay_method");

		//	alert("총주문 금액:"+total_order_goods_price);
		order_goods_qty = h_order_goods_qty.value;
		//order_total_price=h_order_total_price.value;

		orderer_name = h_orderer_name.value;
		receiver_name = i_receiver_name.value;
		hp1 = i_hp1.value;
		hp2 = i_hp2.value;
		hp3 = i_hp3.value;

		tel1 = i_tel1.value;
		tel2 = i_tel2.value;
		tel3 = i_tel3.value;

		receiver_hp_num = hp1 + "-" + hp2 + "-" + hp3;
		receiver_tel_num = tel1 + "-" + tel2 + "-" + tel3;

		delivery_address = "우편번호:" + i_zipcode.value + "<br>" + "도로명 주소:"
				+ i_roadAddress.value + "<br>" + "[지번 주소:"
				+ i_jibunAddress.value + "]<br>" + i_namujiAddress.value;

		delivery_message = i_delivery_message.value;

		var p_order_goods_id = document.getElementById("p_order_goods_id");
		var p_order_goods_title = document
				.getElementById("p_order_goods_title");
		var p_order_goods_qty = document.getElementById("p_order_goods_qty");
		var p_total_order_goods_qty = document
				.getElementById("p_total_order_goods_qty");
		var p_total_order_goods_price = document
				.getElementById("p_total_order_goods_price");
		var p_orderer_name = document.getElementById("p_orderer_name");
		var p_receiver_name = document.getElementById("p_receiver_name");
		var p_delivery_method = document.getElementById("p_delivery_method");
		var p_receiver_hp_num = document.getElementById("p_receiver_hp_num");
		var p_receiver_tel_num = document.getElementById("p_receiver_tel_num");
		var p_delivery_address = document.getElementById("p_delivery_address");
		var p_delivery_message = document.getElementById("p_delivery_message");
		var p_gift_wrapping = document.getElementById("p_gift_wrapping");
		var p_pay_method = document.getElementById("p_pay_method");

		p_order_goods_id.innerHTML = goods_id;
		p_order_goods_title.innerHTML = goods_title;
		p_total_order_goods_qty.innerHTML = total_order_goods_qty + "개";
		p_total_order_goods_price.innerHTML = total_order_goods_price + "원";
		p_orderer_name.innerHTML = orderer_name;
		p_receiver_name.innerHTML = receiver_name;
		p_delivery_method.innerHTML = delivery_method;
		p_receiver_hp_num.innerHTML = receiver_hp_num;
		p_receiver_tel_num.innerHTML = receiver_tel_num;
		p_delivery_address.innerHTML = delivery_address;
		p_delivery_message.innerHTML = delivery_message;
		p_gift_wrapping.innerHTML = gift_wrapping;
		p_pay_method.innerHTML = pay_method;
		imagePopup('open');
	}

	function fn_process_pay_order() {

		alert("최종 결제하기");
		//값빼오기
		//배송정보
		var delivery_method = $('input[name=delivery_method]:checked').val();
		/* 배송방법  */
		var receiver_name = $('#receiver_name').val();
		/*수령자 이름  */
		var hp1 = $("#hp1 option:selected").val();
		var hp2 = $("#hp2").val();
		var hp3 = $("#hp2").val();
		/*연락처   */
		var zipcode = $('#zipcode').val();
		console.log("우편번호: " + zipcode);
		var roadAddress = $('#roadAddress').val();
		var roadAddress = $('#roadAddress').val();
		var jibunAddress = $('#jibunAddress').val();
		var namujiAddress = $('#namujiAddress').val();
		var delivery_address;
		delivery_address = "우편번호:" + zipcode + "<br>" + "도로명 주소:" + roadAddress
				+ "<br>" + "[지번 주소:" + jibunAddress + "]<br>" + namujiAddress;

		/* 주소 */
		var delivery_message = $('#delivery_message').val();
		var gift_wrapping = $('input[name=gift_wrapping]:checked').val();
		/* 선물  */
		//결제정보
		var pay_method = $('input[name=pay_method]:checked').val();
		var card_com_name = $("#card_com_name option:selected").val();
		var card_pay_month = $("#card_pay_month option:selected").val();
		var pay_order_tel1 = $("#pay_order_tel1 option:selected").val();
		var pay_order_tel2 = $("#pay_order_tel2").val();
		var pay_order_tel3 = $("#pay_order_tel3").val();
		var pay_orderer_hp_num = pay_order_tel1 + "-" + pay_order_tel2 + "-"
				+ pay_order_tel3;

		var usePoint = $('#h_total_sales_price').val();
		var total_point = $('#total_point').val();
		console.log("포인트 사용:" + usePoint);
		console.log("총 적립 포인트:" + total_point);

		//보내기
		var formObj = document.createElement("form");
		var i_receiver_name = document.createElement("input");

		var i_receiver_hp1 = document.createElement("input");
		var i_receiver_hp2 = document.createElement("input");
		var i_receiver_hp3 = document.createElement("input");

		var i_delivery_address = document.createElement("input");
		var i_delivery_message = document.createElement("input");
		var i_delivery_method = document.createElement("input");
		var i_gift_wrapping = document.createElement("input");
		var i_pay_method = document.createElement("input");
		var i_card_com_name = document.createElement("input");
		var i_card_pay_month = document.createElement("input");
		var i_pay_orderer_hp_num = document.createElement("input");
		var i_use_point = document.createElement("input");
		var i_total_point = document.createElement("input");

		//보내기2
		i_receiver_name.name = "receiver_name";
		i_receiver_hp1.name = "receiver_hp1";
		i_receiver_hp2.name = "receiver_hp2";
		i_receiver_hp3.name = "receiver_hp3";

		i_delivery_address.name = "delivery_address";
		i_delivery_message.name = "delivery_message";
		i_delivery_method.name = "delivery_method";
		i_gift_wrapping.name = "gift_wrapping";
		i_pay_method.name = "pay_method";
		i_card_com_name.name = "card_com_name";
		i_card_pay_month.name = "card_pay_month";
		i_pay_orderer_hp_num.name = "pay_orderer_hp_num";
		i_use_point.name = "use_point";
		i_total_point.name = "total_point";

		//보내기3
		i_receiver_name.value = receiver_name;

		i_receiver_hp1.value = hp1;
		i_receiver_hp2.value = hp2;
		i_receiver_hp3.value = hp3;

		i_delivery_address.value = delivery_address;
		i_delivery_message.value = delivery_message;
		i_delivery_method.value = delivery_method;
		i_gift_wrapping.value = gift_wrapping;
		i_pay_method.value = pay_method;
		i_use_point.value= usePoint;
		i_total_point.value= total_point;
		console.log("포인트 값확인:" + i_total_point.value);
		
		
		console.log(i_delivery_address.value);
		i_pay_orderer_hp_num.value = pay_orderer_hp_num;
		if (pay_method == "신용카드") {
			var i_card_com_name = document.getElementById("card_com_name");
			var i_card_pay_month = document.getElementById("card_pay_month");
			card_com_name = i_card_com_name.value;
			card_pay_month = i_card_pay_month.value;
			pay_method += "<Br>" + "카드사:" + card_com_name + "<br>" + "할부개월수:"
					+ card_pay_month;
			pay_orderer_hp_num = "해당없음";

		} else if (pay_method == "휴대폰결제") {
			var i_pay_order_tel1 = document.getElementById("pay_order_tel1");
			var i_pay_order_tel2 = document.getElementById("pay_order_tel2");
			var i_pay_order_tel3 = document.getElementById("pay_order_tel3");
			pay_orderer_hp_num = i_pay_order_tel1.value + "-"
					+ i_pay_order_tel2.value + "-" + i_pay_order_tel3.value;
			pay_method += "<Br>" + "결제휴대폰번호:" + pay_orderer_hp_num;
			card_com_name = "해당없음";
			card_pay_month = "해당없음";
		} //end if

		//보내기4
		formObj.appendChild(i_receiver_name);
		formObj.appendChild(i_receiver_hp1);
		formObj.appendChild(i_receiver_hp2);
		formObj.appendChild(i_receiver_hp3);

		formObj.appendChild(i_delivery_address);
		formObj.appendChild(i_delivery_message);
		formObj.appendChild(i_delivery_method);
		formObj.appendChild(i_gift_wrapping);

		formObj.appendChild(i_pay_method);
		formObj.appendChild(i_card_com_name);
		formObj.appendChild(i_card_pay_month);
		formObj.appendChild(i_pay_orderer_hp_num);
		formObj.appendChild(i_use_point);
		formObj.appendChild(i_total_point);
		
		

		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/order/payToOrderGoods.do";
		formObj.submit();  
 
	}

	function fn_point() {
		del(warningtxt);
		var point = Retention_points.value;
		var havePoint = $('#havePoint').val();
		console.log("보유포인트: " +havePoint);
		var finalPrice = h_totalPrice.value;
		var warning = document.getElementById("warning");
		var warningtxt;
		
		if(point > Number(havePoint)){
			warningtxt ="<span id='warningtxt' style='color:#B91A4D; font-size:12px;'>&nbsp;&nbsp;포인트가 부족합니다!</span>";
			warning.innerHTML+=warningtxt;
		}else if(Number(point)<=0){
			warningtxt ="<span id='warningtxt' style='color:#B91A4D; font-size:12px;'>&nbsp;&nbsp;다시 입력해주세요!</span>";
			warning.innerHTML+=warningtxt;
		}else{
		console.log(finalPrice);
		del(p_totalSalesPrice);
		del(h_total_sales_price);
		del(h_final_total_Price);
		del(p_final_totalPrice);
		

		var html = '';
		var html2 = '';
		var new_p_totalSalesPrice = document.getElementById("usePoint");
		if(point==""){
			point=Number(0);
		}
		
		html += "<p id='p_totalSalesPrice' class='fs-3'>" + point + "P</p>";
		html += "<input id='h_total_sales_price' type='hidden' value='"+point+"' />";
		new_p_totalSalesPrice.innerHTML = html;
		console.log("포인트" + h_total_sales_price.value);
		var new_finalPrice = document.getElementById("finalPrice");
		html2 += "<p id='p_final_totalPrice' class='fs-3'>"
				+ (finalPrice - point) + "원 </p>";
		html2 += "<input id='h_final_total_Price' type='hidden' value='"
				+ (finalPrice - point) + "' />";
		new_finalPrice.innerHTML = html2;}

	}

	function del(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.remove();
		}
	}
	
</script>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;

	/* background-color:rgba(0,0,0,0.8); */
}

#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 10%;
	width: 50%;
	height: 100%;
	background-color: #f0f4f4;
	border: 2px ridge gray;
	border-radius: 15px;
	opacity: 1;
}

.wrap {
	height: 100%;
	margin-top: auto;
}

#close {
	z-index: 4;
	float: right;
}

.orderContainer {
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margin-top: 50px;
	
}

.payMethodContainer {
	border: 2px solid black;
	border-radius: 8px;
}

.orderTitleFont {
	font-family: 'Gowun Batang', serif;
}
.banner{
		
		margin-top:170px;
		margin-left:auto;
		margin-right:auto;
		
		
	}
	 @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poor+Story&family=Shadows+Into+Light&display=swap');
   .fs-3{
   font-family: 'Gowun Dodum', sans-serif;
 
   }
</style>
</head>
<body>
<div class="banner " align ="center">
	      <img src="${contextPath}/resources/image/order.png" class="img-fluid" alt="order" style="width:1000px;">
	        </div>
	<div class="orderContainer">

		<form name="form_order">
			 <p class="fs-3 "><i class="bi bi-gift"></i>&nbsp;주문하기</p>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">주문상품명</th>
						<th scope="col">수량</th>
						<th scope="col">상품금액</th>
						<!-- <th scope="col">배송비</th> -->
						<th scope="col">포인트적립</th>
						<th scope="col">총 주문금액</th>
					</tr>



				</thead>
				<tbody class="table-group-divider">
					<tr>
						<c:forEach var="item" items="${myOrderList }" varStatus="cnt">

							<th scope="row"><a
								href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">

									<img
									src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
									class="figure-img img-fluid rounded"> <span
									class="orderTitleFont fs-5 fw-semibold">
										&nbsp;&nbsp;&nbsp;&nbsp;${item.goods_title} </span> <input
									type="hidden" id="h_goods_id" name="h_goods_id"
									value="${item.goods_id }" /> <input type="hidden"
									id="h_goods_fileName" name="h_goods_fileName"
									value="${item.goods_fileName }" /> <input type="hidden"
									id="h_goods_title" name="h_goods_title"
									value="${item.goods_title }" />
							</a></th>

							<td class="align-middle">
								<p class="fs-6">${item.order_goods_qty }개</p> <input
								type="hidden" id="h_order_goods_qty" name="h_order_goods_qty"
								value="${item.order_goods_qty}" />
							</td>

							<td class="align-middle">
								<p class="fs-6">${item.goods_sales_price}원</p>

							</td>
							<%--   <!-- 배송비 수정 시작 -->
           
            <c:if test="${cnt.first eq true }">
            <td id="kkjk" rowspan="${fn:length(myOrderList)}">
         	<c:choose>
			<c:when test="${total_order_price >=100000}">
			<p> 10만원이상 무료 배송</p>
			 <input   type="hidden" id="h_order_goods_delivery_price" name="h_order_goods_delivery_price"  value="0" />
			 </c:when>
			 <c:otherwise>
			 <p>${item.goods_delivery_price }원
			 </p>
			 <input type="hidden" id="h_order_goods_delivery_price" name="h_order_goods_delivery_price" value="${item.goods_delivery_price}" />
			 </c:otherwise>
			 </c:choose>
			  </td>
			 </c:if> --%>

							<td class="align-middle">
								<p class="fs-6">${item.goods_point*item.order_goods_qty}p</p>

							</td>



							<td class="align-middle">
								<p class="fs-6">${item.goods_sales_price * item.order_goods_qty}원</p>
								<input type="hidden" id="h_each_goods_price"
								name="h_each_goods_price"
								value="${item.goods_sales_price * item.order_goods_qty}" />
							</td>
					</tr>

					<c:set var="final_total_order_price"
						value="${final_total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
					<c:set var="total_order_price"
						value="${total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
					<c:set var="total_order_goods_qty"
						value="${total_order_goods_qty+item.order_goods_qty }" />
					<c:if test="${totalDeliveryPrice < item.goods_delivery_price}">
						<c:set var="totalDeliveryPrice"
							value="${item.goods_delivery_price }" />
					</c:if>
					<c:set var="total_Point"
						value="${total_Point+item.goods_point*item.order_goods_qty}" />
						
					</c:forEach>
					<input id="total_point" type="hidden" value="${total_Point }"/>
				</tbody>
			</table>


			<!-- 배송정보! -->
			<p class="fs-3 mb-1 fst-italic mt-5">
				<p class="fs-3 "><i class="bi bi-gift"></i>&nbsp;배송정보</p>
			</p>
			<DIV class="detail_table">
				<table class="table table-hover ">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col"></th>
							<th scope="col"></th>
							<th scope="col"></th>
							<th scope="col"></th>

						</tr>
					</thead>

					<tbody class="table-group-divider">
						<tr>
							<th scope="row">배송방법</th>

							<td>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="delivery_method" value="일반택배" checked> <label
										class="form-check-label" for="inlineRadio1">일반택배</label>
								</div>

								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="delivery_method" value="예약배송"> <label
										class="form-check-label" for="inlineRadio2">예약배송</label>
								</div>
							</td>

							<td></td>
							<td></td>
							<td></td>
							<td></td>

						</tr>
						<!--배송방법  -->

						<tr>
							<th scope="row">배송지 선택</th>

							<td>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="delivery_place" onClick="restore_all()" value="기본배송지"
										checked> <label class="form-check-label"
										for="inlineRadio1">기본배송지</label>
								</div>

								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="delivery_place" id="delivery_method" value="새로입력"
										onClick="reset_all()"> <label class="form-check-label"
										for="inlineRadio2">새로입력</label>
								</div>
							</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<!--  배송지입력란 -->

						<tr>
							<th scope="row">받으실분</th>
							<td><input type="text" name="receiver_name"
								id="receiver_name" class="form-control"
								value="${orderer.member_name}" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"> <input
								type="hidden" id="h_orderer_name" name="h_orderer_name"
								value="${orderer.member_name }" /> <input type="hidden"
								id="h_receiver_name" name="h_receiver_name"
								value="${orderer.member_name }" /></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<!--수령자 이름 디폴트는 해당 회원  -->

						<tr>
							<th scope="row">연락처</th>

							<td><select class="form-select" name="hp1" id="hp1"
								aria-label="Default select example">
									<option selected value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							</select></td>

							<td><input type="text" name="hp2" id="hp2"
								value="${orderer.hp2 }" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td><input type="text" name="hp3" id="hp3"
								value="${orderer.hp3 }" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td></td>
							<td></td>
							<input type="hidden" id="h_hp1" name="h_hp1"
								value="${orderer.hp1 }" />
							<input type="hidden" id="h_hp2" name="h_hp2"
								value="${orderer.hp2 }" />
							<input type="hidden" id="h_hp3" name="h_hp3"
								value="${orderer.hp3 }" />

							<c:set var="orderer_hp"
								value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }" />
						</tr>

						<!--연락처 정보 -->

						<tr>
							<th scope="row">주소</th>

							<td><input type="text" id="zipcode" name="zipcode"
								value="${orderer.zipcode }" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td><p class="fw-light mt-2">
									<a href="javascript:execDaumPostcode()">우편번호검색</a>
								</p></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<!--우편번호  -->

						<tr>
							<th scope="row">지번</th>
							<td colspan="3"><input type="text" id="roadAddress"
								name="roadAddress" value="${orderer.roadAddress }"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td></td>
							<td></td>
						</tr>

						<!-- 지번 -->

						<tr>
							<th scope="row">도로명</th>
							<td colspan="3"><input type="text" id="jibunAddress"
								name="jibunAddress" value="${orderer.jibunAddress }"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td></td>
							<td></td>
						</tr>

						<!-- 도로명 -->

						<tr>
							<th scope="row">나머지</th>
							<td colspan="3"><input type="text" name="namujiAddress"
								id="namujiAddress" value="${orderer.namujiAddress }"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td></td>
							<td></td>
							<input type="hidden" id="h_zipcode" name="h_zipcode"
								value="${orderer.zipcode }" />
							<input type="hidden" id="h_roadAddress" name="h_roadAddress"
								value="${orderer.roadAddress }" />
							<input type="hidden" id="h_jibunAddress" name="h_jibunAddress"
								value="${orderer.jibunAddress }" />
							<input type="hidden" id="h_namujiAddress" name="h_namujiAddress"
								value="${orderer.namujiAddress }" />
						</tr>
						<!-- 나머지  -->

						<tr>
							<th scope="row">배송 메세지</th>
							<td colspan="3"><input type="text" name="delivery_message"
								id="delivery_message" class="form-control"
								placeholder="메세지와 함께 마음을 전달하세요"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<!--배송 메세지  -->

						<tr>
							<th scope="row">선물 포장</th>

							<td>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="gift_wrapping" id="gift_wrapping" value="YES" checked>
									<label class="form-check-label" for="inlineRadio1">YES</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="gift_wrapping" id="gift_wrapping" value="NO"> <label
										class="form-check-label" for="inlineRadio2">NO</label>
								</div>
							</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<!--선물 포장  -->

						<tr>
							<th scope="row">보유 포인트</th>

							<td>
								<!--  <p class="fs-6 mt-5">포인트</p>  --> 
								${orderer.member_point}
								<input id="havePoint" type="hidden" value="${orderer.member_point}"/>
							</td>

							<td id="warning"><input id="Retention_points" type="text"
								name="discount_juklip" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-sm"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '')"
								
								placeholder="숫자만 입력 가능합니다."></td>

							<td>
								<button type="button"
									class="btn btn-secondary btn-sm mt-1 mr-auto" style="background-color:#BEACC4; border-color:white; "
									onclick="fn_point()">포인트사용</button>
							</td>

							<td></td>
							<td></td>
							<td></td>
						</tr>

					</tbody>
				</table>

			</div>


			
			<p class="fs-3 "><i class="bi bi-gift"></i>&nbsp;결제하기</p>
			



			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">총 상품수</th>
						<th scope="col">총 배송비</th>
						<th scope="col">총 상품금액</th>
						<th scope="col">포인트 할인</th>
						<th scope="col">최종 결재금액</th>
					</tr>
				</thead>

				<tbody class="table-group-divider">
					<tr>
						<th scope="row">
							<p id="p_totalNum" class="fs-3">${total_order_goods_qty}개</p> <input
							id="h_total_order_goods_qty" type="hidden"
							value="${total_order_goods_qty}" />
						</th>
						<!-- 총 상품 수 -->


						<c:choose>
							<c:when test="${total_order_price >=100000}">
								<td>
									<p id="p_h_totalDeliver" class="fs-3">10만원이상 무료 배송</p> <input
									id="h_totalDelivery" type="hidden" value="0" />
								<td>
									<p id="p_totalPrice" class="fs-3">${total_order_price}원</p> <input
									id="h_totalPrice" type="hidden" value="${total_order_price}" />
								</td>
							</c:when>

							<c:otherwise>
								<td>
									<p id="p_h_totalDeliver" class="fs-3">${totalDeliveryPrice }원
									</p> <input id="h_totalDelivery" type="hidden"
									value="${totalDeliveryPrice }" />
								</td>
								<td>
									<p id="p_totalPrice" class="fs-3">${total_order_price + totalDeliveryPrice}원
									</p> <input id="h_totalPrice" type="hidden"
									value="${total_order_price+totalDeliveryPrice}" />
								</td>
								<c:set var="final_total_order_price"
									value="${total_order_price + totalDeliveryPrice }" />
							</c:otherwise>
						</c:choose>


						<!-- 배송비 -->

						<!-- 판매가 
			<td>
	         <p id="p_totalPrice" class="fs-3">${total_order_price}원   </p>
	         <input id="h_totalPrice" type="hidden" value="${total_order_price}" />
	        </td>
	        	 판매가 -->


						<!--  할인가 
	     	<td>
	         <p id="p_totalSalesPrice" class="fs-3">${total_discount_price }원   </p>
	         <input id="h_total_sales_price" type="hidden" value="${total_discount_price}" />
	        </td>
	        -->


						<td id="usePoint">
							<p id="p_totalSalesPrice" class="fs-3">0P</p>
							 <input id="h_total_sales_price" type="hidden"
							value="${total_discount_price}" />
						</td>

						<!-- 포인트 -->




						<!-- 최종결제액 -->

						<td id="finalPrice">
							<p id="p_final_totalPrice" class="fs-3">${final_total_order_price }원
							</p> <input id="h_final_total_Price" type="hidden"
							value="${final_total_order_price}" />
						</td>
						<!-- 결제액  -->
				</tbody>
			</table>



			<div class="warp d-flex justify-content-center">
				<div class="payMethodContainer mt-5 w-50 ">
					<table class="table table-hover ">

						<thead class="table-Secondary">
							<tr>
								<th scope="col">결제수단</th>
								<th scope="col"></th>
								<th scope="col"></th>

							</tr>
						</thead>

						<tbody class="table-group-divider ">
							<tr>
								<th scope="row">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="pay_method"
											id="pay_method" value="신용카드" onClick="fn_pay_card()" checked>
										<label class="form-check-label" for="inlineRadio1">신용카드</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="pay_method"
											id="pay_method" value="휴대폰결제" onClick="fn_pay_phone()">
										<label class="form-check-label" for="inlineRadio2">휴대폰결제</label>
									</div>
								</th>
								<td></td>
								<td></td>
							</tr>
							<!-- 결제수단  -->


							<tr id="tr_pay_card">
								<th scope="row">카드/할부</th>
								<td><select id="card_com_name" name="card_com_name">
										<option value="삼성" selected>삼성</option>
										<option value="하나SK">하나SK</option>
										<option value="현대">현대</option>
										<option value="KB">KB</option>
										<option value="신한">신한</option>
										<option value="롯데">롯데</option>
										<option value="BC">BC</option>
										<option value="시티">시티</option>
										<option value="NH농협">NH농협</option>
								</select></td>
								<!-- 카드사 -->

								<td><select id="card_pay_month" name="card_pay_month">
										<option value="일시불" selected>일시불</option>
										<option value="2개월">2개월</option>
										<option value="3개월">3개월</option>
										<option value="4개월">4개월</option>
										<option value="5개월">5개월</option>
										<option value="6개월">6개월</option>
								</select></td>
							</tr>
							<!--할부-->


							<tr id="tr_pay_phone" style="visibility: hidden">
								<th scope="row"><select class="form-select"
									name="pay_order_tel1" id="pay_order_tel1"
									aria-label="Default select example">
										<option selected value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select></th>
								<!-- 앞번호 -->


								<td><input type="text" name="pay_order_tel2"
									id="pay_order_tel2" value="" class="form-control"
									aria-label="Sizing example input"
									aria-describedby="inputGroup-sizing-sm"></td>
								<!-- 중간 -->

								<td><input type="text" name="pay_order_tel3"
									id="pay_order_tel3" value="" class="form-control"
									aria-label="Sizing example input"
									aria-describedby="inputGroup-sizing-sm"></td>
								<!-- 끝 -->
							</tr>
							<!-- 휴대전화 결제  -->

						</tbody>

					</table>
				</div>
			</div>
		</form>
		<div class="buttonRow justify-content-center">
			<!-- <a class="btn btn-outline-dark btn-md" href="javascript:fn_show_order_detail();" role="button">결제하기</a> -->
			<!--  <a class="btn btn-outline-dark btn-md" name="btn_process_pay_order" href="javascript:fn_process_pay_order();"  role="button">결제하기</a> -->

			<button type="button" name="btn_process_pay_order"
				class="btn btn-dark btn-md" onClick="fn_process_pay_order()" style="background-color:#BEACC4; border-color:white; ">결제하기</button>
			<a class="btn btn-dark btn-md"
				href="${contextPath}/main/main.do" role="button" style="background-color:#BEACC4; border-color:white; ">쇼핑계속하기</a>
		</div>




		<%-- <div id="layer" style="visibility:hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup_order_detail">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
			 <img  src="${contextPath}/resources/image/close.png" id="close" />
			</a> 
			<br/> 
			<div class="wrap">
			  <div class="detail_table"> 
			
		
				<table class="table table-sm">
				  <thead>
				    <tr>
				      <th scope="col">주문서</th>
				      <th scope="col"></th>
				      <th scope="col"></th>
				      <th scope="col"></th>
				    </tr>
				  </thead>
				  
				<tbody class="table-group-divider">
			    <tr>
			      <th scope="row">주문번호</th>
			      <td><p id="p_order_goods_id"></td>
			      <td></td>
			      <td></td>
			    </tr>

				  <tr>
					  <th scope="row">주문상품명</th>
					  <td> <p id="p_order_goods_title"></td>
				</tr>
				 
				   <tr>
					  <th scope="row">갯수</th>
				 	  <td><p id="p_total_order_goods_qty"></td>
				   </tr>
				   
				   <tr>
					  <th scope="row">주문금액</th>
					<td><p id="p_total_order_goods_price"></td>
				   </tr>
				   
				   
				    <tr>
					  <th scope="row">주문자</th>
					<td><p id="p_orderer_name"></td>
				   </tr>
				   
				    <tr>
					  <th scope="row">받는사람</th>
					<td><p id="p_receiver_name"></td>
				   </tr>
				   
				   	<tr>
					  <th scope="row">배송방법</th>
					<td><p id="p_delivery_method"></td>
				   </tr>
				   
					<tr>
					  <th scope="row">연락처</th>
					<td><p id="p_receiver_hp_num"></td>
				   </tr>
				 
				 	<tr>
					  <th scope="row">배송주소</th>
					<td><p id="p_delivery_address"></td>
				   </tr>
				   
				    <tr>
					  <th scope="row">메세지</th>
					<td><p id="p_delivery_message"></td>
				   </tr>
				   
				     <tr>
					  <th scope="row">선물포장 여부</th>
					<td><p id="p_gift_wrapping"></td>
				   </tr>
				   
				     <tr>
					  <th scope="row">결제방법</th>
					<td><p id="p_pay_method"></td>
				   </tr>
					<tr>
					<th scope="row"></th>
					<td>    <input  name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기"></td>
				
					</tr>

				</tbody>
				</table>
			</div>
			</div>
		</div>	 
		</div>
		--%>







	</div>

</body>