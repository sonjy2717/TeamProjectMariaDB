<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 체험학습 신청 -->


<head>
<!-- 체험 희망날짜 datepicker적용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
$( function() {
  $( "#datepicker" ).datepicker();
  $( "#datepicker" ).datepicker("option", "dateFormat", "yy-mm-dd");
} );
</script>
<!-- 폼 내용 검증 -->
<script type="text/javascript">
function validateForm(form) {
	if (form.name.value == "") {
		alert("이름을 입력하세요.");
		form.name.focus();
		return false;
	}
	if (form.phone_num1.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num1.focus();
		return false;
	}
	if (form.phone_num2.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num2.focus();
		return false;
	}
	if (form.phone_num3.value == "") {
		alert("연락처를 입력하세요.");
		form.phone_num3.focus();
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
	if (form.ft_cake.value=="" && form.ft_cookie.value=="") {
		alert("케익/쿠키 체험학습의 인원수를 입력해주세요.");
		form.ft_cake.focus();
		return false;
	}
	if (form.ft_date.value == "") {
		alert("체험 희망날짜를 선택하세요.");
		form.ft_date.focus();
		return false;
	}
	if (isNaN(form.ft_cake.value)) {
		alert("케이크를 만들 인원의 숫자만 입력하세요.");
		form.ft_cake.focus();
		return false;
	}
	if (isNaN(form.ft_cookie.value)) {
		alert("쿠키를 만들 인원의 숫자만 입력하세요.");
		form.ft_cookie.focus();
		return false;
	}
}
</script>
</head>
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
					<img src="../images/market/sub05_title.gif" alt="체험학습신청" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;체험학습신청<p>
				</div>
				<p class="con_tit"><img src="../images/market/sub05_tit01.gif" /></p>
				<ul class="dot_list">
					<li>무 방부제 • 무첨가제 수제 빵 제작 체험</li>
					<li>사전에 준비된 반죽으로 성형 및 굽기 체험</li>
					<li>참가비 : 일인당 20,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit02.gif" /></p>
				<ul class="dot_list">
					<li>내가만든 맛있는 쿠키~!</li>
					<li>쿠키의 반죽 ,성형, 굽기 기술 경험의 기회! </li>
					<li>참가비 : 일인당 15,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit03.gif" /></p>
				<ul class="dot_list">
					<li>만드는 즐거움 받는이에겐 감동을~!</li>
					<li>직접 데코레이션한 세상에서 하나뿐인
케익을 소중한 사람에게 전하세요~!
</li>
					<li>준비된 케익시트에 테코레이션 과정 체험</li>
					<li>참가비 : 일인당 25,000원 (교육비, 재료비 포함)</li>
				</ul>
				<div style="text-align:left">
					<img src="../images/market/sub05_img01.jpg" style="margin-bottom:30px;" />
				</div>
				<form name="bcFrm" method="post" action="FTProcess.jsp"
					onsubmit="return validateForm(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;">
								<input type="text" name="phone_num1"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone_num2"  value="" class="join_input" style="width:50px;" /> - 
								<input type="text" name="phone_num3"  value="" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;">
								<input type="text" name="email1"  value="" class="join_input" style="width:100px;" /> @
								<input type="text" name="email2"  value="" class="join_input" style="width:100px;" />
							</td>
						</tr>
						<tr>
							<th>체험내용</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="">케익체험</td>
										<td style="border-right:0px;">
										<input type="text" name="ft_cake" value="" class="join_input" style="width: 50px; text-align: right;" placeholder="0" /> 명</td>
									</tr>
									<tr>
										<td style="border-bottom:0px; width: 70px;">쿠키체험</td>
										<td style="border:0px;"><input type="text" name="ft_cookie" value="" class="join_input" style="width: 50px; text-align: right;" placeholder="0" /> 명</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>체험희망날짜</th>
							<td style="text-align:left;"><input type="text" name="ft_date"  value="" class="join_input" id="datepicker" /></td>
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;"><input type="radio" name="regi_type"  value="예약신청" checked /> 예약신청
							&nbsp;&nbsp;&nbsp;<input type="radio" name="regi_type"  value="견적문의" /> 견적문의</td>
						</tr>
						<tr>
							<th>기타특이사항</th>
							<td style="text-align:left;"><input type="text" name="note"  value="" class="join_input" style="width:400px;" placeholder="없음" /></td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:center; margin-bottom:40px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="../main/main.jsp"><img src="../images/btn02.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
