<%@page import="dao.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../User/Nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SearchList</title>
<link rel="stylesheet" href="./css/SearchMovieList.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="./js/showlist.js"></script>
</head>
<body>
	<%
	Object apiRes = request.getAttribute("apiRes");
	Object searchWord = request.getAttribute("searchWord");
	Object actorId = request.getAttribute("actorId");
	Object actor = request.getAttribute("actor");
	%>
	<section class="SL_search">
		<div>
			<form action="./search_list" method="post">
				<label class="SL_search__label" for="SL_search__input"> 
				<input id="SL_search__input" type="text" placeholder="제목, 인물명을 입력해보세요." class="SL_search__input" value="" name="searchWord">
					<button type="submit" class="SL_icon__search"></button>
				</label>
			</form>
		</div>

		<div class="SL_search__result">
			<p class="SL_search__result_title">
				<strong></strong> 검색 결과가 <span id="SL_totalCount"></span>개 있습니다.
			</p>
		</div>
	</section>

	<section class="SL_Movie_Search">
		<div class="SL_layout__flex_left">
			<h2 class="SL_lists__title">영화</h2>
		</div>
		<div id="SL_Movie_result_list"></div>
	</section>

	<div class="SL_bottom">
		<div id="loadMoreBtn">더보기</div>
		<div id="scroll">맨위로</div>
	</div>
	<%@ include file="../User/Footer.jsp" %>
	<script>
	// 영화 리스트 애니메이션
	$(document).ready(function () 
		  {
		      $(".SL_Movie_Search").on("mouseenter", '.SL_Movie_result', function(){
		          $(this).addClass('SL_result_up');
		          $(this).removeClass('SL_result_down');
		      });
		      
		      $(".SL_Movie_Search").on("mouseleave", '.SL_Movie_result', function() {
		    	  $(this).addClass('SL_result_down');
		    	  $(this).removeClass('SL_result_up');
		      });
	});
	let searchWord = "<%=searchWord%>";
	let actorId = "<%=actorId%>";
	let actor = "<%=actor%>";

	searchWord = decodeURI(searchWord).replaceAll("+"," ");
	const searchBox = document.getElementById("SL_search__input");
	const searchBox2 = document.getElementsByClassName("SL_search__result_title")[0].childNodes[1];
	console.log("2:"+searchBox2)
	if(searchWord !== "null"){
		searchBox.value = searchWord;
		searchBox2.innerText="‘"+searchWord+"’"
		searchWord = decodeURI(searchWord).replace("+"," ");
	} else if(actor !== "null"){
		searchBox.value = decodeURI(actor).replace("+"," ");
		searchBox2.innerText="‘"+searchBox.value+"’";
	}
	
	
	let apiRes = <%= apiRes%>;
	getMovieList(apiRes);


// 	if(movieResult==null) {
// 		alert("검색결과가 없습니다 :<");
// // 		history.back();
// 	}


	if(searchWord !== "null") {
		movieResult = checkMovieList(movieResult, searchWord);
		
	}

	if(actorId !== "null") {
		console.log("ACTORID NOT NULL")
		movieResult = checkActorList(movieResult, actorId)
	}

	let page = 1;
	let movieList;

	const getMovieListPage = function () {
		const start = (page-1) * 10;
		const end = page * 14;
		if(movieResult.length<end) {
			loadMoreBtn.style.display = 'none';
		}
		movieList = movieResult.slice(start, end);
		showMovieList('search', movieList);
		page += 1;
	}

	//나중에 네비게이션 다시 선택
	let nav = document.querySelector('#SL_search_input');
	const scrollToTop = () => nav.scrollIntoView({behavior:"smooth"});	
	let scroll = document.querySelector('#scroll');
	scroll.addEventListener('click', scrollToTop);

	let loadMoreBtn = document.querySelector('#loadMoreBtn');
	loadMoreBtn.addEventListener('click', getMovieListPage);

	getMovieListPage();
	
	document.getElementById("SL_totalCount").innerHTML=movieResult.length;

   	
</script>

</body>
</html>