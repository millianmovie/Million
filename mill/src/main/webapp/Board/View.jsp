
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
<style>
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

body, html{
	height: 100%;
	padding:0;
	margin:0;
	text-align:center;
	font-family:'NanumSquareNeo-Variable';
}
table {
  width:80%;
  border: 4px solid #444444;
  border-collapse: collapse;
  margin:0 auto;
}
th{
	background:#408E91;
	color:white;
}
th, td {
	padding:10px;
  border: 1px solid #444444;
  width: 100px;
}
td.content{
  vertical-align: top;
  text-align: left;
 	height: 300px;
}
.button {
  width: 120px;
  padding: 0;
  margin: 10px 20px 10px 0;
  font-weight: 600;
  text-align: center;
  line-height: 30px;
  color: #FFF;
  background-color: #00AE68;
  border-radius: 5px;
  transition: all 0.2s ;
}

.btnFade.btnBlueGreen:hover {
  background: #21825B;
}
 
</style>
</head>
<body>


<h2>유저 게시판 - 상세보기</h2>
<form name = "writeForm">
	<input type="hidden" name="num" value="${post.num }"/>
	<table border="1" width="90%">
		<tr>
			<td>번호</td>
			<td>${post.num }</td>
			<td>작성자</td>
			<td>${post.user_email }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${post.post_date }</td>
			<td>조회수</td>
			<td>${post.view_cnt }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${post.title }</td>
		</tr>
		<tr class="content">
			<td>내용</td>
			<td colspan="3" class="content">${post.content }</td>
		</tr>
		<tr>
<%-- 		<c:if test="${not (empty sessionScope.UserId) && sessionScope.UserId == post.user_email}"> --%>
		<c:if test="${'email' == post.user_email }">
			<button type="button" class="button btnFade btnBlueGreen"
				onclick="location.href='./re_write?num=${post.num }&ref=${post.ref }&re_step=${post.re_step }&re_level=${post.re_level }&secret=${post.secret }';">답글쓰기</button>
			<button type="button" class="button btnFade btnBlueGreen"
				onclick="location.href='./edit?num=${post.num }';">수정하기</button>
			<button type="button" class="button btnFade btnBlueGreen"
				onclick="deletePost()">삭제하기</button>
		</c:if>
		<button type="button" class="button btnFade btnBlueGreen"
			onclick="location.href='./list?page=${empty param.page ? '1' : param.page}&pageSize=${param.pageSize}'">
				목록보기
		</button>
		</tr>
	</table>
</form>
<script>


function deletePost() {
	var confirmed = confirm("정말로 삭제하겠습니까?");
	if(confirmed) {
		var form = document.writeForm;
		form.method="post";
		form.action="./delete";
		form.submit();
	}
}
</script>
</body>
</html>





