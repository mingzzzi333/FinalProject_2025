package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.domain.AuthInfoDTO;
import finalProject.model.NewsArticle;
import finalProject.service.NewsCrawlerService;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {
	@Autowired
	NewsCrawlerService newsCrawlerService;
	
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
    public String userMain() {
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
    public String homePage() {
    	return "index";
    }
    
	//토론장으로 이동
	@GetMapping("/community")
	public String communityPage() {
	    return "community/communityAll";
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
