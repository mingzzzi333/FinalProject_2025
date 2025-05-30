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
}
