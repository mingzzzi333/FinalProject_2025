package finalProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	//관리하기 페이지로 이동
    @GetMapping("/adminMain")
    public String empManager() {
        return "employee/adminMain";
    }
    
    @GetMapping("/admin/communityAdmin")
    public String communityAdmin() {
        return "community/communityAdmin";
    }
}