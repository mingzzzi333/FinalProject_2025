package finalProject.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import finalProject.model.NewsArticle;

@Service
public class NewsCrawlerService {

    private static final String URL = "https://www.hankyung.com/economy";

    public List<NewsArticle> getAllNews() {
        List<NewsArticle> newsList = new ArrayList<>();

        try {
            // 메인 뉴스 페이지 크롤링
            Document doc = Jsoup.connect(URL)
                                .userAgent("Mozilla/5.0")
                                .get();

            Elements articleBlocks = doc.select("div.news-item");

            for (Element article : articleBlocks) {
                Element aTag = article.selectFirst("h2.news-tit a");
                Element imgTag = article.selectFirst("img");

                if (aTag != null) {
                    String title = aTag.text();
                    String link = aTag.absUrl("href");
                    String imageUrl = (imgTag != null) ? imgTag.absUrl("src") : "";

                    // 🟨 기사 상세 페이지 접속해서 날짜 추출
                    String pubDate = "날짜없음";
                    try {
                        Document articleDoc = Jsoup.connect(link)
                                                   .userAgent("Mozilla/5.0")
                                                   .get();

                        Element dateMeta = articleDoc.selectFirst("meta[property=article:published_time]");
                        if (dateMeta != null) {
                            pubDate = dateMeta.attr("content"); // 예: "2025-06-10T08:00:04+09:00"
                        }
                    } catch (IOException e) {
                        e.printStackTrace();  // 개별 기사 오류는 전체 크롤링에 영향 X
                    }

                    newsList.add(new NewsArticle(title, link, imageUrl, pubDate));
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return newsList;
    }
}
