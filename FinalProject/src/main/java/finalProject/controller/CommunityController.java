package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import finalProject.command.CommunityCommand;
import finalProject.service.CommunityWriteService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class CommunityController {
	@Autowired
	CommunityWriteService communityWriteService;
	
	//게시글로 이동
	@GetMapping("/communityWrite")
	public String communityPage() {
		return "community/communityForm";
	}
	
	//게시글등록
	@PostMapping("/communityInsert")
	public String write(@Valid CommunityCommand communityCommand,
	                    BindingResult result,
	                    HttpSession session) {
		if (result.hasErrors()) {
			System.out.println("글 작성 실패");
			return "community/communityForm"; // 유효성 실패 시 다시 폼으로 이동
		}
		communityWriteService.execute(communityCommand, session);
		System.out.println("글 작성 성공");
		return "community/communityAll"; // 성공 시 이동
	}
}
