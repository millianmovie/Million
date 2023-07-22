/**
 * 
 */
$('.slides').slick({ //TopImg 무한 자동슬라이드
    infinite: true,
    slidesToShow: 1, //한 화면에 보여질 컨텐츠 갯수(1이면 1개, 2이면 2개)
    slidesToScroll: 1, //한 번 스크롤 때 마다 움직일 컨텐츠(1이면 1개씩, 2이면 2개씩)
    speed: 1000, //버튼 클릭 후 다음 컨텐츠 출력 시간
    dots: true,
    arrows: true, //화살표(버튼) 표시 여부
    prevArrow: "<button type='button' class='topslide_bttn prevbttn'>&#10092;</button>",
    nextArrow: "<button type='button' class='topslide_bttn nextbttn'>&#10093;</button>",
    autoplay: true, //자동 슬라이드 여부
    autoplaySpeed: 3000, //자동 슬라이드시 속도
    pauseOnHover: true, //슬라이드 이동시 마우스 호버하면 슬라이드 멈춤
    responsive: [
    {
    breakpoint: 1200,
    settings: {
        slidesToShow: 1,
    }
    },
    {
    breakpoint: 992,
    settings: {
        slidesToShow: 1,
    }
    },
    {
    breakpoint: 768,
    settings: {
        slidesToShow: 1,
    }
    }
]
});