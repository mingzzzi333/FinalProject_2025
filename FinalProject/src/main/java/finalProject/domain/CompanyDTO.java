package finalProject.domain;

import java.sql.Date;

public class CompanyDTO {

    private String companyNum;    // DB의 COMPANY_NUM
    private String companyName;    // DB의 COMPANY_NAME

    private String companyType;    // 업종명 (industryMap으로 매핑한 값)
    private String companyCeoName; // 대표자명

    private Date companyYear;      // 설립일
    private Date companyListDate;  // 상장일

    private Integer companyTotalShares;  // 총 발행주식수
    private Long companyMarketCap;      // 시가총액 = 주가 * 총주식수

    private String companyContent; // 상장구분 (Y: 유가증권, K: 코스닥, N: 코넥스)

    private String employeeNum;   // 등록자(또는 관리자) 사번
    private String establishDate; // 설립일 (원본 문자열 형태 – 필요 없으면 삭제 가능)

    private String industry;      // 업종코드 원본 문자열 (industryCode)

    // Getter와 Setter 메서드

    public String getCompanyNum() {
        return companyNum;
    }

    public void setCompanyNum(String companyNum) {
        this.companyNum = companyNum;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyType() {
        return companyType;
    }

    public void setCompanyType(String companyType) {
        this.companyType = companyType;
    }

    public String getCompanyCeoName() {
        return companyCeoName;
    }

    public void setCompanyCeoName(String companyCeoName) {
        this.companyCeoName = companyCeoName;
    }

    public Date getCompanyYear() {
        return companyYear;
    }

    public void setCompanyYear(Date companyYear) {
        this.companyYear = companyYear;
    }

    public Date getCompanyListDate() {
        return companyListDate;
    }

    public void setCompanyListDate(Date companyListDate) {
        this.companyListDate = companyListDate;
    }

    public Integer getCompanyTotalShares() {
        return companyTotalShares;
    }

    public void setCompanyTotalShares(Integer companyTotalShares) {
        this.companyTotalShares = companyTotalShares;
    }

    public Long getCompanyMarketCap() {
        return companyMarketCap;
    }

    public void setCompanyMarketCap(Long companyMarketCap) {
        this.companyMarketCap = companyMarketCap;
    }

    public String getCompanyContent() {
        return companyContent;
    }

    public void setCompanyContent(String companyContent) {
        this.companyContent = companyContent;
    }

    public String getEmployeeNum() {
        return employeeNum;
    }

    public void setEmployeeNum(String employeeNum) {
        this.employeeNum = employeeNum;
    }

    public String getEstablishDate() {
        return establishDate;
    }

    public void setEstablishDate(String establishDate) {
        this.establishDate = establishDate;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }
}
