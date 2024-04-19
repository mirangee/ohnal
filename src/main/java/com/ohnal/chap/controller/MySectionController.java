package com.ohnal.chap.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
public class MySectionController {

    @GetMapping("/members/my-info")
    public String myPage() {
        return "chap/my-info";
    }

    @PostMapping("/members/modify-info")
    public String modifyInfo() {
        log.info("modify info");
        return "redirect:/index";
    }
}
