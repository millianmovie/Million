<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
Object movie = request.getAttribute("movie");
Object tags = request.getAttribute("tags");
%>
<%@ include file="../User/Nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MovieView</title>
<link rel="stylesheet" href="./css/Movie_view.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
	<script src="./js/showlist.js"></script>
</head>
<body>
	<div class="MV_background">
		<div class="MV_background_area">
			<div class="MV_background_img"
				style="background-image:url(${Movie.movie_img })"></div>
		</div>
	</div>

	<div class="MV_con">

		<div class="MV_content MV_content_wrap">

			<div class="MV_movie_title">${Movie.movie_title }</div>

			<div class="MV_movie__info">
				<div class="MV_rating">
					<img src="./etc/${Movie.movie_rating }.svg">
				</div>
				<div class="MV_info">
					<span style="font-size: 1rem;">⭐ </span>${star_score }</div>
				<div class="MV_info">${Movie.movie_year}</div>
				<div class="MV_info">${Movie.movie_runtime}분</div>
				<c:choose>
                    <c:when test='${ res!=1}'>
						<button class="MV_movie_like" onclick='movie_like(this);' data-cnt='${Movie.movie_id }' data-check='true'>
							<span id="movie_like" class="MV_movie_like_icon"></span>
						</button>
					</c:when>
					<c:otherwise>
						<button class="MV_movie_like" onclick='movie_unlike(this);' data-cnt='${Movie.movie_id }' data-check='false'>
							<span id="movie_like" class="MV_movie_like_icon2"></span>
						</button>
					</c:otherwise>
				</c:choose>
			</div>


			<div class="MV_movie_actor">출연&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div class="MV_movie_director">감독&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div class="MV_movie_ganre">장르&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div class="MV_movie_hashtag"></div>

			<details class="MV_movie_story">
				<summary>더보기</summary>
				<div class="MV_story">${Movie.movie_info }</div>
			</details>

		</div>
		<div class="MV_movie_poster">
			<img alt="${Movie.movie_title }의 메인 포스터" src="${Movie.movie_img }">
		</div>
	</div>

	<c:choose>
		<c:when test="${ Movie.movie_stills!=''}">
			<div class="MV_steal_Cut">
				<div class="swiper mySwiper">
					<div class="swiper-wrapper"></div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="MV_steal_Cut_None">
				<p class="MV_steal_Cut_None_result">
					<strong>‘${Movie.movie_title }’</strong>의 등록된 스틸컷이 없습니다.
				</p>
			</div>
		</c:otherwise>
	</c:choose>

<section class="MV_Movie_dir">
      <div class="MV_layout__flex-left">
        <h2>함께 시청된 콘텐츠</h2>
      </div>
	<div id="MV_contentList"></div>
</section>
	


	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<script>
    var swiper = new Swiper(".mySwiper", {
        slidesPerView: 4,
        spaceBetween: 30,
        loopedSlides: 1,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      });
    
	
 	element = document.getElementsByTagName("summary")[0];

 	element.addEventListener("click", function(e) {
		
 	  element.nextSibling.nextSibling.classList.toggle("MV_ani");
 	  
 	  element.parentElement.parentElement.classList.toggle('reveal')
 	  
 	})

	
	const movie = <%=movie%>;
	
	const actorWrap = document.querySelector(".MV_movie_actor");
	const actorArr = movie.movie_actors.split(",");

	actorArr.forEach((actor, i) => {
 		if(i<=4){
 			let actorSeparated = actor.split("|");
 			let act = document.createElement("a");
 			act.setAttribute("href", "./search_list?mode=act&actorId="+actorSeparated[1]+"&actor="+actorSeparated[0]);
 	       	act.classList.add("MV_actor");
 	       	
 			act.textContent = actorSeparated[0];
 			//css ::after content (lastchild아닐경우 ,추가)
 			actorWrap.appendChild(act)	
 		}

 		
	    
	});
	
	const tagWrap = document.querySelector(".MV_movie_hashtag");
	const tagArr = <%=tags%>;
	//[설렘주의, 1, 두근두근, 3]
		let tagsName = tagArr.filter((tag,i)=> i%2 !== 0);
		let tagsNum = tagArr.filter((tag,i)=> i%2 === 0);
		
		tagsName.forEach((tagname, i) => {
		let t = document.createElement("a");
		t.setAttribute("href", "./hash_list?mode=tag&tag_num="+tagsNum[i]);
		t.classList.add("MV_hashtag");
		t.textContent = tagname;
		console.log(t)
		tagWrap.appendChild(t);
	});
	
	
	const genreWrap = document.querySelector(".MV_movie_ganre");
	const genreArr = movie.movie_genre.split(",");
	genreArr.forEach(genre => {
		let g = document.createElement("div");
		g.classList.add("MV_genre");
		g.textContent = genre;
		genreWrap.appendChild(g);
	});
	
	
	
	const stillWrap = document.querySelector(".swiper-wrapper");
	const stillArr = movie.movie_stills.split("|")
	if(stillArr.length>1){
	stillArr.forEach((still, i) => {
		if(i<=7){
			let swiper_slide = document.createElement("div");
			swiper_slide.classList.add("swiper-slide");
			let s = document.createElement("img");
			s.src = still;
			swiper_slide.appendChild(s);
			stillWrap.appendChild(swiper_slide);
		}
	});
	};
	
	const dirWrap = document.querySelector(".MV_movie_director");
	const dirArr = movie.movie_director.split(",");	
	dirArr.forEach(dir => {
		const dirSeperated =  dir.split("|");
		let d = document.createElement("span");
 		d.textContent = dirSeperated[0];
 		dirWrap.appendChild(d)	
 		});
	
	let dir =  dirArr[0].split("|");
	if(dirArr[1]!= null){
	let dir2 =  dirArr[1].split("|");
	 		
	$(document).ready(function(){
		$.ajax({
 			url: "./search_list?mode=dir&directorId="+dir[1]+"&director="+dir[0]+"&director2Id="+dir2[1]+"&director2="+dir2[0],
 			type: "GET",
 			contentType: "application/json",
 			success: function(result){
					let directorId = dir[1];
					let directorId2 = dir2[1];
					let movieResult = getMovieList(result);
					checkDirectorList (movieResult, directorId, directorId2);
 			},
 			error: function(request, status, error){ 
 				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
			} // 에러가 발생했을 때, 호출될 함수
 		});
	});
	}
	else{
			$(document).ready(function(){
			$.ajax({
	 			url: "./search_list?mode=dir&directorId="+dir[1]+"&director="+dir[0],
	 			type: "GET",
	 			contentType: "application/json",
	 			success: function(result){
						let directorId = dir[1];
						let movieResult = getMovieList(result);
						checkDirectorList (movieResult, directorId);
	 			},
	 			error: function(request, status, error){ 
	 				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
				} // 에러가 발생했을 때, 호출될 함수
	 		});
			
		
	});
	}	
	
	  function movie_like(btn) {
		     console.log(btn)
		     let movie_id = btn.getAttribute('data-cnt')
		     console.log(movie_id)
		     $.ajax({
		        url : './movielike?movie_id=' + movie_id + '&mode=movie_like',
		        type : 'GET',
		        success : function(result) {
		           console.log("찜하기 추가완료")
		           $('#movie_like').attr('class','MV_movie_like_icon2');
		           btn.setAttribute("onClick", "movie_unlike(this)")
		           btn.setAttribute("data-cnt", movie_id);
		        },
		        error : function(request, status, error) {
		           alert("code:" + request.status + "\n" + "message:"
		                 + request.responseText + "\n" + "error:" + error)
		        }
		     });
		  }

		  function movie_unlike(btn) {
		     console.log(btn)
		     let movie_id = btn.getAttribute('data-cnt')
		     console.log(movie_id)
		     $.ajax({
		        url : './movielike?movie_id=' + movie_id + '&mode=movie_unlike',
		        type : 'GET',
		        success : function(result) {
		           console.log("찜하기 삭제완료")
		           $('#movie_like').attr('class','MV_movie_like_icon');
		           btn.setAttribute("onClick", "movie_like(this)")
		           btn.setAttribute("data-cnt", movie_id);
		        },
		        error : function(request, status, error) {
		           alert("code:" + request.status + "\n" + "message:"
		                 + request.responseText + "\n" + "error:" + error)
		        }
		     });
		  }
	
</script>

	<%@include file="../Review/ReviewList.jsp"%>
	<%@ include file="../User/Footer.jsp" %>
</body>
</html>