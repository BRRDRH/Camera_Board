<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Nanum+Brush+Script&family=Paytone+One&display=swap');
#container{width:600px; margin:50px auto;}
a{text-decoration:none; color:black;}
input[type="text"],[type="password"]{height:20px;}

/* 상단 - 메인, 서브 타이틀  */

.m_title{font-family: 'Paytone One', sans-serif; font-size:3em;text-align:center;}
.s_title{font-family: 'Do Hyeon', sans-serif;font-size:2.3em;text-align:center;margin-bottom:30px;}

/* 중단 - 입력 테이블   */

table{width:100%; border:1px solid black; border-collapse:collapse; }
tr{height:70px;}
td,th{border:1px solid black;}
td{padding-left:10px;}
th{background:#ced4da;}
.addr_row{height:100px;}
.addr_row input{margin:2px 0;}
#btn_chk_id{width:110px; height:28px; border:none; background:#646569; color:white; font-size:12px;
cursor:pointer; border-radius:8px; margin-left:10px;}
#btn_address{width:110px; height:28px; border:none; background:#646569; color:white; font-size:12px;
cursor:pointer; border-radius:8px; }
span{font-size:11px;}

/* 하단 - 가입, 취소 버튼*/

.btns{text-align:center;margin-top:30px;}
.btns input[type="button"]{width:120px; height:40px;background:black; color:white;border:none;
font-size:1em; font-weight:bold; cursor:pointer;}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<script>

document.addEventListener("DOMContentLoaded",function(){
	let form = document.joinForm;
	let id = form.id;
	let pwd = form.pwd;
	let pwd2 = form.pwd2;
	let name = form.name;
	let email = form.email;
	let tel = form.tel;
	let address = form.address;
	let address2 = form.address2;
	
	
	
	// ID 중복 체크 버튼 - DB 작업 : member 테이블에 똑같은 id가 있는 지를 검사
	let btn_chk_id = document.getElementById("btn_chk_id");
	btn_chk_id.addEventListener("click",function(){
		
		if(id.value.length< 4){ // ID를 4글자 이상 입력했을 때
			alert(`아이디를 4글자 이상 입력해 주세요!`);
			id.focus();
		}else{
			location = 'memberIdCheck.jsp?id=' + id.value;
		}
	})

	
	//비밀번호 유효성 검사 - 8글자 이상 입력하도록
	pwd.addEventListener("keyup", function(){
		let chk_pwd = document.getElementById("chk_pwd");
		if(pwd.value.length <4){
			chk_pwd.innerHTML = "비밀 번호는 4글자 이상이어야 합니다.";
			chk_pwd.style.color= "red";
		}else{
			chk_pwd.innerHTML = "사용 가능한 비밀번호입니다.";
			chk_pwd.style.color= "blue";
		}
	})
	// 비밀번호 확인 - pwd2
	// 비밀번호와 비밀번호 확인과 내용이 같은 지 판다.
	pwd2.addEventListener("keyup", function(){
		let chk_pwd2 = document.getElementById("chk_pwd2");
		if(pwd.value==pwd2.value){
			chk_pwd2.innerHTML="비밀번호가 일치합니다."
			chk_pwd2.style.color="blue";
		}else{
			chk_pwd2.innerHTML="비밀번호가 다릅니다.";
			chk_pwd2.style.color="red";
		}
	})

	//이메일 검사 함수
	let isEmail = function(value){
		return (value.indexOf('@') > 2)&& (value.split('@')[1].indexOf('.')>2)
	}

	
	// 이메일 확인
	// 1. '@'문자를 포함하고 있는지의 여부 -> 아이디가 세글자 이상인지 판별
	// 2. '@'문자 다음에 ','을 포함하고 있는지의 여부 -> 회사이름도 3글자 이상인지를 판별한다.
	let chk_email = document.getElementById("chk_email");
	email.addEventListener("keyup",function(event){
		let value = event.currentTarget.value;
		if(isEmail(value)){    //이메일 형식이 맞을 때
			chk_email.innerHTML = "이메일 형식이 맞습니다. : " + value;
			chk_email.style.color="blue";
		}else{   // 이메일 형식이 아닐 때
			chk_email.innerHTML = "이메일 형식이 아닙니다. : "+ value;
			chk_email.style.color="red";
		} 
	})
	
	// 주소 찾기 버튼  - 다음 라이브러리 활용
	let btn_address = document.getElementById("btn_address");
	// daum의 라이브러리를 활용한 주소 찾기 문법
	btn_address.addEventListener("click",function(){
		new daum.Postcode({
			oncomplete:function(data) {
				address.value = data.address;
				
			}
		}).open();
	})
	
	// 취소 버튼
	let btn_cancel = document.getElementById("btn_cancel");
	btn_cancel.addEventListener("click", function(){
		location="../logon/memberLoginForm.jsp";
	})
	
	
	
	// 회원가입 페이지의 전체 내용 입력 유무에 따른 유효성 검사와 페이지 이동 처리
	let btn_insert = document.getElementById("btn_insert");
	btn_insert.addEventListener("click",function(){
		if(id.value.length == 0){
			alert(`아이디를 입력하고, 아이디 중복 체크를 하시오.`);
			id.focus();
			return;
		}
		if(pwd.value.length == 0){
			alert(`비밀번호를 입력하시오!`);
			pwd.focus();
			return;
		}
		if(pwd2.value.length == 0){
			alert(`비밀번호 확인을 하시오!`);
			pwd2.focus();
			return;
		}
		if(pwd.value != pwd2.value){
			alert(`비밀번호와 비밀번호 확인이 다릅니다.`);
			pwd2.focus();
			return;
		}
		if(name.value.length == 0){
			alert(`이름을 입력하시오`);
			name.focus();
			return;
		}
		if(email.value.length == 0){
			alert(`이메일을 입력하시오!`);
			email.focus();
			return;
		}
		if(tel.value.length == 0){
			alert(`전화번호를 입력하시오!`);
			tel.focus();
			return;
		}
		if(address.value.length == 0){
			alert(`주소 찾기 버튼을 클릭하여 도로명 주소를 선택하시오!`);
			address.focus();
			return;
		}
		if(address2.value.length == 0){
			alert(`상세주소를 입력하시오!`);
			address2.focus();
			return;
		}
		form.submit();
	})
	
	
		
})

</script>
</head>
<body>
<div id="container">
	<div class="m_title"><a href="#">카메라 게시판</a></div>
	<div class="s_title">회원 가입</div>
	
	<form action="memberJoinPro.jsp" method="post" name="joinForm">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" size="15">
					<input type="button" value="ID 중복 체크" id="btn_chk_id" class="btn_chk"><br>
					<span id="chk_id"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="password" name="pwd" size="15"><br>
					<span id="chk_pwd"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="pwd2" size="15"><br>
					<span id="chk_pwd2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" size="15"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" size="30"><br>
					<span id="chk_email"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" size="20"></td>
			</tr>
			<tr class="addr_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btn_address"><br>
					<input type="text" name="address" size="50"><br>
					<input type="text" name="address2" size="50">
				</td>
			</tr>		
		</table>
		<div class="btns">
			<input type="button" value="회원가입" id="btn_insert" name="btn">&emsp;&emsp;&emsp;&emsp;
			<input type="button" value="이전" id="btn_cancel">
		</div>
	</form>
</div>
</body>
</html>