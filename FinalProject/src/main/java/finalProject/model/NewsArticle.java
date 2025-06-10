package finalProject.model;

public class NewsArticle {
    private String title;
    private String link;
    private String imageUrl;  // 👈 이미지 URL 필드 추가

    // 생성자
    public NewsArticle(String title, String link, String imageUrl) {
        this.title = title;
        this.link = link;
        this.imageUrl = imageUrl;
    }

    // getter
    public String getTitle() {
        return title;
    }

    public String getLink() {
        return link;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    // setter
    public void setTitle(String title) {
        this.title = title;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
