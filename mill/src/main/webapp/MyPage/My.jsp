<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<%@ include file="../User/Nav.jsp"%>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="./css/My.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>

<body>
    <div class="tab">
        <button class="tablinks" onclick="openCity(event, 'ZZim')">찜</button>
        <button id="reviewBtn" class="tablinks ${param.m }" onclick="openCity(event, 'myReview')">나의리뷰</button>
        <button class="tablinks" onclick="openCity(event, 'myPage')">나의정보 수정</button>
        <div id="line" class="${param.m }"></div>
    </div>

    <div id="ZZim" class="tabcontent">
        <div class="page_select_right">
            <button class="My_edit_btn">편집</button>
            <div class="My_Edit_btn_hidden">
                <button type="button" class="My_Edit_btn_all">전체선택</button>
                <span class="my_edit_se"></span>
                <button type="button" class="My_Edit_btn_del" onclick="document.getElementById('id01').style.display='block'">삭제</button>
                <button class="My_Sub_btn">취소</button>
            </div>
        </div>
            <div id="id01" class="modal">
              
                <form class="modal-content">
                    <div class="container">
                        <p>삭제하시겠습니까?</p>
                        <div class="clearfix">
                            <button type="button" onclick="movie_like_deleteForm();" class="deletebtn">확인</button>
                            <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">취소</button>
                        </div>
                    </div>
                </form>
            </div>

        
        <section class="Movie_Search">
            <div class="Movie_result_list">
                <c:choose>
                    <c:when test="${not empty movieLikeLists}">
                        <c:forEach var="movie_like_dto" items="${movieLikeLists}">
                            <div class="Movie_result">
                                <input type="checkbox" name="chk" id="${movie_like_dto.movie_id }" class="movie_edit_check" value="${movie_like_dto.movie_id }"> 
                                <label for="${movie_like_dto.movie_id }" class="movie_check"></label>
                                <c:if test="${movie_like_dto.movie_rating.indexOf('18')!=-1 || movie_like_dto.movie_rating.indexOf('관람불가')!=-1}">
                                    <div class="movie_rating">
                                        <img class="rating_mark" src="./etc/${ movie_like_dto.movie_rating}.svg" />
                                    </div>
                                </c:if>
                                <a href="./movie_view?movie_id=${movie_like_dto.movie_id  }">
                                <img src="${movie_like_dto.movie_img }" class="Movie_result_img">
                                <div class="result_list_title">${movie_like_dto.movie_title }</div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="result-title">찜한 컨텐츠가 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <div class="MY_ZZim_Notice">
            <div>
                <h3>알아두세요!</h3>
                <ul>
                    <li>- 종료된 콘텐츠는 노출되지 않습니다.</li>
                </ul>
            </div>
        </div>
    </div>

    <div id="myReview" class="tabcontent">
        <div class="my_Review">
           <div id="id02" class="modal">
                <form class="modal-content">
                    <div class="container">
                        <p>삭제하시겠습니까?</p>
                        <div class="clearfix">
                            <button type="button" onclick="ReviewdeleteForm()" class="deletebtn">확인</button>
                            <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">취소</button>
                        </div>
                    </div>
                </form>
            </div>

        
            <c:choose>
                <c:when test="${not empty reviewLists}">
                    <c:forEach var="review_list_dto" items="${reviewLists}">
                        <div class="my_review_list">
                            <div class="dropup">
  								<button class="dropbtn">&#183;&#183;&#183;</button>
  								<div class="dropup-content">
    								<button class="My_review_Edit ${review_list_dto.review_num}">수정</button>
    								<button  onclick="document.getElementById('id02').style.display='block'">삭제</button>
  								</div>
                        	</div>
                        	<div id="review_num">${review_list_dto.review_num}</div>
	                        <span>⭐${review_list_dto.star_score }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🤍 ${review_list_dto.review_like_num} </span>
	                        <h3>&ldquo;${review_list_dto.movie_title }&rdquo;</h3>
	                        <h4>${ review_list_dto.review_title}</h4>
	                        <p class="close">${review_list_dto.review_content }</p>
	                        <input type="checkbox" class="more_content">  
                        </div>
                        <%@ include file="MyPage_ReviewEdit.jsp"%>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="result-title">작성한 리뷰가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="MY_ZZim_Notice">
            <div>
                <h3>첫 리뷰, 특별한 의미를 담아요!</h3>
                <ul>
                    <li>- 회원님의 소중한 경험과 생생한 느낌을 지금 바로 공유해주세요!</li>
                </ul>
            </div>
            <button class="my_main"  onclick="location.href='./movieMain'">영화 보러가기</button>
        </div>
    </div>

    <div id="myPage" class="tabcontent">
    	<%@ include file="./UserInfomation.jsp"%>
    </div>
    <%@ include file="../User/Footer.jsp" %>
    <script>
    $(".RE_CloseBtn").on("click", function() {
        $(this).parent().parent().parent().css('display', 'none');
     });
     $(".My_review_Edit").on("click", function() {
        let className = $(this).attr('class').split(' ')[1];
        console.log(className)
        console.log("#editedit" + className)
        $("#editedit" + className).css('display', 'block');
        $(".RV_myModal.RV_modal" + className).css('display', 'none');
   });


    const links = document.querySelectorAll(".tablinks"); // nav link
    const firstList = document.querySelector(".tab :first-child"); // nav 첫 번째 link
    console.log(firstList)
    const line = document.querySelector("#line"); // menu하단에 존재하는 line


    // link click 이벤트
    const clickLink = (e, index) => {
        line.style.width = e.currentTarget.offsetWidth + "px"
        line.style.left = e.currentTarget.offsetLeft + "px"
        line.style.top = (e.currentTarget.offsetTop + e.currentTarget.offsetHeight - 3) + "px"
        contentsIndex = index;
    }

    // 각 link 별 click 이벤트 등록
    links.forEach((link, index) => {
        link.addEventListener('click', (e) => clickLink(e, index));
    })

    function openCity(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    $(document).ready(function() {

        $('.Movie_result').hover(function() {
            $(this).addClass('result_up');
            $(this).removeClass('result_down');
        }, function() {
            $(this).addClass('result_down');
            $(this).removeClass('result_up');
        });
        

    });

    $(".My_edit_btn").on("click", function() {
        $(".My_Edit_btn_hidden").css('display', 'block');
        $(".My_edit_btn").css('display', 'none');
        $(".movie_check").css('display', 'block');
        $(".movie_rating").css('display', 'none');
    });

    $(".My_Sub_btn").on("click", function() {
        $(".My_Edit_btn_hidden").css('display', 'none');
        $(".My_edit_btn").css('display', 'block');
        $(".movie_check").css('display', 'none');
        $(".movie_rating").css('display', 'block');
        $(":checkbox").prop("checked", false);
    });
    let ch = false;	
    $(".My_Edit_btn_all").on("click", function(){
    	if(!ch){
    		$(".My_Edit_btn_all").text("전체해제");
    		$("input[name='chk']").prop("checked", true);
    		console.log("ch")
    		ch = true;
    	}else{
    		$(".My_Edit_btn_all").text("전체선택");
    		$("input[name='chk']").prop("checked",false);
    		ch = false;
    	}
        
    });

    function movie_like_deleteForm() {
    	if($("input:checkbox[name='chk']").is(":checked")==false) {
    			alert("적어도 하나는 선택하여 주세요.");
    			return;
    	}
    	else{
        const valueById = document.getElementsByClassName("movie_edit_check");
        let value_arr = "";
        for (let i = 0; i < valueById.length; i++) {
            if (valueById[i].checked) {
                value_arr += valueById[i].value
                value_arr += " "
                console.log(value_arr)
            }
        }
        $.ajax({
                url: './movie_likedelete?movie_id=' + value_arr,
                type: 'POST',
                data: {},
                success: function(result) {
                	location.reload();
                    console.log('마이페이지 찜하기 삭제 완료')
                },
                error: function() {
                    console.log('찜하기 삭제 중 오류')
                }
            });
    	}
        
    }
    
    function ReviewdeleteForm() {
    	let num = $("#review_num").text();
           $.ajax({
              url : './reviewdelete?review_num=' + num,
              type : 'POST',
              data : {},
              success : function(result) {
                 location.href = "./myPage?m=active"
                 console.log('리뷰 삭제 완료')
              },
              error : function() {
                 console.log('리뷰 삭제 중 오류')
              }
           });
      
     }
	
    // 초기 line 위치 지정
    if(${empty param.m}){
        line.style.width = firstList.offsetWidth + "px"
        line.style.left = firstList.offsetLeft + "px"
        line.style.top = (firstList.offsetTop + firstList.offsetHeight - 3) + "px";
    }else{
    	console.log($("#ZZim"))
    	$("#ZZim").css("display",  "none");
    	$("#myReview").css("display","block");
    }

    </script>

</body>

</html>