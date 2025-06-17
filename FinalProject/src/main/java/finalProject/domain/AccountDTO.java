package finalProject.domain;

import java.util.Date;

import lombok.Data;
@Data
public class AccountDTO {
    private String accountNum;
    private String memberNum;
    private String accountName;
    private Long accountCash;
    private Date accountDate;
    private String accountType;

}