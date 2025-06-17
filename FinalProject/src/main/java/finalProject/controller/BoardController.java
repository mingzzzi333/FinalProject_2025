package finalProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {
	
	@GetMapping("/communityWrite")
    public String communityPage(@RequestParam(value = "companyNum", required = false) String companyNum,
                                 @RequestParam(value = "boardNum", required = false) String boardNum,
                                 Model model) {
        model.addAttribute("companyNum", companyNum);
        model.addAttribute("boardNum", boardNum); // 필요하다면 폼에서도 사용
        return "community/communityForm";
    }
}
