<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/dc95aa830a.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./css/Nav.css">
    <title>Million Movie</title>
</head>

<body>
    <header>
        <nav>
            <a href="./movieMain" class="logo"><img src="./etc/Logo.png"></a>
            <ul class="nav-links">
                <li>
				    <div class="search-box">
				        <form action="./search_list" method="post" class="searchForm">
				            <input type="search" name="searchWord" id="search" placeholder="Search…" value="${empty param.searchWord ? '' : param.searchWord}" autocomplete="off">
				            <button type="submit" class="searchMovie"><img  class="searchIcon" src="./etc/돋보기.png"></button>
				        </form>
				    </div>
                </li> 
                <!-- admin nav -->
                    <c:choose>
                        <c:when test="${user_email eq 'admin@naver.com'}">
                        	<li>
                                <a href="#"><img src="./etc/admin.png"></a>
                                <ul>
                                    <li><a href="#">${sessionScope.user_name}</a></li>
                                    <li><a href="./hash_manager" target="content">태그관리</a></li>
                                    <li><a href="./adminUser" target="content" onclick="openCity(event, 'myPage')">회원관리</a></li>
                                    <li><a href="./list" target="content">고객센터</a></li>
                                    <li><a href="./userLogout">로그아웃</a></li>
                                </ul>
                            </li>
                            <input type="hidden" value="${dto.user_email}" name="user_email">
                        </c:when>
                        
                        <c:otherwise>
                            <!-- user nav -->
                            <li>
                                <a href="#"><img src="./etc/user.png"></a>
                                <ul>
                                    <li><a href="#">${sessionScope.user_name}</a></li>
                                    <li><a href="./myPage#ZZim" target="content">마이페이지</a></li>
                                    <li><a href="./list" target="content">고객센터</a></li>
                                    <li><a href="./userLogout">로그아웃</a></li>
                                </ul>
                            </li>
                            <input type="hidden" value="${dto.user_email}" name="user_email">
                        </c:otherwise>
                    </c:choose>
            </ul>
        </nav>
    </header>

</body>
</html>