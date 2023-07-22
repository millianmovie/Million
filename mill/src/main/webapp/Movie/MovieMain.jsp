<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<!-- slick -->
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<meta charset="UTF-8">
<title>MnM Main</title>
<link rel="stylesheet" href="./css/Main.css">
<link rel="stylesheet" href="./css/MainTopSlide.css">
<link rel="stylesheet" href="./css/MainSwiperSlide.css">
</head>
<body>
	<%@ include file="../User/Nav.jsp"%>
	<section>
		<div class="content">
			<div class="slider">
				<div class="slides">
					<!-- TopImgSlide -->
					<div class="slide-img">
						<a href="./movie_view?movie_id=K34410"><img
							src="https://i.ytimg.com/vi/ysW2FxaFOkI/maxresdefault.jpg"
							alt="범죄도시3"></a>
					</div>
					<div class="slide-img">
						<a href="./movie_view?movie_id=K34361"><img
							src="https://static.kinolights.com/popcorn/payable-point-item/view/20/thumbnail.jpg"
							alt="귀공자"></a>
					</div>
					<div class="slide-img">
						<a href="./movie_view?movie_id=F58761"><img
							src="https://cdn.highnews.co.kr/news/photo/202306/1575_7894_27.jpg"
							alt="명탐정코난"></a>
					</div>
					<div class="slide-img">
						<a href="./movie_view?movie_id=F50571"><img
							src="https://i.ytimg.com/vi/L9Y-hn2COm0/maxresdefault.jpg"
							alt="분노의질주"></a>
					</div>
					<div class="slide-img">
						<a href="./movie_view?movie_id=F58164"><img
							src="https://i.ytimg.com/vi/GaJlVfIJnpQ/maxresdefault.jpg"
							alt="플래시"></a>
					</div>
					<div class="slide-img">
						<a href="./movie_view?movie_id=F57443"><img
							src="https://image.fmkorea.com/files/attach/new3/20230601/4330174/3443857531/5826187409/7b19dedf29da3def347846332ebd748c.png"
							alt="엘리멘탈"></a>
					</div>
					<div class="slide-img">
						<iframe width="1709" height="750"
							src="https://www.youtube.com/embed/grxS6XTylX0?autoplay=1&mute=1&controls=0&loop=1&playlist=grxS6XTylX0"
							title="스파이더맨" frameborder="0"
							allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
							allowfullscreen></iframe>
					</div>
				</div>
			</div>
		</div>

		<c:if test="${recommendListByGenre != null}">
			<div class="recommend">
				<h2>추천영화</h2>
				<div class="swiper-container recommendCon">
					<div class="swiper-wrapper">
						<c:forEach items="${recommendListByGenre}" var="movie">
							<div class="swiper-slide" data-movie_id="${movie.movie_id}">
								<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
									<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
								</c:if>
								<img src="${movie.movie_img}" alt="${movie.movie_title}">
								<span>${movie.movie_title}</span>
							</div>
						</c:forEach>
					</div>

					<div class="swiper-button-next recommendNext buttonNext"></div>
					<div class="swiper-button-prev recommendPrev buttonPrev"></div>
				</div>
			</div>
		</c:if>

		<div class="top20">
			<h2>Top20</h2>
			<div class="swiper-container top20Con">
				<div class="swiper-wrapper">
					<c:forEach items="${top20List}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">
							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>
							<img src="${movie.movie_img}" alt="${movie.movie_title}"> <span>${movie.movie_title}</span>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next top20Next"></div>
				<div class="swiper-button-prev top20Prev"></div>
			</div>
		</div>




		<div class="romance">
			<h2>설렘주의보</h2>
			<div class="swiper-container romanceCon">
				<div class="swiper-wrapper">
					<c:forEach items="${romanceListByGenre}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">
							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>

							<img src="${movie.movie_img}" alt="${movie.movie_title}">
							${movie.movie_title}
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next romanceNext"></div>
				<div class="swiper-button-prev romancePrev"></div>
			</div>
		</div>

		<div class="comedy">
			<h2>배꼽빠지는</h2>
			<div class="swiper-container comedyCon">
				<div class="swiper-wrapper">
					<c:forEach items="${comedyListByGenre}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">

							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>
							<img src="${movie.movie_img}" alt="${movie.movie_title}"> <span>${movie.movie_title}</span>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next comedyNext"></div>
				<div class="swiper-button-prev comedyPrev"></div>
			</div>
		</div>

		<div class="fantasy">
			<h2>신비로운</h2>
			<div class="swiper-container fantasyCon">
				<div class="swiper-wrapper">
					<c:forEach items="${fantasyListByGenre}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">
							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>
							<img src="${movie.movie_img}" alt="${movie.movie_title}">
							${movie.movie_title}
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next fantasyNext"></div>
				<div class="swiper-button-prev fantasyPrev"></div>
			</div>
		</div>

		<div class="thriller">
			<h2>1분1초가 긴박한</h2>
			<div class="swiper-container thrillerCon">
				<div class="swiper-wrapper">
					<c:forEach items="${thrillerListByGenre}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">
							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>
							<img src="${movie.movie_img}" alt="${movie.movie_title}">
							${movie.movie_title}
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next thrillerNext"></div>
				<div class="swiper-button-prev thrillerPrev"></div>
			</div>
		</div>

		<div class="drama">
			<h2>눈물 주룩주룩</h2>
			<div class="swiper-container dramaCon">
				<div class="swiper-wrapper">
					<c:forEach items="${dramaListByGenre}" var="movie">
						<div class="swiper-slide" data-movie_id="${movie.movie_id }">
							<c:if test="${movie.movie_rating == '18세관람가(청소년관람불가)'}">
								<img class="ratingImg" src="./etc/${movie.movie_rating }.svg">
							</c:if>
							<img src="${movie.movie_img}" alt="${movie.movie_title}"> <span>${movie.movie_title}</span>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next dramaNext"></div>
				<div class="swiper-button-prev dramaPrev"></div>
			</div>
		</div>
	</section>
	<%@ include file="../User/Footer.jsp"%>

	<script>
		$(document).ready(function() {
			$(".swiper-slide").on("mouseenter", function() {
				$(this).addClass('SL_result_up');
				$(this).removeClass('SL_result_down');
			});

			$(".swiper-slide").on("mouseleave", function() {
				$(this).addClass('SL_result_down');
				$(this).removeClass('SL_result_up');
			});
		});
		// 영화 장르별 스와이퍼
		var recommendSwiper = new Swiper('.recommendCon', {
			slidesPerView : 7, //화면에 보여질 슬라이드 갯수
			slidesPerGroup : 7, // 슬라이드 될 때 마다 넘겨질 갯수
			spaceBetween : 10,
			navigation : {
				nextEl : '.recommendNext',
				prevEl : '.recommendPrev',
			},
		});

		var top20Swiper = new Swiper('.top20Con', {
			slidesPerView : 7, //화면에 보여질 슬라이드 갯수
			slidesPerGroup : 7, // 슬라이드 될 때 마다 넘겨질 갯수
			spaceBetween : 10,
			navigation : {
				nextEl : '.top20Next',
				prevEl : '.top20Prev',
			},
		});

		var romanceSwiper = new Swiper('.romanceCon', {
			slidesPerView : 7,
			slidesPerGroup : 7,
			spaceBetween : 10,
			navigation : {
				nextEl : '.romanceNext',
				prevEl : '.romancePrev',
			},
		});

		var comedySwiper = new Swiper('.comedyCon', {
			slidesPerView : 7,
			slidesPerGroup : 7,
			spaceBetween : 10,
			navigation : {
				nextEl : '.comedyNext',
				prevEl : '.comedyPrev',
			},
		});

		var fantasySwiper = new Swiper('.fantasyCon', {
			slidesPerView : 7,
			slidesPerGroup : 7,
			spaceBetween : 10,
			navigation : {
				nextEl : '.fantasyNext',
				prevEl : '.fantasyPrev',
			},
		});

		var thrillerSwiper = new Swiper('.thrillerCon', {
			slidesPerView : 7,
			slidesPerGroup : 7,
			spaceBetween : 10,
			navigation : {
				nextEl : '.thrillerNext',
				prevEl : '.thrillerPrev',
			},
		});

		var dramaSwiper = new Swiper('.dramaCon', {
			slidesPerView : 7,
			slidesPerGroup : 7,
			spaceBetween : 10,
			navigation : {
				nextEl : '.dramaNext',
				prevEl : '.dramaPrev',
			},
		});

		// 장르별 영화 해당 상세페이지로 이동
		$('.swiper-slide').on('click', function() {
			// 클릭한 영화의 정보를 가져옴
			var movieImg = $(this).find('img').attr('src');
			var movieTitle = $(this).find('img').attr('alt');

			// 상세 페이지로 이동하는 로직을 추가
			console.log('Clicked movie:', movieTitle);
			console.log('Image source:', movieImg);

			// 상세 페이지로 이동할 URL을 생성
			var movieId = $(this).data('movie_id'); // data 속성을 이용하여 영화 ID를 가져옴
			console.log(movieId);
			var detailPageUrl = './movie_view?movie_id=' + movieId; // URL을 생성

			// 생성한 URL로 페이지를 이동
			window.location.href = detailPageUrl;
		});

		// 각 슬라이드 개수 제한
		var top20Slides = document.querySelectorAll('.top20Con .swiper-slide');
		var top20slides = [ top20Slides ]; // top20, 슬라이드 20개
		top20slides.forEach(function(slideList) {
			if (slideList.length > 20) {
				for (var i = 20; i < slideList.length; i++) {
					slideList[i].style.display = 'none'; // 20개 이후 슬라이드 숨김 처리
				}
			}
		});
	</script>
	<script src="./js/SwiperBttn.js"></script>
	<script src="./js/MainTopSlide.js"></script>
	<script src="./js/showlist.js"></script>
</body>
</html>