<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Nanum+Brush+Script&family=Paytone+One&display=swap');
#container{width:500px; margin:50px auto; }
a{text-decoration:none; color:black;}
/* 상단 메인, 서브 타이틀  */
.m_title{font-family: 'Paytone One', sans-serif; font-size:3em;text-align:center;}
.s_title{font-family: 'Do Hyeon', sans-serif;font-size:2.3em;text-align:center;margin-bottom:20px;}
/* 본문 - 본인 인증  */

.c_login {border:1px solid black; padding:20px; }
.c_login div{margin:20px 0; text-align:center;}
.c_login .c_writer input{background:#dee2e6;}
.c_login label{display:inline-block;  width:75px; text-align:right; margin-right:30px; 
font-size:1em; font-weight:bold}
.c_login input{width:280px; height:40px;}

/* 하단 버튼  */
.btns{text-align:center; margin-top:30px;}
.btns input{width:100px;height:35px;background:black; border:none; color:white;font-weight:bold;
cursor:pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded",function(){
		let form = document.deleteForm;
		
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click",function(){
			if(!form.pwd.value){
				alert(`비밀번호를 입력하시오!`);
				form.pwd.focus();
				return;
			}
			let answer = confirm(`글을 삭제하시겠습니까?`);
			
			if(answer){
				form.submit();	
			}else{
				return;
			}
		})
		let pageNum = form.pageNum.value;
		let btn_boardList = document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function(){
			location = 'boardList.jsp?pageNum=' + pageNum;
		})
		
	})


</script>
</head>
<body>
<%
String memberId = (String) session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location = '../logon/memberLoginForm.jsp'</script>");
}

String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));

%>
<div id="container">
	<div class="m_title"><a href="#">EZEN MALL</a></div>
	<div class="s_title">글 삭제</div>
	
	<form action="boardDeletePro.jsp" method="post" name="deleteForm">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="num" value="<%=num%>">
		<div class="c_login">
			<div class="c_writer">
				<label>작성자</label>
				<input type="text" name="writer" id="writer" value="<%=memberId %>" readonly>
			</div>
			<div class="c_pwd">
				<label>비밀번호</label><input type="password" name="pwd" id="pwd">
			</div>
		</div>
		<div class="btns">
			<input type="button" value="글 삭제" id="btn_delete">&emsp;&emsp;
			<input type="button" value="게시글 보기" id="btn_boardList">
		</div>
	</form>
</div>
</body>
</html>