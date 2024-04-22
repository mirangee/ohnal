package com.ohnal.chap.controller;

import com.ohnal.chap.dto.request.ModifyRequestDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.service.MemberService;
import com.ohnal.util.FileUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import static com.ohnal.util.LoginUtils.getCurrentLoginMemberEmail;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MySectionController {
    private final MemberService memberService;

    @Value("${file.upload.root-path}")
    private String rootPath;

    @GetMapping("/members/my-info")
    public String myInfo(HttpSession session, Model model) {

        log.info("my-info 요청 들어옴!");
        String loginMemberEmail = getCurrentLoginMemberEmail(session);

        LoginUserResponseDTO memberInfo = memberService.getMemberInfo(loginMemberEmail);
        model.addAttribute("memberInfo", memberInfo);

        return "chap/my-info";
    }

    @PostMapping("/modify-info")
    public String modifyInfo(ModifyRequestDTO dto) {
        log.info("modify info 요청 들어옴!");
        log.info(dto.toString());

        if (!rootPath.contains("/profile")) {
            rootPath = rootPath + "/profile";
        }

        if (dto.getProfileImage() != null && dto.getPassword() != null) {  // 모든 정보 변경됨
            log.info("모든 정보 변경됨");
            String savePath = "/profile" + FileUtils.uploadFile(dto.getProfileImage(), rootPath);
//            memberService.modifyAll(dto, savePath);
        } else if(dto.getProfileImage() != null){ // 비번 변경 안 되고 프사 변경 됨
            log.info("비번 변경 안 되고 프사 변경 됨");
            String savePath = "/profile" + FileUtils.uploadFile(dto.getProfileImage(), rootPath);
//            memberService.modifyProfile(dto, savePath);
        } else if(dto.getPassword() != null){ // 비번 변경 되고 프사 변경 안 됨
            log.info("비번 변경 되고 프사 변경 안 됨");
//            memberService.modifyPw(dto);
        } else { // 비번, 프사 빼고 변경됨
            log.info("비번, 프사 빼고 변경됨");
//            memberService.modifyInfo(dto);
        }




        return "redirect:/members/sign-out";
    }
}
