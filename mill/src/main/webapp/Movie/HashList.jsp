<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Object movieList = request.getAttribute("movieList");
Object tagName = request.getAttribute("tagName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HashList</title>
</head>
<link rel="stylesheet" href="./css/SearchMovieList.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="./js/showlist.js"></script>
<body>
	<section class="SL_search">
		<div>
			<form action="./search_list" method="post">
				<label class="SL_search__label" for="SL_search__input"> 
				<input id="SL_search__input" type="text" placeholder="제목, 인물명을 입력해보세요." class="SL_search__input" value="<%=tagName%>">
					<button type="submit" class="SL_icon__search"></button>
				</label>
			</form>
		</div>

		<div class="SL_search__result">
			<p class="SL_search__result_title">
				<strong>#<%=tagName%></strong> 검색 결과가 <span id="SL_totalCount"></span>개 있습니다.
			</p>
		</div>
	</section>

	<section class="SL_Movie_Search">
		<div class="SL_layout__flex_left">
			<h2 class="SL_lists__title">비슷한 TV프로그램</h2>
		</div>
		<div id="SL_Movie_result_list"></div>
	</section>

	<div class="SL_bottom">
		<div id="loadMoreBtn">더보기</div>
		<div id="scroll">맨위로</div>
	</div>
	<%@ include file="../User/Footer.jsp" %>
</body>
<script>
	let movieList =<%=movieList%>;
	console.log(movieList);
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

		let page = 1;

		const getMovieListPage = function () {
			const start = (page-1) * 10;
			const end = page * 10;
			if(movieList.length<end) {
				loadMoreBtn.style.display = 'none';
			}
			movieList = movieList.slice(start, end);
			document.getElementById("SL_totalCount").innerHTML=movieList.length;
			showMovieList('hash', movieList);
			page += 1;
		}

		//나중에 네비게이션 다시 선택
		let nav = document.querySelector('#nav');
		const scrollToTop = () => nav.scrollIntoView({behavior:"smooth"});	
		let scroll = document.querySelector('#scroll');
		scroll.addEventListener('click', scrollToTop);

		let loadMoreBtn = document.querySelector('#loadMoreBtn');
		loadMoreBtn.addEventListener('click', getMovieListPage);

		getMovieListPage();
		

	 
</script>
</html>