<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Password Update</title>
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

	form {
		position:absolute;
		top:50%;
		left:50%;
		margin:-320px 0 0 -320px;
		width:640px;
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
		padding-left:10px;
		text-align:right;
	}
	
	label {
		font-size:1.25em;
	}
	
	label[for=user_email], input[type=email] {
		display:none;
	}
	
	input[type=email], input[type=password] {
		width:480px;
		height:40px;
		border:1px solid #3E3636;
		border-radius:2.5px;
		background-color:#3E3636;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.75em;
	}
	
	input[type=submit], input[type=button] {
		width:80px;
		height:40px;
		border:1px solid #D72323;
		background-color:#D72323;
		border-radius:2.5px;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.25em;
	}
	
	input[type=submit]:active, input[type=button]:active {
		background-color:#F5EDED;
		color:#D72323;
	}
	
	input:focus {
		outline:none;
	}
	
	span {
		font-size:0.75em;
	}
</style>
<script>
	function formCheck(form) {
		if(form.user_pwd.value.length == 0) {
			alert("암호가 누락되었습니다.");
			return false;
		}
		
		if(form.user_pwd_repeat.value.length == 0) {
			alert("암호 재입력이 필요합니다.");
			return false;
		}
		
		if(form.user_pwd.value != form.user_pwd_repeat.value) {
			alert("암호 확인이 일치하지 않습니다.");
			return false;
		}
		
		var letter = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[`~!@#$%^&*-_=+]).{6,25}$/;
		if(!letter.test(form.user_pwd.value)) {
			alert("암호를 6 ~ 25자 내 영문 대소문자 및 숫자, 특수문자 조합으로 입력하십시오.");
			return false;
		}
		
		if(/(\w)\1\1/.test(form.user_pwd.value)) {
			alert("동일 문자를 연속 2회 이하로 사용하십시오.");
			return false;
		}
		
		if(form.user_pwd.value.search(" ") != -1) {
			alert("암호에 공백이 포함되어 있습니다.");
			return false;
		}
	}
</script>
</head>
<body class="fade">
	<form action="../userPasswordUpdate" method="post" onsubmit="return formCheck(this);">
        <fieldset>
			<legend>&nbsp;암호 변경&nbsp;</legend>
			<table>
				<tr>
					<td><label for="user_email">e-Mail 주소</label></td>
					<td><input type="email" name="user_email" id="user_email" placeholder="N/A" value="${ param.user_email }" readonly></td>
				</tr>
				<tr>
					<td><label for="user_pwd">암호</label></td>
					<td><input type="password" name="user_pwd" id="user_pwd" placeholder="Password" autofocus></td>
				</tr>
				<tr>
					<td></td>
					<td><span>※ 6 ~ 25자 내 영문 대소문자 및 숫자, 특수문자 조합<br>사용 가능 특수문자 : ` ~ ! @ # $ % ^ & * - _ = +</span></td>
				</tr>
				<tr>
					<td><label for="user_pwd_repeat">암호 재확인</label></td>
					<td><input type="password" name="user_pwd_repeat" id="user_pwd_repeat" placeholder="Repeat Password"></td>
				</tr>
				<tr>
				<tr>
                    <td></td>
                    <td><input type="submit" value="확인">&nbsp;
                    <input type="button" onclick="location.href='./UserAccountFinder.jsp'" value="취소"></td>
				</tr>
			</table>
        </fieldset>
        <input type="hidden" value="${ dto.user_email() }" name="user_email">
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