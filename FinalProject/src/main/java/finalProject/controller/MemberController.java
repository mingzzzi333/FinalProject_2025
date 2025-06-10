package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.command.MemberCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.service.MemberAutoNumService;
import finalProject.service.MemberDetailService;
import finalProject.service.MemberWriteService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")

public class MemberController {
	@Autowired
	MemberWriteService memberWriteService;
	@Autowired
	MemberAutoNumService memberAutoNumService;
	@Autowired
	MemberDetailService memberDetailService;
	
	//자동부여
	@GetMapping("/memberWrite")
	public String write(Model model) {
		memberAutoNumService.execute(model);
		return "member/memberForm";
	}
	
	//회원가입
	@PostMapping("/memberWrite")
	public String write(MemberCommand memberCommand) {
		memberWriteService.execute(memberCommand);
		return "login/login";
	}
	
	//회원정보 상세보기
	@GetMapping("/myPage")
	public String info(HttpSession session, Model model) {
	    AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");
	    if (auth != null) {
	        String memberNum = auth.getUserNum(); // DTO에 따라 getMemberNum()일 수도 있음
	        memberDetailService.execute(model, memberNum);
	    }
	    return "member/memberDetail";
	}

	
	
}



