package finalProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	@RequestMapping("/")
	public String index() {
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
        return "index"; // => /WEB-INF/views/index.jsp
    }

    // 관리자 로그인 성공 시 이동
    @GetMapping("/admin")
    public String adminMain() {
        return "adminMain"; // => /WEB-INF/views/adminMain.jsp
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
	public String newsPage() {
		 return "news/newsMain";
	}
	
	//주식정보로 이동
	@GetMapping("/stock")
	public String stockPage() {
		return "stock/stockMain";
	}	
		
}
