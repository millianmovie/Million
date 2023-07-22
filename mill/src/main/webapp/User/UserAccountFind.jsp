<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Account Finder</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	body {
		background-color:#191A1D;
		opacity: 1;
		transition-duration: 0.5s;
		transition-property: opacity;
    }
    
    body.fade {
		opacity: 0;
    }
    
    section {
    	position:relative;
    	margin-top: 140px;
    }
    
	form {
		margin-left:auto;
		margin-right:auto;
		width:720px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	fieldset {
		border:1px solid #F5EDED;
		border-radius:5px;
	}
	
	legend {
		font-size:2em;
		font-weight:bold;
	}
	
	table {
		margin-left:auto;
		margin-right:auto;
	}
	
	table tr td:nth-of-type(2) {
		padding-left:25px;
		text-align:right;
	}
	
	label {
		font-size:1.25em;
	}
	
	input[type=email], input[type=tel], input[type=text], select {
		width:480px;
		height:40px;
		border:1px solid #3E3636;
		border-radius:2.5px;
		background-color:#3E3636;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.5em;
	}
	select, select option {
		width: 486px;
		cursor: pointer;
	}
	
	input[type=date] {
		height:40px;
		border:1px solid #3E3636;
		border-radius:2.5px;
		background-color:#3E3636;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.5em;
	}
	
	input[type=submit], input[type=button] {
		width:100px;
		height:40px;
		border:1px solid #D72323;
		background-color:#D72323;
		border-radius:2.5px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.25em;
		cursor: pointer;
	}
	
	input[type=submit]:active, input[type=button]:active {
		background-color:#F5EDED;
		color:#D72323;
	}
	
	input:focus {
		outline:none;
	}
	
	#back {
		margin-top:25px;
		text-align:right;
	}
	
	#back fieldset {
		padding-top:10px;
		padding-right:50px;
	}
	.cancle {
		float: right;
    	margin-top: 30px;
    	cursor: pointer;
	}
</style>
<script>
	function formCheckEmail(form) {
		if(form.user_name.value == 0) {
			alert("이름이 누락되었습니다.");
			return false;
		}
		
		if(form.user_phone.value == 0) {
			alert("연락처가 누락되었습니다.");
			return false;
		}
		
		if(form.user_birth.value == 0) {
			alert("생년월일이 누락되었습니다.");
			return false;
		}
	}
	
	function formCheckPassword(form) {
		if(form.user_email.value == 0) {
			alert("메일 주소가 누락되었습니다.");
			return false;
		}
		
		if(form.user_pwd_hint_answer.value == 0) {
			alert("암호 질문에 대한 대답이 누락되었습니다.");
			return false;
		}
	}
</script>
</head>
<body class="fade">
	<section>
		<form id="userEmailFinder" name="userEmailFinder" action="./UserEmailResult.jsp" method="post" onsubmit="return formCheckEmail(this)">
			<fieldset>
				<legend>&nbsp;계정 찾기&nbsp;</legend>
				<table>
					<tr>
						<td><label for="user_name">이름</label></td>
						<td><input type="text" name="user_name" id="user_name" placeholder="Your Name" autocomplete="off"></td>
					</tr>
					<tr>
						<td><label for="user_phone">연락처</label></td>
						<td><input type="tel" name="user_phone" id="user_phone" placeholder="Contact" autocomplete="off"></td>
					</tr>
					<tr>
						<td><label for="user_birth">생년월일</label></td>
						<td><input type="date" name="user_birth" id="user_birth"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="확인" onClick="userEmailResult()"></td>
					</tr>
				</table>
			</fieldset>
		</form>
		<form id="userPasswordFinder" name="userPasswordFinder" action="./UserPasswordResult.jsp" method="post" onsubmit="return formCheckPassword(this)">
			<fieldset>
				<legend>&nbsp;암호 찾기&nbsp;</legend>
				<table>
					<tr>
						<td><label for="user_email">e-Mail 주소</label></td>
						<td><input type="email" name="user_email" id="user_email" placeholder="e-Mail Address" autocomplete="off"></td>
					</tr>
					<tr>
						<td>암호 질문</td>
						<td>
							<select name="user_pwd_hint" id="user_pwd_hint">
								<option style="text-align: center;">---------------질문을 선택하세요---------------</option>
								<option value="question1">첫 번째 애완 동물의 이름은 무엇이었습니까?</option>
							    <option value="question2">태어난 도시의 이름은 무엇입니까?</option>
							    <option value="question3">어린 시절 별명은 무엇입니까?</option>
							    <option value="question4">부모님이 만난 도시의 이름은 무엇입니까?</option>
							    <option value="question5">가장 나이 많은 사촌의 이름은 무엇입니까?</option>
							    <option value="question6">처음 입학한 학교의 이름은 무엇입니까?</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>질문 대답</td>
						<td><input type="text" name="user_pwd_hint_answer" id="user_pwd_hint_answer" placeholder="Password Hint Answer" autocomplete="off"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="확인" onClick="userPasswordResult()"></td>
					</tr>
				</table>
			</fieldset>
			<input type="button" class="cancle" value="취소" onClick="location.href='../miniMain'">
		</form>
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