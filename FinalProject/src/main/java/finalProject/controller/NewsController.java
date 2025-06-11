package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import finalProject.model.NewsArticle;
import finalProject.service.NewsCrawlerService;

@Controller
public class NewsController {

    @Autowired
    private NewsCrawlerService newsCrawlerService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/news/crawled")
    public String showNews(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
        List<NewsArticle> allNews = newsCrawlerService.getAllNews();
        int totalNews = allNews.size();
        int totalPages = (int) Math.ceil((double) totalNews / PAGE_SIZE);

        int start = (page - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalNews);
        List<NewsArticle> pageNews = allNews.subList(start, end);

        model.addAttribute("newsList", pageNews);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "news/newsMain";
    }
}
