package finalProject.model;

public class NewsArticle {
    private String title;
    private String link;
    private String imageUrl;
    private String pubDate;  // 🟨 추가된 날짜 필드

    public NewsArticle(String title, String link, String imageUrl, String pubDate) {
        this.title = title;
        this.link = link;
        this.imageUrl = imageUrl;
        this.pubDate = pubDate;
    }

    // Getter
    public String getTitle() { return title; }
    public String getLink() { return link; }
    public String getImageUrl() { return imageUrl; }
    public String getPubDate() { return pubDate; }

    // Setter
    public void setTitle(String title) { this.title = title; }
    public void setLink(String link) { this.link = link; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setPubDate(String pubDate) { this.pubDate = pubDate; }
}
