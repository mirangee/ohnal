<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>

  <link rel="stylesheet" href="/assets/css/my-info.css">

  <!-- my-info js -->
  <script src="/assets/js/my-info.js" defer></script>

  <%-- 다음 주소 API  --%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<%@include file="../include/header.jsp"%>

<body>


  <div class="container">
    <h2>My Info</h2>
    <form action="/modify-info" class="form" name="modify-info" id="modify-info" method="post" enctype="multipart/form-data">

      <div class="image_container">
        <img id="image-preview" src="/display${memberInfo.profile}" alt="프로필 사진">
      </div>

      <div class="inner-before">
        <div class="form-selection">
          <p class="inform"> ${memberInfo.nickname}님의 등록 정보입니다</p>
          <table>
            <tr>
              <td>
                <p><strong>이메일</strong></p>
              </td>
              <td><p>${memberInfo.email}</p>
                <input type="hidden" id="email" name="email" value="${memberInfo.email}">
              </td>
            </tr>
            <tr>
              <td>
                <p><strong>닉네임</strong></p>
              </td>
              <td><p>${memberInfo.nickname}</p></td>
            </tr>
            <tr>
              <td>
                <p><strong>주소</strong></p>
              </td>
              <td><p>${memberInfo.address}</p></td>
            </tr>
            <tr>
              <td>
                <p><strong>성별</strong></p>
              </td>
              <c:if test="${memberInfo.gender eq 'M'}">
                <td><p>남자</p></td>
              </c:if>
              <c:if test="${memberInfo.gender eq 'F'}">
                <td><p>여자</p></td>
              </c:if>
              <c:if test="${memberInfo.gender eq null}">
                <td><p>미입력</p></td>
              </c:if>
            </tr>
            <tr>
              <td>
                <p><strong>가입일</strong></p>
              </td>
              <td><p>${memberInfo.regDate}</p></td>
            </tr>

          </table>

        </div>
      </div>


      <%-- 수정하기 버튼 클릭 시 노출 --%>
      <div class="inner-change" style="display: none">

          <div class="btn_image">
              프로필 사진 변경
          </div>
          <input type="file" id="profileImage" name="profileImage" accept="image/*" style="display: none;">

        <div class="form-selection">

          <table>
            <tr>
              <td>
                <p><strong>이메일</strong></p>
              </td>
              <td><p>${memberInfo.email}</p></td>
              <td></td>
            </tr>
            <tr>
              <td>
                <p><strong>닉네임</strong></p>
              </td>
              <td><input class="input-part" id="nick" type="text" value=${memberInfo.nickname} name="nickname" required="required" aria-required="true"
                         placeholder="2자 이상 영문/한글 입력" maxlength="8"></td>
              <td><button type="button" id="nickname-check" class="btn-modify">중복 확인</button></td>
            </tr>
            <tr>
              <td>
                <p><strong>주소</strong></p>
              </td>
              <td>
                <input class="input-part" type="text" id="origin-address" value="${memberInfo.address}" readonly>
                <input class="input-part" type="text" id="sample6_address" placeholder="주소" style="display: none"><br>
                <input class="input-part" type="text" id="sample6_detailAddress" placeholder="상세주소" style="display: none">
                <input class="input-part" type="hidden" id="address" name="address" value="${memberInfo.address}">
              </td>
              <td><input class="btn-modify" type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"></td>
            </tr>
            <tr>
              <td>
                <p><strong>성별</strong></p>
              </td>
              <c:if test="${memberInfo.gender eq 'M'}">
                <td><input type="radio" name="gender" value="M" checked> 남자
                <input type="radio" name="gender" value="F"> 여자</td>
                <td></td>
              </c:if>
              <c:if test="${memberInfo.gender eq 'F'}">
                <td><input type="radio" name="gender" value="M"> 남자
                <input type="radio" name="gender" value="F" checked> 여자</td>
                <td></td>
              </c:if>
              <c:if test="${memberInfo.gender eq null}">
                <td><input type="radio" name="gender" value="M"> 남자
                <input type="radio" name="gender" value="F"> 여자</td>
                <td></td>
              </c:if>
            </tr>
            <tr>
              <td>
                <p><strong>가입일</strong></p>
              </td>
              <td><p>${memberInfo.regDate}</p></td>
              <td></td>
            </tr>

<%--            <c:if test="${login.loginMethod eq 'COMMON'}">--%>
<%--              <tr>--%>
<%--                <td>--%>
<%--                  <p><strong>비밀번호</strong></p>--%>
<%--                  <p><strong>${login.password}</strong></p>--%>
<%--                </td>--%>
<%--                <td>--%>
<%--                  <p id="pw-inform">암호화 저장 완료</p>--%>

<%--                  <div class="form-list" style="display: none;">--%>
<%--                    <p class="font"><strong>새 비밀번호 입력</strong></p>--%>
<%--                    <input class="input-part" type="password" id="pw" placeholder="영문+숫자+특수문자 8자리 이상" maxlength="20"--%>
<%--                           class="input">--%>
<%--                    <span id="pwChk"></span>--%>
<%--                    <p class="font"><strong>비밀번호 재확인</strong></p>--%>
<%--                    <input class="input-part" type="password" id="pw2" placeholder="비밀번호 재입력" maxlength="20"--%>
<%--                           class="input">--%>
<%--                    <input type="file" id="password" name="password" style="display: none;">--%>
<%--                    <span id="reChkPw"></span>--%>
<%--                  </div>--%>
<%--                </td>--%>
<%--                <td><input id="modify-pw" class="btn-modify" type="button" value="비밀번호 변경"></td>--%>
<%--              </tr>--%>
<%--            </c:if>--%>
          </table>
        </div>
      </div>

      <button type="button" id="submit_button">수정하기</button>

    </form>
  </div>

  <%@include file="../include/footer.jsp"%>

  <script>
    // 프로필 사진 렌더링 즉시 실행 함수
    const $profileImage = document.getElementById('image-preview');
    const pathIncludes = ("${login.profile}").includes("/profile"); // 카카오 로그인 회원이 프로필 사진 수정 이력이 있으면 경로 변경
    (function( ){
      if(${memberInfo.loginMethod eq 'KAKAO'}) {
        if (pathIncludes === true) {
          $profileImage.setAttribute("src", "/display${memberInfo.profile}");
        } else {
          $profileImage.setAttribute("src", "${memberInfo.profile}");
        }
      } else if (${memberInfo.loginMethod eq 'COMMON'}) {
        $profileImage.setAttribute("src", "/display${memberInfo.profile}");
      } else {
        $profileImage.setAttribute("src", "/assets/img/anonymous-image.png");
      }
    } )( );
  </script>

</body>

</html>