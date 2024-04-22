
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- header -->
    <header>
        <div class="inner-header">
            <h1 class="logo">
                <a href="/index">
                    <img src="/assets/img/navbar-logo.svg" alt="로고이미지">
                </a>
            </h1>
            <div class="profile-wrapper">
                <!-- 프로필 사진과 nickname 노출-->
                <c:if test="${login != null}"> <!--로그인이 되어 있으면 -->
                    <div class="profile-box">
                        <img id="profile" src="${login.profile}" alt="프사">
                    </div>
                    <p class="intro-text">${login.nickname}님, 안녕하세요!</p>
                </c:if>
            </div>

            <a href="#" class="menu-open">
                <span class="lnr lnr-menu"></span>
            </a>
        </div>

        <nav class="gnb">
            <a href="#" class="close">
                <span class="lnr lnr-cross"></span>
            </a>
            <ul>
                <li><a href="/board/list">OOTD 게시판</a></li>

                <c:if test="${empty login}"> <!-- el 문법임. login이 null이라면 ${login == null}-->
                    <li><a href="/members/sign-up">Sign Up</a></li>
                    <li><a href="/members/sign-in">Sign In</a></li>
                </c:if>

                <c:if test="${not empty login}">
                    <li><a href="/members/my-info">My Info</a></li>
                    <li><a href="/members/my-history">My History</a></li>
                    <li><a href="/members/sign-out">Sign Out</a></li>
                </c:if>
            </ul>
        </nav>

        <script>
            // 프로필 사진 렌더링 즉시 실행 함수
            const $profileImage = document.getElementById('profile');
            const pathIncludes = ("${login.profile}").includes("/profile"); // 카카오 로그인 회원이 프로필 사진 수정 이력이 있으면 경로 변경
            (function( ){
                if(${login.loginMethod eq 'KAKAO'}) {
                    if (pathIncludes) {
                        $profileImage.setAttribute("src", "/display${login.profile}");
                    } else {
                        $profileImage.setAttribute("src", "${login.profile}");
                    }
                } else if (${login.loginMethod eq 'COMMON'}) {
                    $profileImage.setAttribute("src", "/display${login.profile}");
                } else {
                    $profileImage.setAttribute("src", "/assets/img/anonymous-image.png");
                }
            } )( );
        </script>
    </header>
    <!-- //header -->
