<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%@ include file="./IsLogin.jsp"%> --%>
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
<h2>답글쓰기</h2>
<form action="./re_write" method="post" onsubmit="return formCheck(this)">
	<div id="form-container">
		<label for="title" class="form form-title-label">제목</label>
		<input id="title" class="form form-title" type="text" name="title" value="A:">
		<c:choose>
			<c:when test="${post.secret == 'true' }">
				<input type="hidden" name="secret" value="${secret }">
			</c:when>
			<c:otherwise>
				<label for="secret" class="form form-secrete-label">비밀글</label>
				<input id="secret"class="form form-secret" type="checkbox" name="secret" id="secret">
			</c:otherwise>
		</c:choose>
		
		<label for="content" class="form form-content-label">내용</label>
		<textarea id="content" class="form form-content" type="text" name="content"></textarea>
		<input type="hidden" name="ref" value="${ref }">
		<input type="hidden" name="re_step" value="${re_step }">
		<input type="hidden" name="re_level" value="${re_level }">
		<input type="hidden" name="secret" value="${secret }">
		<div id="btns">
			<button type="submit">작성완료</button>
			<button type="reset">다시입력</button>
			<button type="reset" onclick="location.href='./list'">목록보기</button>
		</div>
	</div>
</form>
</body>

</html>