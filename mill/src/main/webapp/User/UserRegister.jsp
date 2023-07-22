<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Register</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
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
    
	form {
		position:absolute;
		top:50%;
		left:50%;
		margin:-360px 0 0 -360px;
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
	
	input[type=email], input[type=password], input[type=tel], input[type=text], select {
		width:480px;
		height:40px;
		border:1px solid #3E3636;
		border-radius:2.5px;
		background-color:#3E3636;
		color:#F5EDED;
		font-family: 'Noto Sans KR', sans-serif;
		font-size:1.5em;
	}
	select {
		cursor: pointer;
		width: 486px;
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
	
	span {
		font-size:0.75em;
	}
	
	.user_gender_label, .user_tos_label {
		font-size:1.5em;
	}
	
	a {
		color:#F5EDED;
		font-size:1.25em;
		text-decoration:none;
		transition: 0.5s;
	}
	
	a:hover {
		color:#D72323;
		text-decoration:underline;
	}
	span {
		font-size: 1rem;
		margin-right: 10px;
	}
	.bttn {
		text-align: right;
	}
	.btn {
		margin: 10px 1.7px;
	}
</style>

</head>
<body class="fade">
	<form id="userRegister" name="userRegister" action="./userRegister" method="post" onsubmit="return formCheck(this)">
        <fieldset>
            <legend>&nbsp;회원가입&nbsp;</legend>
            <table>
                <tr>
                    <td><label for="user_email">e-Mail</label></td>
                    <td><input type="email" name="user_email" id="user_email" placeholder="중복 확인 버튼을 누르시오."  value="${ param.user_email }" autocomplete="off"></td>
                </tr>
                <tr>
                    <td ></td>
                    <td>
                    	<span id="id_con1"></span>
                    	<input type="button" id="idcheck" value="중복 확인">
                    </td>
                <tr>
                    <td><label for="user_pwd">암호</label></td>
                    <td><input type="password" name="user_pwd" id="user_pwd" placeholder="Password" autocomplete="off"></td>
                </tr>
                <tr>
					<td></td>
					<td><span>※ 6 ~ 25자 내 영문 대소문자 및 숫자, 특수문자 조합<br>사용 가능 특수문자 : ` ~ ! @ # $ % ^ & * - _ = +</span></td>
                </tr>
                <tr>
                    <td><label for="user_pwd_repeat">암호 재확인</label></td>
                    <td><input type="password" name="user_pwd_repeat" id="user_pwd_repeat" placeholder="Repeat Password" autocomplete="off"></td>
                </tr>
                <tr>
                    <td><label for="user_name">성명</label></td>
                    <td><input type="text" name="user_name" id="user_name" placeholder="Your Name" autocomplete="off"></td>
                </tr>
                <tr>
                    <td><label for="user_birth">생년월일</label></td>
                    <td><input type="date" name="user_birth" id="user_birth"></td>
                </tr>
                <tr>
                    <td><label for="user_gender">성별</label></td>
                    <td><input type="radio" name="user_gender" id="user_gender_man" value="Man" checked><label for="user_gender_man" class="user_gender_label">&nbsp;남&nbsp;</label><input type="radio" name="user_gender" id="user_gender_woman" value="Woman"><label for="user_gender_woman" class="user_gender_label">&nbsp;여&nbsp;</label><input type="radio" name="user_gender" id="user_gender_secret" value="Private"><label for="user_gender_secret" class="user_gender_label">&nbsp;비공개&nbsp;</label></td>
                </tr>
                <tr>
                    <td><label for="user_phone">연락처</label></td>
                    <td><input type="tel" name="user_phone" id="user_phone" placeholder="Contact" autocomplete="off"></td>
                </tr>
                <tr>
                    <td><label for="user_pwd_hint">암호분실 힌트 질문</label></td>
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
                    <td><label for="user_pwd_hint_answer">암호분실 힌트 대답</label></td>
                    <td><input type="text" name="user_pwd_hint_answer" id="user_pwd_hint_answer" placeholder="Password Hint Answer" autocomplete="off"></td>
                </tr>
                <tr>
                    <td><label for="user_tos">이벤트 수신동의</label></td>
                    <td><input type="radio" name="user_tos" id="user_tos_ok" value="OK" checked><label for="user_tos_ok" class="user_tos_label">&nbsp;OK&nbsp;</label><input type="radio" name="user_tos" id="user_tos_ng" value="NG"><label for="user_tos_ng" class="user_tos_label">&nbsp;NG&nbsp;</label></td>
                </tr>
                <tr>
                    <td colspan="2" class="bttn">
                    	<input class="btn" type="submit" value="가입">
                    	<input class="btn" type="button" onclick="location.href='./miniMain'" value="취소">
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
	<script>
	$("#idcheck").click(function(){
		let id =$("input[name=user_email]").val();
		
	$.ajax({
	      type:'GET',       // 요청 메서드
	      url: './checkEmail.do?id='+id,  // 요청 URI
	      success : function(result){
			let res = JSON.parse(result);
			console.log(res.ch)
			if(res.ch=="true"){
				$("#id_con1").text("아이디가 중복되었습니다.");
				$("#id_con1").css("color", "#D72323");
			}
			else{
				$("#id_con1").text("사용가능한 아이디입니다.");
				$("#id_con1").css("color", "#D72323");
				$("#id_con1").css("width", "180");
				id = $("#id").val();
				$("#idcheck").attr("disabled","disabled") // 버튼 비활성화
				console.log(id)
				$("#input-submit").attr("data-id", id)
			}
	    },
	    error: function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
	  }); // $.ajax()
	});
	function formCheck(form) {
		if(form.user_email.value.length == 0) {
			alert("메일 주소가 누락되었습니다.");
			console.log("이메일 누락");
			return false;
		}
		
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
		
		if(form.user_name.value.length == 0) {
			alert("이름이 누락되었습니다.");
			return false;
		}
		
		if(form.user_birth.value.length == 0) {
			alert("생년월일이 누락되었습니다.");
			return false;
		}
		
		if(form.user_phone.value.length == 0) {
			alert("연락처가 누락되었습니다.");
			return false;
		}
		
		if(form.user_pwd_hint_answer.value.length == 0) {
			alert("암호분실 힌트 대답이 누락되었습니다.");
			return false;
		}
	}
	
	function checkEmail(){
		window.open("./User/CheckEmail.jsp?user_email=${ param.user_email }", "_blank", "width=640px, height=280px, scrollbars=no, resizable=no");
	}

	document.addEventListener('DOMContentLoaded', () => {
		window.setTimeout(() => {
			document.body.classList.remove('fade');
		});
	});
</script>
</body>
</html>