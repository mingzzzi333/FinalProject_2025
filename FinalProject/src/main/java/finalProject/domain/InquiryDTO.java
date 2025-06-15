package finalProject.domain;

import java.util.Date;

import lombok.Data;

@Data
public class InquiryDTO {
    private String inquiryNum;
    private String memberNum;
    private String memberId;
    private String employeeNum;
    private String inquiryTitle;
    private String inquiryContent;
    private Date inquiryRegist;
    private String inquiryStatus;
    private String answerContent;
    private Date answerDate;  
}