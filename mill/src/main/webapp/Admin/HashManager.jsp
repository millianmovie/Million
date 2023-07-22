<%@page import="dto.MovieDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../User/Nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HashTag Manager</title>
 <link rel="stylesheet" href="./css/HashManager.css" />
</head>
<body>
	<%
	Object tagList = request.getAttribute("hashList");
	Object allMovies = request.getAttribute("allMovies");
	%>
	<div id="fir_con">
	<div class="container">
		<h1 style="margin-bottom: 1rem;">해시태그 관리</h1>
		<div style="margin-bottom: 1rem;">
			<input type="text" id="tag-input">
			<button id="add-button">+</button>
		</div>
		<section class="tag-area">
			<div class="tags-tab">
				<div id="under-line"></div>
				<div id="all">모든태그</div>
				<div id="unselected">추가안됨</div>
				<div id="selected">추가됨</div>
			</div>
			<div id="tag-board"></div>

		</section>
	</div>
	</div>

	<script src="hashList.js"></script>
	<script type="text/javascript" src="./showList.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/dc377819dc.js"
		crossorigin="anonymous"></script>
	<script>
let tagBoard = document.querySelector("#tag-board");

let tagList = <%=tagList%>;
let tagNums = tagList.filter((tag, i)=> i%2 == 0);
let tagNames = tagList.filter((tag, i)=> i%2 != 0);
let allMovies = <%=allMovies%>;
let tagNum = 0;
let tagName = '';
let message = document.querySelector(".message");
let tabs = document.querySelectorAll(".tags-tab div");
let mode='all';
let filterList=[];

function changeMessage(){
	message.innerHTML = '&nbsp해시태그관리';
	let tagNameSpan = '<span>"'+tagName+'"</span>'; 
	message.insertAdjacentHTML('afterbegin', tagNameSpan);
}
//tab부분이 클릭되면 각 탭에 맞는 리스트를 filter로 만듬
for(let i=1; i<tabs.length; i++){
    tabs[i].addEventListener("click", function(e){
        filter(e);
    });
}

let tagInput = document.querySelector('#tag-input');
let addButton = document.getElementById('add-button');

addButton.addEventListener('click', addHashtag);
tagInput.addEventListener("keypress", function(e){
	e.preventDefault();
	if(e.keyCode === 13){
		addButton.click();
	}
});

function addHashtag() {
	if(tagInput.value==='') return;
	$.ajax({
		url: "./hash_manager?mode=addTag&tagName="+tagInput.value,
 	 	type: "GET",
 	 	async: false,
			contentType: "application/json",
			success: function(result){
				if(result==1) {
					alert("해시태그 추가성공");
					location.reload();
				} else if(result==2) {
					alert(tagInput.value+"은/는 이미 있는 해시태그입니다.");
				} else {
					alert("해시태그 추가에 실패했습니다");
				}
			},
			error: function(request, status, error){ 
				alert("해시태그 추가에 실패했습니다");
			} // 에러가 발생했을 때, 호출될 함수
 	});
}

function deleteHashtag(delTagNum) {
	$.ajax({
		url: "./hash_manager?mode=delTag&tagNum="+delTagNum,
 	 	type: "GET",
 	 	async: false,
			contentType: "application/json",
			success: function(result){
				if(result==1){
					alert("해시태그 삭제성공");
					location.reload();
				} else{
					alert("해시태그 삭제에 실패했습니다");
				}
			},
			error: function(request, status, error){ 
				alert("해시태그 삭제에 실패했습니다");
			} // 에러가 발생했을 때, 호출될 함수
 	});
}

function createTag(tagNum, tagName){
	resultHTML = '';
	resultHTML += '<div class="tag">'
	resultHTML += '<div class="tag-name" data-data-tag-num="'+tagNum+'" data-data-tag-name="'+tagName+'">'
	resultHTML += tagName+'</div>'
	resultHTML += '<button class="delBtn" data-data-tag-num="'+tagNum+'" >'
	resultHTML += '<i class="fa-solid fa-trash-can"></i>'
	resultHTML += '</button>'
	resultHTML += '</div>'
	return resultHTML;
}

function createMovie(movieId, movieTitle, mode){
	resultHTML = '';
	resultHTML += '<div class="movie">'
	resultHTML += '<div class="movie-name" data-data-id="'+movieId+'">'
	resultHTML += movieTitle+'</div>'
	resultHTML += '<button class="changeBtn" data-data-id="'+movieId+'" >'
	if(mode=="selected"){	
		resultHTML += '<i class="fa-solid fa-minus"></i>'
	} else {
		resultHTML += '<i class="fa-solid fa-plus"></i>'
	}
	resultHTML += '</button>'
	resultHTML += '</div>'
	return resultHTML;
}


//tagBoard부분을 채워주는 render함수
render();
function render(){
    let resultHTML ='';
    if(mode === "all") {
	    tagNames.forEach((tag, i, arr)=>{
	    	resultHTML += createTag(tagNums[i], tag);
	    });
	    document.getElementById("tag-board").innerHTML = '';
	    document.getElementById("tag-board").insertAdjacentHTML('beforeend', resultHTML);
	    
	    $(".container").unbind().on("click", ".delBtn", function(e) {
    		let delBtn = e.target.closest('.delBtn');
    		let delTagNum = delBtn.dataset.dataTagNum;
    		if(confirm("정말 삭제하시겠습니까?") == true){
     			deleteHashtag(delTagNum);
    		}
        });
	    //해시태그클릭 => 관련 영화리스트 목록을 이요해 전체영화리스트를 init해주는 checkMoviesByTag함수 호출
   	 	$(".container").one("click", ".tag-name", function(e) {
			let tagNameDiv = e.target.closest('.tag-name');
  			tagName = tagNameDiv.dataset.dataTagName;//나중에 어떤 태그 관리인지 보여주기 위해 저장
  			tagNum= tagNameDiv.dataset.dataTagNum//특정 영화에서 해시태그 삭제, 추가 위해 저장
      		checkMoviesByTag(tagNum);
  			changeMessage();
      	});
    } else {
	    filterList.forEach((movie, i, arr)=>{    	
	        resultHTML += createMovie(movie.movie_id, movie.movie_title, mode)
	    });
	    document.getElementById("tag-board").innerHTML = '';
	    document.getElementById("tag-board").insertAdjacentHTML('beforeend', resultHTML);
	  	//토글버튼으로 영화에서 해시태그 추가/삭제
	    $(".container").unbind().on("click", ".changeBtn", function(e) {
    		let changeBtn = e.target.closest('.changeBtn');
    		let id = changeBtn.dataset.dataId;
     		changeHashtag(id, mode);
        });
	    //영화 제목 클릭시 영화상세화면으로 이동
	    $(".container").on("click", ".movie-name", function(e) {
	    	let id = e.target.dataset.dataId;
			window.location.href="./movie_view?movie_id="+id;
        });
    }
}

function checkMoviesByTag(tagNum){
	$.ajax({
 	 	url: "./hash_manager?mode=checkMoviesByTag&tagNum="+tagNum,
 	 	type: "GET",
			contentType: "application/json",
			success: function(result){
 			initMovieList(result);
			filter();
			},
			error: function(request, status, error){ 
				alert("해시태그로 정보 조회하는중 오류 발생.") 
		}
 	});
}

function initMovieList(result){
	selectedMovies = result.map(movie=> {
			return {
				movie_id: movie.movie_id,
				movie_title: movie.movie_title,
				isSelected: true,
			}
	});
	allMovies = allMovies.map(movie=> {
		return {
			movie_id: movie.movie_id,
			movie_title: movie.movie_title,
			isSelected: false,
		}
	});
	unselectedMovies = allMovies.filter( movie => !selectedMovies.map(m=>m.movie_id).includes(movie.movie_id));
	allMovies = selectedMovies.concat(unselectedMovies);
}

function changeHashtag(id, mode) {
	let state = '';
	if(mode=="selected"){
		state = "del";
	} else if(mode=="unselected"){
		state = "add";
	}
	$.ajax({
		url: "./hash_manager?mode="+state+"Movietag&tagNum="+tagNum+"&movieId="+id,
 	 	type: "GET",
 	 	async: false,
			contentType: "application/json",
			success: function(result){
				if(result==1){
					alert("영화의해시태그 추가/삭제성공");
					for (let i=0; i < allMovies.length; i++) {
       			    	if(allMovies[i].movie_id === id) {
            				allMovies[i].isSelected = !allMovies[i].isSelected;
            				break;
        				}
					}
					filter();
				} else {
					alert("영화의해시태그 추가/삭제성공");
				}
			},
			error: function(request, status, error){ 
			} // 에러가 발생했을 때, 호출될 함수
 	});
}

function filter(e) {	
    if(e) {
        mode = e.target.id;
        const underLine = document.getElementById("under-line")
        underLine.style.width = e.target.ofsetWidth + "px";
        underLine.style.top = e.target.offsetTop + e.target.offsetHeight + "px";
        underLine.style.left = e.target.offsetLeft + "px";
    }
    if(mode == "all"){
        render();
        return;
    } else if(mode == "unselected"){
        filterList = allMovies.filter( movie => movie.isSelected === false);
        render();
        return;
    } else if(mode == "selected"){
	    filterList = allMovies.filter( movie => movie.isSelected ===true);
		render();
        return;
    }
    render();
}

</script>
</body>
</html>