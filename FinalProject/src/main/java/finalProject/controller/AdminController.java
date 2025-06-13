package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import finalProject.command.BoardCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.domain.BoardDTO;
import finalProject.mapper.BoardMapper;
import finalProject.service.BoardAutoNumService;
import finalProject.service.BoardWriteService;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	@Autowired
	BoardWriteService boardWriteService;
	@Autowired
	BoardAutoNumService boardAutoNumService;
	@Autowired
	BoardMapper boardMapper;
	
	//관리하기 페이지로 이동
    @GetMapping("/adminMain")
    public String empManager() {
        return "employee/adminMain";
    }
    
  //뉴스 관리 페이지
    @GetMapping("/admin/newsAdmin")
    public String commuManager() {
	    return "news/newsAdmin";
    }
    
    
    
    
    //커뮤니티 관리 페이지
    @GetMapping("/admin/communityAdmin")
    public String commuManager(HttpSession session, Model model) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
        if (authInfo != null && "emp".equals(authInfo.getGrade())) {

            // ✅ 로그인된 직원 번호 세션에서 가져옴
            String empNum = authInfo.getUserNum();
            model.addAttribute("empNum", empNum);

            // ✅ Mapper에서 employee_num 기준으로 게시판 리스트 불러옴
            List<BoardDTO> boardList = boardMapper.selectBoardsList(empNum);
            model.addAttribute("boardList", boardList);
        }
        return "community/communityAdmin";
    }

    //게시판 생성 + 자동부여
    @GetMapping("/admin/boardWrite")
    public String boardWrite(Model model) {
  		boardAutoNumService.execute(model);
        return "community/boardForm";
    }
    //게시판 작성
    @PostMapping("/boardWrite")
    public String commuManager(BoardCommand boardCommand) {
        boardWriteService.execute(boardCommand);
        return "community/communityAdmin";
    }
    
    
  	

}