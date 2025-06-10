package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import finalProject.model.NewsArticle;
import finalProject.service.NewsCrawlerService;

@Controller
public class NewsController {

    @Autowired
    private NewsCrawlerService newsCrawlerService;

    @GetMapping("/news/crawled")
    public String showNews(Model model) {
        List<NewsArticle> newsList = newsCrawlerService.getLatestNews();
        model.addAttribute("newsList", newsList);
        return "news/newsMain";
    }
}
