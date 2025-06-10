package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.command.LoginCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.service.LoginService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    LoginService loginService;

    @PostMapping("/loginAction")
    public String login(LoginCommand loginCommand, HttpSession session) {
        AuthInfoDTO authInfo = loginService.execute(loginCommand);
        if (authInfo != null) {
            session.setAttribute("authInfo", authInfo);
            if ("mem".equals(authInfo.getGrade())) {
                return "redirect:/index"; // 일반 회원
            } else if ("emp".equals(authInfo.getGrade())) {
               return "redirect:/index"; // + authInfo.getUserNum(); // 관리자
            }
        }
        return "login/login"; // 로그인 실패
    }
    
    
    //로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 전부 초기화
        return "redirect:/index";
    }

}