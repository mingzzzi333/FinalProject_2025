package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.BoardDTO;
import finalProject.domain.CommunityDTO;
import finalProject.domain.CompanyDTO;
import finalProject.mapper.BoardMapper;
import finalProject.model.NewsArticle;
import finalProject.service.community.CommunityService;
import finalProject.service.company.CompanyService;
import finalProject.service.news.NewsCrawlerService;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {
	@Autowired
	NewsCrawlerService newsCrawlerService;
	@Autowired
	BoardMapper boardMapper;
	@Autowired
	CompanyService companyService;
	@Autowired
	CommunityService communityService;

	// 공통 데이터 설정 메서드
	private void setCommonIndexData(Model model) {
		List<NewsArticle> newsList = newsCrawlerService.getAllNews();
		int maxSize = Math.min(newsList.size(), 10);
		model.addAttribute("newsList", newsList.subList(0, maxSize));

		List<CompanyDTO> companies = companyService.getAllCompanies();
		model.addAttribute("companyList", companies);

		List<CommunityDTO> popularPosts = communityService.selectTop5ByLikes(); // 인기글
		model.addAttribute("list", popularPosts);
	}

	// index (비로그인)
	@RequestMapping("/")
	public String index(Model model) {
		setCommonIndexData(model);
		return "index";
	}

	// 로그인 창으로 이동
	@GetMapping("/login")
	public String loginPage() {
		return "login/login";
	}

	// 일반 회원 로그인 성공 시 이동
	@GetMapping("/index")
	public String userMain(Model model) {
		setCommonIndexData(model);
		return "index";
	}

	// 관리자 로그인 성공 시 이동
	@GetMapping("/admin")
	public String adminMain(HttpSession session, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
		if (authInfo != null && "emp".equals(authInfo.getGrade())) {
			model.addAttribute("empNum", authInfo.getUserNum());
		}
		setCommonIndexData(model);
		return "index";
	}

	// 홈으로 이동
	@GetMapping("/home")
	public String home(Model model) {
		setCommonIndexData(model);
		return "index";
	}

	// 토론장으로 이동
	@GetMapping("/communityMain")
	public String communityMain(Model model) {
		List<BoardDTO> boardList = boardMapper.selectAllBoards();
		model.addAttribute("boardList", boardList);
		return "community/communityAll";
	}

	// 뉴스로 이동
	@GetMapping("/news")
	public String newsRedirect() {
		return "redirect:/news/crawled";
	}

	// 기업 리스트 페이지
	@GetMapping("/stock")
	public String showCompanyList(@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

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
		int startPage = ((page - 1) / pageGroupSize) * pageGroupSize + 1;
		int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

		model.addAttribute("companyList", companyList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("hasPrev", startPage > 1);
		model.addAttribute("hasNext", endPage < totalPages);
		model.addAttribute("keyword", keyword);

		return "company/companyList";
	}
}
