package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.InquiryDTO;
import finalProject.service.InquiryService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping
    public String showInquiries(Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");
        List<InquiryDTO> list = inquiryService.getInquiriesByMember(auth.getUserNum());
        model.addAttribute("inquiries", list);
        return "inquiry/inquiryList";
    }

    @PostMapping("/add")
    public String addInquiry(@ModelAttribute InquiryDTO dto, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");
        dto.setMemberNum(auth.getUserNum());
        inquiryService.insertInquiry(dto);
        return "redirect:/inquiry";
    }
}
