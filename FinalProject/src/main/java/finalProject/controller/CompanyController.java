package finalProject.controller;

import finalProject.domain.CompanyDTO;
import finalProject.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    CompanyService companyService;

    @GetMapping("/list")
    public String showCompanyList(@RequestParam(value = "keyword", required = false) String keyword,
                                  @RequestParam(value = "page", defaultValue = "1") int page,
                                  Model model) {

        int pageSize = 10;
        int pageGroupSize = 10;
        int offset = (page - 1) * pageSize;

        List<CompanyDTO> companyList;
        int totalCount;

        if (keyword != null && !keyword.trim().isEmpty()) {
            companyList = companyService.searchByCompanyNamePaged(keyword, offset, pageSize);
            totalCount = companyService.countByCompanyName(keyword);
        } else {
            companyList = companyService.getCompaniesPaged(offset, pageSize);
            totalCount = companyService.getTotalCompanyCount();
        }

        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // ✨ 페이징 그룹 계산
        int startPage = ((page - 1) / pageGroupSize) * pageGroupSize + 1;
        int endPage = startPage + pageGroupSize - 1;
        if (endPage > totalPages) {
            endPage = totalPages;
        }

        boolean hasPrev = startPage > 1;
        boolean hasNext = endPage < totalPages;

        model.addAttribute("companyList", companyList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrev", hasPrev);
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("keyword", keyword);

        return "company/companyList";
    }

    @GetMapping("/{companyNum}")
    public String showCompanyDetail(@PathVariable("companyNum") String companyNum, Model model) {
        CompanyDTO company = companyService.getCompanyByNum(companyNum);
        if (company == null) {
            return "redirect:/company/list";
        }
        model.addAttribute("company", company);
        return "company/companyDetail";
    }
}
