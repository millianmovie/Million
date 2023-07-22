<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../User/Nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<style type="text/css">
html, body{
	margin: 0;
	padding: 0;
	width: 100%;
	min-height: 100vh;
}
body{
	display: flex;
	flex-direction: column;
	background-color: #191A1D;
}
.container{
	display: flex;
	flex-direction: column;
	position: relative;
	padding-top: 50px;
	max-width: 950px;
	height: 100%;
}
textarea{
	width: 100%;
	height: 300px;
	resize: none;
}
.write-info{
	display: flex;
	justify-content: space-between;
}
.title-area{
	display: flex;
 	justify-content: space-between;  
 	flex-basis: 100%; 
}
h2{
 	padding: 15px 0;
 	color: #eee;
}
.content-area{
 	padding: 20px 0; 
} 
.form-title-input{
 	width: 100%;
	height: 100%;
}
.btns{
	position: absolute;
	right: 10px;
}
.title-input{
	width: 85%
}
</style>
</head>
<body>
<script>
	function formCheck(form) {
		if(form.title.value.trim() == ""){
			//trim으로 공백제거 후 체크가능
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(form.content.value.trim() == ""){
			alert("내용을 입력하세요");
			form.content.focus();
			return false;
		} 
		
		return true;
	}
</script>

<div class="container">
	<div class="write-info">
	<h2>문의하기</h2>
	</div>	
	<form action="./write" method="post" onsubmit="return formCheck(this)">
		<div class="title-area">
			<div class="title-input">
			<input id="title" class="form-control form-title-input" type="text" name="title" placeholder="제목">
			</div>
			<div>
				<select class="form-select" aria-label="Default select example" name="secret">
	  				<option value="null" selected>전체공개</option>
	  				<option value="secret">비밀글</option>
				</select>
	  		</div>
	  	</div>
		<div class="content-area">
		<textarea id="content" class="form-control form-content" type="text" name="content" placeholder="문의사항을 입력해주세요"></textarea>
		</div>
		<div class="btns">
			<button type="submit" class="btn btn-light">작성완료</button>
			<button type="reset" class="btn btn-light" onclick="location.href='./list'">목록보기</button>
		</div>
	</form>

</div>
<%@ include file="../User/Footer.jsp" %>
</body>

</html>