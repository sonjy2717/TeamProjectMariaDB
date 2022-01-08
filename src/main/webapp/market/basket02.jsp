<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../util/IsLoggedIn.jsp" %>

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
			
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } 
            else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
			
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            	
            } 
            else {
                document.getElementById("sample6_extraAddress").value = '';
            }
			
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}



function sample7_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
			
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } 
            else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
			
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample7_extraAddress").value = extraAddr;
            	
            } 
            else {
                document.getElementById("sample7_extraAddress").value = '';
            }
			
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample7_postcode').value = data.zonecode;
            document.getElementById("sample7_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample7_detailAddress").focus();
        }
    }).open();
}


function edit(idx) {
	var form = document.frm;
	var choice_count = document.getElementById("count_"+idx).value;
	
	form.basket_idx.value = idx;
	form.basket_count.value = choice_count;
	
	if (choice_count <= 0) {
		alert("수량은 0개 이하로 설정할 수 없습니다.");
		return;
	}
	
	form.method = "post";
	form.action = "../market/buyedit.do";
	form.submit();
}


function deleteList() {
	var check = new Array();
	check = document.getElementsByName("product");
	
	if (check.length == 0) {
		alert("장바구니가 비어있습니다.");
		return;
	}
	
	frm.method = "post";
	frm.action = "../market/buydelete.do";
	frm.submit();
}



function validateForm(form) {
	if (form.name.value == "") {
		alert("이름을 입력하세요.");
		form.name.focus();
		return false;
	}
	if (form.postcode.value == "") {
		alert("주소를 입력하세요.");
		form.postcode.focus();
		return false;
	}
	if (form.detailadd.value == "") {
		alert("상세주소를 입력하세요.");
		form.detailadd.focus();
		return false;
	}
	if (form.phone1.value == "") {
		alert("연락처를 입력하세요.");
		form.phone1.focus();
		return false;
	}
	if (form.phone2.value == "") {
		alert("연락처를 입력하세요.");
		form.phone2.focus();
		return false;
	}
	if (form.phone3.value == "") {
		alert("연락처를 입력하세요.");
		form.phone3.focus();
		return false;
	}
	if (form.email1.value == "") {
		alert("이메일을 입력하세요.");
		form.email1.focus();
		return false;
	}
	if (form.email2.value == "") {
		alert("이메일을 입력하세요.");
		form.email2.focus();
		return false;
	}
	
	if (form.name_.value == "") {
		alert("이름을 입력하세요.");
		form.name_.focus();
		return false;
	}
	if (form.postcode_.value == "") {
		alert("주소를 입력하세요.");
		form.postBtn_.focus();
		return false;
	}
	if (form.detailadd_.value == "") {
		alert("상세주소를 입력하세요.");
		form.address3_.focus();
		return false;
	}
	if (form.phone1_.value == "") {
		alert("연락처를 입력하세요.");
		form.phone1_.focus();
		return false;
	}
	if (form.phone2_.value == "") {
		alert("연락처를 입력하세요.");
		form.phone2_.focus();
		return false;
	}
	if (form.phone3_.value == "") {
		alert("연락처를 입력하세요.");
		form.phone3_.focus();
		return false;
	}
	if (form.email1_.value == "") {
		alert("이메일을 입력하세요.");
		form.email1_.focus();
		return false;
	}
	if (form.email2_.value == "") {
		alert("이메일을 입력하세요.");
		form.email2_.focus();
		return false;
	}
	if (form.payment.value == "") {
		alert("결제방법을 선택해 주세요.")
		return false;
	}
	
	form.method = "post";
	form.action = "../market/order.do";
	form.submit();
}

function selectYesNo(flag) {
	var form = document.frm;
	
	if (flag == 'yes') {
		form.name_.value = form.name.value;
		form.postcode_.value = form.postcode.value;
		form.basicadd1_.value = form.basicadd1.value;
		form.basicadd2_.value = form.basicadd2.value;
		form.detailadd_.value = form.detailadd.value;
		form.phone1_.value = form.phone1.value;
		form.phone2_.value = form.phone2.value;
		form.phone3_.value = form.phone3.value;
		form.email1_.value = form.email1.value;
		form.email2_.value = form.email2.value;
		form.select_email_.value = form.select_email.value;
	}
	else if (flag == 'no') {
		form.name_.value = "";
		form.postcode_.value = "";
		form.basicadd1_.value = "";
		form.basicadd2_.value = "";
		form.detailadd_.value = "";
		form.phone1_.value = "";
		form.phone2_.value = "";
		form.phone3_.value = "";
		form.email1_.value = "";
		form.email2_.value = "";
		form.select_email_.value = ""
	}
}

//이메일 골라서 인풋박스에 집어넣는 작업과 직접 입력 누를때 외에는 작성 못하도록 disabled 속성 추가.
function email_input(frm) {
	
	var domain1 = select_email.value;
	
	if(domain1 == '') { //--선택-- 부분을 선택했을때 
	    frm.email1.value = ''; //모든 입력값을 지운다.
	    frm.email2.value = '';
	}
	else if(domain1 == '직접입력') { //직접입력을 선택했을때
	    frm.email2.readOnly = false; //사용자가 입력해야 하므로 readonly속성을 해제한다.
	    frm.email2.value = '';
	    frm.email2.focus();
	}
	else{ //도메인을 선택했을때
	    frm.email2.value = domain1; //선택한 도메인을 입력한다.
	    frm.email2.readOnly = true; //입력된 값을 수정할 수 없도록 readonly속성을 활성화한다.
	}
	
	var domain2 = select_email_.value;
	
	if(domain2 == '') { //--선택-- 부분을 선택했을때 
	    frm.email1_.value = ''; //모든 입력값을 지운다.
	    frm.email2_.value = '';
	}
	else if(domain2 == '직접입력') { //직접입력을 선택했을때
	    frm.email2_.readOnly = false; //사용자가 입력해야 하므로 readonly속성을 해제한다.
	    frm.email2_.value = '';
	    frm.email2_.focus();
	}
	else{ //도메인을 선택했을때
	    frm.email2_.value = domain2; //선택한 도메인을 입력한다.
	    frm.email2_.readOnly = true; //입력된 값을 수정할 수 없도록 readonly속성을 활성화한다.
	}
	
}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<form name="frm">
				<input type="hidden" name="basket_idx" value="" />
				<input type="hidden" name="basket_count" value="" />
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${ empty list }">
						<tr>
							<td colspan="9" align="center">
								장바구니가 비었습니다.
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ list }" var="row" varStatus="loop">
						<input type="hidden" name="idx" value="${ row.idx }" />
						<tr align="center">
							<td><input type="checkbox" name="product" value="${ row.idx }" /></td>
							<td><img src="../images/market/${ row.img }" width="50px"/></td>
							<td>${ row.name }</td>
							<td>${ row.price }원</td>
							<td><img src="../images/market/j_icon.gif" />${ row.point }원</td>
							<td>
								<input type="number" id="count_${ row.idx }" value="${ row.count }" class="basket_num" style="width: 40px;"/>&nbsp;
								<img src="../images/market/m_btn.gif" onclick="edit('${ row.idx }');" />
							</td>
							<td>무료배송</td>
							<td>[무료]</td>
							<td><span>${ row.total }</span></td>
						</tr>
						</c:forEach>
					</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<button style="margin-top: 10px;" type="button" align="left" onclick="deleteList();">선택삭제</button>
				<p class="basket_text" style="margin-bottom: 30px;">
					합계 : ${ total }<span class="money"></span>
				</p>
				
				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;">
								<input type="text" name="name" value="" class="join_input" />
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;">
								<input type="text" name="postcode" value="" class="join_input" id="sample6_postcode" style="width:70px; margin-bottom:5px;" readonly /> 
								<img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" onclick="sample6_execDaumPostcode()" />
								<br />
								<input type="text" name="basicadd1" value="" class="join_input" id="sample6_address" style="width:250px; margin-bottom:5px;" readonly />
								<input type="text" name="basicadd2" class="join_input" id="sample6_extraAddress" style="width: 250px; margin-bottom:5px;" readonly>
								<br />
								<input type="text" name="detailadd" value="" class="join_input" id="sample6_detailAddress" style="width:250px;" />
							</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="phone1" value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone2"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone3"  value="" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;">
								<input type="text" name="email1" value="" class="join_input" style="width:100px;" /> @
								<input type="text" name="email2" value="" class="join_input" style="width:100px;" />
								<select name="select_email" onchange="email_input(this.form);" id="select_email" >
									<option selected="" value="">선택해주세요</option>
									<option value="직접입력" >직접입력</option>
									<option value="dreamwiz.com" >dreamwiz.com</option>
									<option value="empal.com" >empal.com</option>
									<option value="empas.com" >empas.com</option>
									<option value="freechal.com" >freechal.com</option>
									<option value="hanafos.com" >hanafos.com</option>
									<option value="hanmail.net" >hanmail.net</option>
									<option value="hotmail.com" >hotmail.com</option>
									<option value="intizen.com" >intizen.com</option>
									<option value="korea.com" >korea.com</option>
									<option value="kornet.net" >kornet.net</option>
									<option value="msn.co.kr" >msn.co.kr</option>
									<option value="nate.com" >nate.com</option>
									<option value="naver.com" >naver.com</option>
									<option value="netian.com" >netian.com</option>
									<option value="orgio.co.kr" >orgio.co.kr</option>
									<option value="paran.com" >paran.com</option>
									<option value="sayclub.com" >sayclub.com</option>
									<option value="yahoo.co.kr" >yahoo.co.kr</option>
									<option value="yahoo.com" >yahoo.com</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				
				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 
					예<input type="radio" name="yesno" value="yes" onclick="selectYesNo(this.value)" /> 
					아니오<input type="radio" name="yesno" value="no" onclick="selectYesNo(this.value)" />
				</p>
				
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom: 50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;">
								<input type="text" name="name_" value="" class="join_input" />
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;">
								<input type="text" name="postcode_" value="" class="join_input" id="sample7_postcode" style="width:70px; margin-bottom:5px;" readonly /> 
								<img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" onclick="sample7_execDaumPostcode()" />
								<br />
								<input type="text" name="basicadd1_" value="" class="join_input" id="sample7_address" style="width:250px; margin-bottom:5px;" readonly />
								<input type="text" name="basicadd2_" class="join_input" id="sample7_extraAddress" style="width: 250px; margin-bottom:5px;" readonly>
								<br />
								<input type="text" name="detailadd_" value="" class="join_input" id="sample7_detailAddress" style="width:250px;" />
							</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="phone1_" value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone2_"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone3_"  value="" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;">
								<input type="text" name="email1_" value="" class="join_input" style="width:100px;" /> @
								<input type="text" name="email2_" value="" class="join_input" style="width:100px;" />
								<select name="select_email_" onchange="email_input(this.form);" id="select_email_" >
									<option selected="" value="">선택해주세요</option>
									<option value="직접입력" >직접입력</option>
									<option value="dreamwiz.com" >dreamwiz.com</option>
									<option value="empal.com" >empal.com</option>
									<option value="empas.com" >empas.com</option>
									<option value="freechal.com" >freechal.com</option>
									<option value="hanafos.com" >hanafos.com</option>
									<option value="hanmail.net" >hanmail.net</option>
									<option value="hotmail.com" >hotmail.com</option>
									<option value="intizen.com" >intizen.com</option>
									<option value="korea.com" >korea.com</option>
									<option value="kornet.net" >kornet.net</option>
									<option value="msn.co.kr" >msn.co.kr</option>
									<option value="nate.com" >nate.com</option>
									<option value="naver.com" >naver.com</option>
									<option value="netian.com" >netian.com</option>
									<option value="orgio.co.kr" >orgio.co.kr</option>
									<option value="paran.com" >paran.com</option>
									<option value="sayclub.com" >sayclub.com</option>
									<option value="yahoo.co.kr" >yahoo.co.kr</option>
									<option value="yahoo.com" >yahoo.com</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>배송메세지</th>
							<td style="text-align:left;">
								<input type="text" name="message" value="" class="join_input" style="width:500px;" />
							</td>
						</tr>
					</tbody>
				</table>
				
				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money">${ total }원</span></td>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;">
								<input type="radio" name="payment" value="card" /> 카드결제&nbsp;&nbsp;&nbsp;
								<input type="radio" name="payment" value="passbook" /> 무통장입금&nbsp;&nbsp;&nbsp;
								<input type="radio" name="payment" value="account" /> 실시간 계좌이체
							</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;">
					<a href="../market/list.do"><img src="../images/market/basket_btn01.gif"/></a>&nbsp;
					<img src="../images/market/basket_btn04.gif" onclick="validateForm(frm);" />
				</p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
