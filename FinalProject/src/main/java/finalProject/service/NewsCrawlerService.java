package finalProject.service;

import finalProject.model.NewsArticle;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class NewsCrawlerService {

    private static final String URL = "https://www.hankyung.com/economy";

    public List<NewsArticle> getLatestNews() {
        List<NewsArticle> newsList = new ArrayList<>();

        try {
            Document doc = Jsoup.connect(URL)
                                .userAgent("Mozilla/5.0")
                                .get();

            Elements articleBlocks = doc.select("div.news-item");

            int count = 0;
            for (Element article : articleBlocks) {
                if (count >= 5) break;  // 최신 5개만 크롤링

                Element aTag = article.selectFirst("h2.news-tit a");
                Element imgTag = article.selectFirst("img");

                if (aTag != null) {
                    String title = aTag.text();
                    String link = aTag.absUrl("href");
                    String imageUrl = (imgTag != null) ? imgTag.absUrl("src") : "";

                    newsList.add(new NewsArticle(title, link, imageUrl));
                    count++;
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("크롤링된 뉴스 개수: " + newsList.size());
        return newsList;
    }
}
