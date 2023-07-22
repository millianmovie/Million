<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Email Result</title>
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
	String user_name = request.getParameter("user_name");
	String user_phone = request.getParameter("user_phone");
	java.sql.Date user_birth = java.sql.Date.valueOf(request.getParameter("user_birth"));
	
	UserDAO dao = new UserDAO(request.getServletContext());
	String user_email = dao.userEmailFinder(user_name, user_phone, user_birth);
	%>
</script>
</head>
<body class="fade">
	<form name="userEmailResult" method="post">
		<fieldset>
			<legend>&nbsp;e-Mail 확인&nbsp;</legend>
			<%
			if(user_email != null) {
			%>
			<p><b><%= user_email %></b> 주소로 등록되어 있습니다.</p><br>
			<input type="button" value="로그인" onClick="location.href='./miniMain'">&nbsp;
			<input type="button" value="암호 찾기" onClick="location.href='./UserAccountFind.jsp'">
			<%
			}
			else {
			%>
			<p>등록된 정보가 없거나 일치하지 않습니다.</p><br>
			<input type="button" value="뒤로" onClick="history.back()">&nbsp;
			<input type="button" value="회원가입" onClick="location.href='./userRegister'">
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