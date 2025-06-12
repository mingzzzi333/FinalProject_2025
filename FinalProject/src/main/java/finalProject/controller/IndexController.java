package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.BoardDTO;
import finalProject.mapper.BoardMapper;
import finalProject.model.NewsArticle;
import finalProject.service.NewsCrawlerService;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {
	@Autowired
	NewsCrawlerService newsCrawlerService;
	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/")
    public String index(Model model) {
        List<NewsArticle> newsList = newsCrawlerService.getAllNews();
        model.addAttribute("newsList", newsList);
        return "index";
    }

	//로그인 창으로 이동
	@GetMapping("/login")
    public String loginPage() {
        return "login/login"; 
    }
	
    // 일반 회원 로그인 성공 시 이동
    @GetMapping("/index")
    public String userMain(Model model) {
        List<NewsArticle> newsList = newsCrawlerService.getAllNews();
        int maxSize = Math.min(newsList.size(), 10);
        model.addAttribute("newsList", newsList.subList(0, maxSize));
        return "index"; 
    }


    // 관리자 로그인 성공 시 이동
    @GetMapping("/admin")
    public String adminMain(HttpSession session, Model model) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
        if (authInfo != null && "emp".equals(authInfo.getGrade())) {
            model.addAttribute("empNum", authInfo.getUserNum());
        }
        return "index"; 
    }
    
  //홈으로 이동
    @GetMapping("/home")
    public String home(Model model) {
        List<NewsArticle> newsList = newsCrawlerService.getAllNews();

        // 최대 10개까지만 보여주기
        int maxSize = Math.min(newsList.size(), 10);
        model.addAttribute("newsList", newsList.subList(0, maxSize));

        return "index"; 
    }
	//토론장으로 이동
    @GetMapping("/communityMain")  // 또는 "/home", "/community" 등
    public String communityMain(Model model) {
        List<BoardDTO> boardList = boardMapper.selectAllBoards();  // 전체 게시판 목록
        model.addAttribute("boardList", boardList);
        return "community/communityAll";  // 이 JSP가 네가 보여주고 싶은 페이지
    }

	
	//뉴스로 이동
	 @GetMapping("/news")
	 public String newsRedirect() {
	    return "redirect:/news/crawled";
	 }
	
	//주식정보로 이동
	@GetMapping("/stock")
	public String stockPage() {
		return "stock/stockMain";
	}	
	
}
