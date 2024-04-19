package com.ohnal.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

@Configuration
public class AfterLoginInterceptor implements HandlerInterceptor {
    // 로그인 한 이후 회원만 접근할 수 있는 페이지

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 클라이언트로부터 요청이 들어왔고, 디스패처 서블릿이 컨트롤러에게 전달하지 않고, 프리핸들러가 처리한다.
        // 세션받아오기
        HttpSession session = request.getSession();

        // 세션 데이터 중 login이라는 이름의 데이터가 있는지 확인한 후에
        // 만약 존재한다면 요청이 컨트롤러로 들어가지 못하게 하겠다.
        if(session.getAttribute("login") != null) {
            response.sendRedirect("/index");
            return false; // 컨트롤러로 들어가는 요청을 막음
        }

        return true; // 로그인 안했으면 컨트롤러로 요청이 들어간다.


    }
}
