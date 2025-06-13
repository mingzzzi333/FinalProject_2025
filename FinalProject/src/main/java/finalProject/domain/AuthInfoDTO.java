package finalProject.domain;

public class AuthInfoDTO {
    private String userId;
    private String userPw;
    private String userName;
    private String userEmail;
    private String grade;
    private String userNum; // 회원 or 직원 고유 번호

    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    public String getUserNum() { return userNum; }
    public void setUserNum(String userNum) { this.userNum = userNum; }
}
