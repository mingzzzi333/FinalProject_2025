package finalProject.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import finalProject.command.MemberCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.domain.MemberDTO;
import finalProject.service.MemberAutoNumService;
import finalProject.service.MemberDetailService;
import finalProject.service.MemberUpdateService;
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
	@Autowired
	MemberUpdateService memberUpdateService;
	
	//자동부여
	@GetMapping("/memberWrite")
	public String write(Model model) {
		memberAutoNumService.execute(model);
		return "member/memberForm";
	}
	
	
	
	//회원가입
	@PostMapping("/memberWrite")
	public String write(MemberCommand memberCommand, @ModelAttribute MemberDTO memberDTO) {
		memberWriteService.execute(memberCommand);
		MultipartFile file = memberDTO.getMemberImgFile();
			    
			    if (!file.isEmpty()) {
			        String originalName = file.getOriginalFilename();
			        String storeName = UUID.randomUUID().toString() + "_" + originalName;
			        File dest = new File("C:/upload/" + storeName);
			        
			        try {
			            file.transferTo(dest);
			            memberDTO.setMemberImg(storeName); // DB에 저장할 파일명 설정
			        } catch (IOException e) {
			            e.printStackTrace();
			        }
			    }
		return "login/login";
	}
	
	//회원정보 상세보기
	@GetMapping("/myPage")
	   public String myPage(HttpSession session, Model model) {
	       AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
	       if (authInfo == null || !"mem".equals(authInfo.getGrade())) {
	           return "redirect:/login";
	       }
	       model.addAttribute("memberInfo", memberDetailService.getMemberInfo(authInfo.getUserNum()));
	       return "member/myPage"; 
	   }
	
	// 회원정보 수정 폼 보여주기
	@GetMapping("/memberEdit")
	public String memberEditForm(HttpSession session, Model model) {
	    AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
	    if (authInfo == null) {
	        return "redirect:/login";
	    }

	    // 회원정보 조회
	    MemberDTO dto = memberDetailService.getMemberInfo(authInfo.getUserNum());
	    model.addAttribute("memberInfo", dto);  // memberEdit.jsp로 전달
	    return "member/memberEdit";  // memberEdit.jsp 파일로 이동
	}

	// 회원정보 수정 처리
	@PostMapping("/memberUpdate")
	public String memberUpdate(@ModelAttribute MemberDTO memberDTO,
	                           HttpSession session,
	                           Model model) {
	    AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
	    if (authInfo == null) {
	        return "redirect:/login";
	    }

	    // 세션에 있는 회원번호로 고정
	    memberDTO.setMemberNum(authInfo.getUserNum());

	    // 수정 서비스 실행
	    memberUpdateService.execute(memberDTO);

	    return "redirect:/member/myPage";  // 수정 후 내 정보 페이지로 이동
	}

	
	
}



