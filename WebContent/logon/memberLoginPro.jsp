<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login pro</title>

</head>
<body>
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.login(id, pwd);
	
	out.print("<script>");
	if(cnt == 1){         // id가 존재하고, 비번도 일치할 때, -> 세션 생성이 중요함
		session.setAttribute("memberId",id);
		out.print("alert(`로그인 되었습니다.`);");
		out.print("location = '../board/boardList.jsp'");
	}else if(cnt ==0){    // id가 있고, 비번이 일치 x
		out.print("alert(`패스워드가 일치하지 않습니다.`);history.back();");
	}else if(cnt ==-1){   // id가 없을 때
		out.print("alert(`아이디가 존재하지 않습니다.`);history.back();");
	}
	out.print("</script>");	
	
	%>
</body>
</html>