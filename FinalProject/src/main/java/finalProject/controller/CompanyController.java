package finalProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CompanyController {
	//기업 상세보기로 이동
    @GetMapping("/company")
    public String homePage() {
    	return "company/companyDetail";
    }
}
