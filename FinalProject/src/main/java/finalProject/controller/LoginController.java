package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import finalProject.command.LoginCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.service.LoginService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    LoginService loginService;

    @PostMapping("/loginAction")
    public String login(LoginCommand cmd,
                        @RequestParam(value="autoLogin", required=false) String autoLogin,
                        @RequestParam(value="idStore", required=false) String idStore,
                        HttpSession session, HttpServletResponse response,
                        Model model) {
        AuthInfoDTO authInfo = loginService.execute(cmd);
        if (authInfo != null) {
            session.setAttribute("authInfo", authInfo);

            // ① 자동 로그인 쿠키 설정/삭제
            if (autoLogin != null) {
                Cookie alc = new Cookie("autoLogin", authInfo.getUserId());
                alc.setPath("/");
                alc.setMaxAge(60*60*24*7);
                response.addCookie(alc);
            } else {
                Cookie al = new Cookie("autoLogin", "");
                al.setPath("/");
                al.setMaxAge(0);
                response.addCookie(al);
            }

            // ② 아이디 저장 쿠키 설정/삭제
            if (idStore != null) {
                Cookie idc = new Cookie("idStore", cmd.getUserId());
                idc.setPath("/");
                idc.setMaxAge(60*60*24*30);
                response.addCookie(idc);
            } else {
                Cookie idc = new Cookie("idStore", "");
                idc.setPath("/");
                idc.setMaxAge(0);
                response.addCookie(idc);
            }

            return "redirect:/index";
        }

        model.addAttribute("errorMessage", "로그인 정보가 올바르지 않습니다.");
        return "login/login";
    }

    
    
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        session.invalidate();
        Cookie al = new Cookie("autoLogin", "");
        al.setPath("/");
        al.setMaxAge(0);
        response.addCookie(al);
        return "redirect:/index";
    }

}