<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
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
    
    section{
    display: flex;
    justify-content: center;
    margin-top: 3rem;
    }
    
	fieldset {
		width:640px;
		border:1px solid #F5EDED;
		border-radius:5px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	legend {
		color:#F5EDED;
		font-size:2em;
		font-weight:bold;
	}
	
	table {
		margin-left:auto;
		margin-right:auto;
	}
	
	table tr td:nth-of-type(1) {
		height:40px;
		padding:0 5px 0 5px;
		border-radius:2.5px;
		background-color:#3E3636;
		color:#F5EDED;
		font-size:1.25em;
		text-align:center;
	}
	
	table tr:nth-of-type(8) td:nth-of-type(1) {
		padding:0;
		background-color:transparent;
		font-size:1em;
		text-align:left;
	}
	
	table tr td:nth-of-type(2) {
		border-bottom:1px dashed #F5EDED;
		width:480px;
		height:40px;
		padding-left:25px;
		font-size:1.5em;
		text-align:right;
	}
	
	table tr:nth-of-type(8) td:nth-of-type(2) {
		border-bottom:none;
		font-size:1em;
		padding-top:1rem;
		padding-bottom: 1rem;
	}
	
	label {
		font-size:0.75em;
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
	}
	
	input[type=button]:active {
		background-color:#F5EDED;
		color:#D72323;
	}
</style>
<script>

	
	function deleteUser(){
		if(confirm("회원 탈퇴를 하시겠습니까?")){
			location.replace('/mill/userDelete?user_email=${user.user_email}');
		}
		else {
			return false;
		}
	}
</script>
</head>
<body class="fade">
	<section>
	<fieldset>
		<legend>&nbsp;회원 정보&nbsp;</legend>
		<table align="center">
		    <tr>
		        <td>e-Mail</td>
		        <td>${user.user_email }</td>
			</tr>
			<tr>
			    <td>성명</td>
			    <td>${user.user_name}</td>
			</t]r>
			<tr>
			    <td>생년월일</td>
			    <td>${user.user_birth}</td>
			</tr>
			<tr>
			    <td>성별</td>
			    <td>${user.user_gender}</td>
			</tr>
			<tr>
			    <td>연락처</td>
			    <td>${user.user_phone}</td>
			</tr>
			<tr>
			    <td>이벤트 수신</td>
			    <td>${user.user_tos}</td>
			</tr>
			<tr>
			</tr>
			<tr>
			    <td><!-- <input type="button" onclick="location.href='./Main.jsp'" value="처음으로"> --></td>
			    <td><input type="button" onclick="location.href='/mill/userUpdate'" value="정보수정">&nbsp;
			    <input type="button" onclick="deleteUser();" value="회원탈퇴"></td>
			</tr>
		</table>
	</fieldset>
	</section>
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			window.setTimeout(() => {
				document.body.classList.remove('fade');
			});
		});
	</script>
</body>
</html>