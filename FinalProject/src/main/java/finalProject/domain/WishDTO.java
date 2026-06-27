package finalProject.domain;

import java.util.Date;

public class WishDTO {
    private String wishNum;
    private String companyNum;
    private String memberNum;
    private Date wishDate;

    private String companyName; // JOIN용 (기업명 출력용)

    // Getters and Setters
    public String getWishNum() {
        return wishNum;
    }

    public void setWishNum(String wishNum) {
        this.wishNum = wishNum;
    }

    public String getCompanyNum() {
        return companyNum;
    }

    public void setCompanyNum(String companyNum) {
        this.companyNum = companyNum;
    }

    public String getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(String memberNum) {
        this.memberNum = memberNum;
    }

    public Date getWishDate() {
        return wishDate;
    }

    public void setWishDate(Date wishDate) {
        this.wishDate = wishDate;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
}
