package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.command.MemberCommand;
import finalProject.service.MemberAutoNumService;
import finalProject.service.MemberWriteService;

@Controller
@RequestMapping("/member")

public class MemberController {
	@Autowired
	MemberWriteService memberWriteService;
	@Autowired
	MemberAutoNumService memberAutoNumService;
	
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
	
	
}



