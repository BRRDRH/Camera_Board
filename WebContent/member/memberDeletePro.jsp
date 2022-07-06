<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴(삭제)</title>

</head>
<body>
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.deleteMember(id, pwd);
	
	%>
	<script>
	<% if(cnt>0){ %> <%-- 수정 성공 --%>
		alert(`삭제 성공하였습니다.`);
		location ="../logon/memberLoginForm.jsp";
	<%}else{ %>		 <%-- 수정 실패 --%>
		alert(`삭제에 실패하였습니다.`);
		history.back();
	<%} %>
	
	</script>

</body>
</html>