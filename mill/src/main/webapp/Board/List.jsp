<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../User/Nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  <link href="board.css" rel="stylesheet" type="text/css"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<style>
/* $pagination-color: white; */
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
body, .container{
 	background-color: #191A1D;
}
th, td{
	text-align: center;
}
td.title{
	text-align: left;
}

a, a:visited{
	display: inline-block;
	width: 90%;
	height: 100%;
	color: inherit;
	text-decoration: none;
}
#board-info{
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
}
h2{
	color: white;
}
.page-container{
 	display: flex;
  	justify-content: center; 
 	align-items: center;
}
.pagination {
    --bs-pagination-active-color: #fff;
    --bs-pagination-active-bg: red;
    --bs-pagination-active-border-color: red;
    display: flex;
    padding-left: 0;
    list-style: none;
}
:root, [data-bs-theme=light]{
	--bs-link-hover-color: red;
}

.postContent{
	display: flex;
	flex-direction: column;
}
.postBtns{
	width: 100%;
	display: flex;
	justify-content: right;
	padding-top: 16px;
}
.submit-reply, .edit-reply{
	position: absolute;
	bottom: 10px;
	right: 7px;
	color: black;
}
.delete-reply{
	position: absolute;
	bottom: 10px;
	right: 50px;
	color: black;
}

textarea#ta{
	background-color: #e5e6e7;
	border: none;
	padding: 0;
	margin: 0;
	resize: none;
}

textarea#ta:focus{
	box-shadow: none;
}

tr.table-light{
	--bs-table-bg: #e5e6e7;
}
.post-content{
	text-align: left;
}
.content-question-container, .content-answer-container{
	display: flex;
	flex-wrap: wrap;
	padding-top: 15px;
}
.content-question{
  	margin-left: 16px;
}
.content-answer{
 	margin-top: -5px;
  	margin-left: 40px;
	position: relative;
	width: 100%;
}
.reply-date{
  	margin-left: 40px;
}
i{
	padding-left: 10px;
}
.answer-icon i{
	position: absolute;
}
.hidden{
	display: none;
}
</style>
</head>
<body>
	<div class="container">
	<div id="board-info">	
		<h2>Q&A 게시판</h2>
		<button type="button"  class="btn btn-light"
			onclick="location.href='./write';">글쓰기</button>
	</div>
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<th width="70%">제목</th>	
				<th width="15%">작성자</th>	
				<th width="15%">작성일</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${empty postList }">
				<tr><td colspan="5" align="center">등록된 글이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="post" items="${postList }">
	  				<tr class="post-container">
						<td class="title">
							<c:if test="${post.secret=='true' }">
								<c:choose>
									<c:when test="${sessionScope.user_email eq post.user_email || sessionScope.user_email eq 'admin@naver.com' }">
											<div class="post-title" data-num="${post.num }">
												${post.title}
											</div>
									</c:when>
									<c:otherwise>
											비밀글/답글은 작성자만 확인할 수 있습니다 
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${post.secret=='false' }">
									<div class="post-title" data-num="${post.num }">
										${post.title}
									</div>
							</c:if>
						</td>
						<td>${post.user_email}</td>
						<fmt:formatDate value="${post.post_date }" type="date" pattern="yyyy-MM-dd" var="post_date" />
						<fmt:formatDate value="${today }" type="date" pattern="yyyy-MM-dd" var="tday" />
						<fmt:formatDate value="${post.post_date }" type="time" pattern="HH:mm" var="post_time" />
						<c:choose>
							<c:when test="${post_date eq tday }">
								<td>${post_time }</td>
							</c:when>
							<c:otherwise>
								<td>${post_date }</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr id="content-container" class="table-light hidden">
						<td colspan="3">
						    <div class="content-question-container">
						    	<div class="question-icon">
						    		<i class="fa-solid fa-q"></i>
						    	</div>
						    	<div class="content-question">
						    		${post.content }
						    	</div>
						    	<div class="postBtns">
						    		<c:if test="${sessionScope.user_email eq post.user_email }">
						    			<button type="button" class="btn btn-sm editBtn"
						    				onclick="location.href='./edit?num=${post.num}'">수정</button>
						    			<button type="button" class="btn btn-sm"
						    				onclick="deletePost(${post.num})">삭제</button>
						    		</c:if>
						    		<c:if test="${sessionScope.user_email eq 'admin@naver.com' }">
						    			<button type="button" class="btn btn-sm"
						    				onclick="deletePost(${post.num})">삭제</button>
						    		</c:if>
						    	</div> <!-- end postBtns -->
						    </div>
							<div class="content-answer-container hidden">
								<div class="answer-icon">
									<i class="fa-solid fa-a"></i>
								</div>
								<div class="content-answer">
									<textarea type="text" id="ta" class="form-control" rows="5"></textarea>
								</div>
								<div class="reply-date"></div>
							</div>
						</td>
					</tr>
				</c:forEach>	
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
		<div class="page-container">
			<ul class="pagination" id="page">
				<c:if test="${ph.showPrev }">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/list${ph.sc.getQueryString(ph.beginPage-1) }'/>">&laquo;</a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
					<li class="page-item ${ph.sc.page==i ? 'active' : '' }">
						<a class="page-link" href="<c:url value='/list${ph.sc.getQueryString(i) }'/>">
							${i}
						</a>
					</li>
				</c:forEach>
				<c:if test="${ph.showNext }">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/list${ph.sc.getQueryString(ph.endPage+1) }'/>">&raquo;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div> 
	<%@ include file="../User/Footer.jsp" %><!-- 	end container -->
</body>
<script src="https://kit.fontawesome.com/dc377819dc.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>	

let id = '<%=(String)session.getAttribute("user_email")%>';
let replyInput;
let delReplyBtn;
let editReplyBtn;
let submitReplyBtn;
let postNum;
let answerContainer;
let replyDate;
let answerDiv;
let today = new Date();
let mode="";

let postTitles = document.querySelectorAll('.post-title');
postTitles.forEach( title => {
	title.addEventListener('click', function(e){
		let title = e.target;
		postNum = title.getAttribute('data-num');
		let contentContainer = title.closest('.post-container').nextElementSibling;
		contentContainer.classList.toggle('hidden');
		answerContainer = contentContainer.querySelector('.content-answer-container');
		replyInput = answerContainer.querySelector('textarea');
		replyDate = answerContainer.querySelector('.reply-date');
		answerDiv = contentContainer.querySelector('.content-answer'); 

		if(id=='admin@naver.com'){
			submitReplyBtn = createBtn(submitReplyBtn, '작성', submitReply, 'submit-reply');
			editReplyBtn = createBtn(editReplyBtn, '수정', editReply, 'edit-reply');
			delReplyBtn = createBtn(delReplyBtn, '삭제', deleteReply, 'delete-reply');
		}
		showComment(postNum);
	});
});

function createBtn(btn, msg, fn, className){
	btn = document.createElement('button');
	btn.textContent = msg;
	addClass(btn, 'hidden', 'btn', 'btn-sm', className)
	btn.addEventListener('click', function(){
		fn(postNum, mode);
	});
	answerDiv.insertAdjacentElement('beforeend', btn);
	return btn;
}

let addClass = function(el,...classNames){
	classNames.forEach( name => {
		el.classList.add(name);
	})
}

let showBtns = function(btn1, btn2){
	let btns = answerDiv.querySelectorAll('.btn-sm');
	btns.forEach( btn => {
		btn.classList.add('hidden');
		if(btn.classList.contains(btn1) || btn.classList.contains(btn2)){
			btn.classList.remove('hidden');
		}
	});
}

let showComment = function(postNum){
	$.ajax({
		type:'GET',
		url:'./comment?bno='+postNum,
		contentType: "application/json; charset=utf-8",
		success: function(result){
			if(result != null) {	
				answerContainer.classList.remove('hidden');
				replyInput.value = result.comment;
				replyInput.readOnly = true;
				let date = new Date(result.reg_date);
				replyDate.textContent = toStringByFormatting(date);
				if(id=='admin@naver.com'){
					showBtns('edit-reply','delete-reply');
				}
			} else if(id=='admin@naver.com'){
		    	answerContainer.classList.remove('hidden');
				showBtns('submit-reply');
				replyInput.value = '';
				replyDate.textContent = '';
				replyInput.readOnly = false;
			}
		},
		error: function(request, status, error){ 
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
		}
	});
}

function leftPad(value){
	if(value >= 10){
		return value;
	}
	return '0'+value;
};
function toStringByFormatting(date, delimiter = '-'){
	const year = date.getFullYear();
	const month = leftPad(date.getMonth() + 1);
	const day = leftPad(date.getDate());
	if(date.toDateString() == today.toDateString()){
		const hour = leftPad(date.getHours());
		const minute = leftPad(date.getMinutes());
		return [year, month, day].join(delimiter) + ' ' + [hour, minute].join(':');
	} 
	return [year, month, day].join(delimiter);
};

function submitReply(postNum, method) {
		comment = replyInput.value;
		$.ajax({
			type: 'POST',
			url: './comment',
			async: false,
			data: {bno:postNum, comment:comment, mode:method },
			success: function(result){
				if(result==1){
					showComment(postNum);
				} 
				mode = "";

			},
			error: function(request, status, error){ 
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
			}
	    });
}
function deleteReply(postNum) {
	$.ajax({
		type: 'GET',
		url: './comment?bno='+postNum+"&mode=del",
		success: function(result){
			if(result==1){					
				showComment(postNum);
			}
		},
		error: function(request, status, error){ 
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
		}
		});
}

function editReply(postNum) {
	mode = "mody";
	replyInput.readOnly=false;
	showBtns('submit-reply');
	submitReplyBtn.addEventListener('click', function(){
		submitReply(postNum, "mody");
	});
}

function deletePost(postNum) {
	var confirmed = confirm("정말로 삭제하겠습니까?");
	if(confirmed) {
		$.ajax({
 			url: "./delete?num="+postNum,
 			type: "post",
 			contentType: "application/json",
 			success: function(result){
				if(result==1){
					alert("삭제되었습니다.");
					location.reload();
				} else{
					alert("글 삭제중 오류가 발생했습니다.");
				}
 			},
 			error: function(request, status, error){ 
 				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
			} 
 		});
	}
}

</script>
</html>