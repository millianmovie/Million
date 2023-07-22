<%@page import="dao.BoardDao"%>
<%@page import="common.JSFunction"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
/* #title, #content{ */
/* 	border: none; */
/* } */
#title:focus,
#content:focus{
/* 	outline: none; */
/* 	border: none; */
	box-shadow: none;
}

</style>
</head>
<body>
	<%@ include file="../User/Nav.jsp" %>
<div class="container">
	<div class="write-info">
	<h2>유저 게시판 - 상세보기</h2>
	</div>
<!-- <form name = "writeForm"> -->
<form action="./edit" method="post" onsubmit="return formCheck(this)">
	<input type="hidden" name="num" value="${post.num }"/>

		<div class="title-area">
			<div class="title-input">
			<input id="title" class="form-control form-title-input" type="text" name="title" value="${post.title }">
			</div>
			<div>
				<select class="form-select" aria-label="Default select example" name="secret">
	  				<option value="null" >전체공개</option>
	  				<option value="secret">비밀글</option>
				</select>
	  		</div>
	  	</div>
		<div class="content-area">
		<textarea id="content" class="form-control form-content" type="text" name="content">${post.content }</textarea>
		</div>
		<div class="btns">
		<%-- 		<c:if test="${not (empty sessionScope.UserId) && sessionScope.UserId == post.user_email}"> --%>
		<c:if test="${ sessionScope.user_email != null && sessionScope.user_email == 'admin@naver.com'}">
			<button type="button" class="btn btn-light"
				onclick="deletePost()">삭제하기</button>
		</c:if>
		<c:if test="${sessionScope.user_email eq post.user_email}">
			<button type="submit" class="btn btn-light editBtn">수정완료</button>
			<button type="button" class="btn btn-light"
				onclick="deletePost()">삭제하기</button>
		</c:if>
		<button type="button" class="btn btn-light"
			onclick="location.href='./list?page=${empty param.page ? '1' : param.page}&pageSize=${param.pageSize}'">
				목록보기
		</button>
		</div>
</form>
</div>
<%@ include file="../User/Footer.jsp" %>
<script>
// let title = document.querySelector("#title");
// let content = document.querySelector("#content");
let editBtn = document.querySelector(".editBtn");
function editPost(){
	document.getElementById("title").style.border = "1px solid #000000";
	document.getElementById("content").style.border = "1px solid #000000";
	document.getElementById("title").readOnly=false; 
	document.getElementById("content").readOnly=false; 
	editBtn.innerText='수정완료';
	editBtn.setAttribute('type', 'button');
	editBtn.addEventListener('click', function(){
		editBtn.setAttribute('type', 'submit');
	})
}
function deletePost() {
	var confirmed = confirm("정말로 삭제하겠습니까?");
	if(confirmed) {
		var form = document.writeForm;
		form.method="post";
		form.action="./delete";
		form.submit();
	}
}

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
</body>
</html>




