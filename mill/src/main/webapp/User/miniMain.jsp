<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mini Main</title>
    <link rel="stylesheet" href="./css/miniMain.css?ver0.7" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	function formCheck(form) {
		if(form.user_email.value.length == 0) {
			alert("메일 주소가 누락되었습니다.");
			return false;
		}
		else if(form.user_pwd.value.length == 0) {
			alert("암호가 누락되었습니다.");
			return false;
		}
	}

</script>
</head>
<body>
<div id="main_logo">
<img src="./etc/mainLogo.png">
</div>
	<section>
		<form action="./miniMain" method="post" onsubmit="return formCheck(this);">
	        <fieldset>
	            <legend>&nbsp;Million Movie&nbsp;</legend>
	            <table>
	                <tr>
	                    <td class="labeltag"><label for="user_email">e-Mail 주소</label></td>
	                    <td><input type="email" name="user_email" id="user_email" placeholder="abc@naver.com" autofocus autocomplete="off"></td>
	                </tr>
		            <tr>
		                <td class="hiddentag labeltag"><label for="user_pwd" >암호</label></td>
		                <td class="hiddentag"><input type="password" name="user_pwd" id="user_pwd" placeholder="Password"></td>
		            </tr>
		            <tr>
		                <td style="text-align: right"></td>
		            </tr>
	            </table>
	            <div class="bttn">
	            	<input type="button" id="idcheck" class="check" value="확인">
	            	<input type="button" class="hiddentag cancel" onclick="location.href='./miniMain'" value="취소">
	            	<input type="button" id="forgetEmail" onclick="location.href='./User/UserAccountFind.jsp'" value="이메일 찾기">
	            </div>
	        </fieldset>
	    </form>
	</section>

    <script>
		
		let idcheck = document.getElementById('user_email')
		idcheck.addEventListener("keypress", function(e){
			//se.preventDefault();
			if(e.keyCode === 13){
				$("#idcheck").click();
			}
		});
		
		let user_pwd = document.getElementById('user_pwd')
		user_pwd.addEventListener("keypress", function(e){
			//e.preventDefault();
			if(e.keyCode === 13){
				$("#idcheck").click();
			}
		});
		
		$("#idcheck").click(function(){
			let id =$("input[name=user_email]").val();
			
			
			$.ajax({
			      type:'GET',       // 요청 메서드
			      url: './checkEmail.do?id='+id,  // 요청 URI
			      success : function(result){
					let res = JSON.parse(result);
					console.log(res.ch)
					if(res.ch=="true"){
						$(".hiddentag").css("display", "table-cell");
						var submit = document.getElementById("idcheck");
						submit.type= "submit";
					}
					else{
						window.location.href="./userRegister";
			    	}
			      },
			    error: function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()
		});
	</script>
</body>
</html>