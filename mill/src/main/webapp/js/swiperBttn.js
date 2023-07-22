/**
 * 
 */
        function top10() { //top10 좌우버튼
            var swiper = new Swiper('.top10con', {
                slidesPerView:8,
                navigation: {
                    nextEl: '.top10Next',
                    prevEl: '.top10Prev',
                },
            });
        }
        top10();

        function romance() { //로맨스 좌우버튼
            var swiper = new Swiper('.romanceCon', {
                slidesPerView:8,
//             loop:true,
//             loopAdditionalSlides:1,
                navigation: {
                    nextEl: '.romanceNext',
                    prevEl: '.romancePrev',
                },
            });
        }
        romance();

        function action() { //액션 좌우버튼
            var swiper = new Swiper('.actionCon', {
                slidesPerView:8,
                // loop:true, 
                navigation: {
                    nextEl: '.actionNext',
                    prevEl: '.actionPrev',
                },
            });
        }
        action();

        function fantasy() { //SF판타지 좌우버튼
            var swiper = new Swiper('.fantasyCon', {
                slidesPerView:8,
                // loop:true, 
                navigation: {
                    nextEl: '.fantasyNext',
                    prevEl: '.fantasyPrev',
                },
            });
        }
        fantasy();

        function thriller() { //스릴러 좌우버튼
            var swiper = new Swiper('.thrillerCon', {
                slidesPerView:8,
                // loop:true, 
                navigation: {
                    nextEl: '.thrillerNext',
                    prevEl: '.thrillerPrev',
                },
            });
        }
        thriller();

        function animation() { //애니메이션 좌우버튼
            var swiper = new Swiper('.animationCon', {
                slidesPerView:8,
                // loop:true, 
                navigation: {
                    nextEl: '.animationNext',
                    prevEl: '.animationPrev',
                },
            });
        }
        animation();