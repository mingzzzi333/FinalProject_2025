package finalProject.controller;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.InquiryDTO;
import finalProject.service.InquiryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/inquiry")
public class AdminInquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("inquiries", inquiryService.getAllInquiries());
        return "admin/inquiryList";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam String inquiryNum, Model model) {
        model.addAttribute("inquiry", inquiryService.getInquiryByNum(inquiryNum));
        return "admin/inquiryDetail";
    }

    
    
    @PostMapping("/answer")
    public String answer(@ModelAttribute InquiryDTO dto, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");

        if (auth == null || !"emp".equals(auth.getGrade())) {
            System.out.println("❌ 관리자 권한 없음 또는 로그인 안됨");
            return "redirect:/login"; // 혹은 에러 페이지 연결
        }

        dto.setEmployeeNum(auth.getUserNum());
        inquiryService.updateAnswer(dto);
        return "redirect:/admin/inquiry/list";
    }
}
