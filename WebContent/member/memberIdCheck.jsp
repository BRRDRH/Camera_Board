<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member ID Check</title>
</head>
<body>
<%-- ID 중복 체크 처리 페이지 --%>
	<% 
	
	String id = request.getParameter("id"); 
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.checkID(id);
	
	%>
	<script>
	<% if(cnt >0 ) {%>  <%-- 사용할 수 있는 아이디인 것 --%>
		alert(`사용 가능한 아이디입니다.`);
	<%}else{ %>          <%-- 사용할 수 없는 아이디인 것 --%>
		alert(`이미 존재하는 아이디입니다.\n다른 아이디를 입력하여 주세요.`);
	<%} %>
	history.back();
	</script>
</body>
</html>