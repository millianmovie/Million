<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Password Result</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	body {
		background-color:#141414;
		opacity: 1;
		transition-duration: 0.5s;
		transition-property: opacity;
    }
    
    body.fade {
		opacity: 0;
    }
    
	fieldset {
		position:absolute;
		top:50%;
		left:50%;
		margin:-300px 0 0 -300px;
		width:600px;
		border:1px solid #F5EDED;
		border-radius:5px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		text-align:center;
	}
	
	legend {
		font-size:2em;
		font-weight:bold;
		text-align:left;
	}
	
	input[type=button] {
		width:120px;
		height:40px;
		border:1px solid #D72323;
		background-color:#D72323;
		border-radius:2.5px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.25em;
		vertical-align:middle;
	}
	
	input[type=button]:active {
		background-color:#F5EDED;
		color:#D72323;
	}
	
	p {
		font-size:1.25em;
		vertical-align:middle;
	}
</style>
<script>
	<%
	request.setCharacterEncoding("UTF-8");
	String user_email = request.getParameter("user_email");
	String user_pwd_hint = request.getParameter("user_pwd_hint");
	String user_pwd_hint_answer = request.getParameter("user_pwd_hint_answer");
	
	UserDAO dao = new UserDAO(request.getServletContext());
	String user_pwd = dao.userPasswordFinder(user_email, user_pwd_hint, user_pwd_hint_answer);
	%>
</script>
</head>
<body class="fade">
	<form name="userEmailResult" method="post">
		<fieldset>
			<legend>&nbsp;암호 확인&nbsp;</legend>
			<%
			if(user_pwd != null) {
			%>
			<p><%= user_email %> 계정의 암호<br>
			<b><c:set var="user_pwd" value="<%= user_pwd %>"/>
			${fn:substring(user_pwd,0,fn:length(user_pwd)-2)}
			<c:forEach begin="1" end="2">
				＊
			</c:forEach></b>
			</p><br>
			<input type="button" value="로그인" onClick="location.href='./miniMain'">&nbsp;
			<input type="button" value="암호 변경" onClick="location.href='./UserPasswordUpdate.jsp?user_email=<%= user_email %>'">
			<%
			}
			else {
			%>
			<p>회원 정보가 존재하지 않거나<br>질문에 대한 대답이 일치하지 않습니다.</p><br>
			<input type="button" value="뒤로" onClick="history.back()">
			<%
			}
			%>
		</fieldset>
	</form>
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			window.setTimeout(() => {
				document.body.classList.remove('fade');
			});
		});
	</script>
</body>
</html>