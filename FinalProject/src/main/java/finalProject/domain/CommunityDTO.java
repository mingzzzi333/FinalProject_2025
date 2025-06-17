package finalProject.domain;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Alias("commu")
@Data
public class CommunityDTO {
    private int commuNum;       
    private Integer boardNum;     
    private String employeeNum;
    private String memberNum;
    private String companyNum;
    private String companyName;
    
    private String commuWriter;

    private Date commuRegist;
    private Date commuUpdate;
    private String commuSubject;
    private String commuContents;

    private String commuOriginalName;
    private String commuStoreName;
    private String commuImageOriginalName;
    private String commuImageStoreName;
    

    private int commuViews;
    private int commuGood;

    
    private List<CommunityCommentDTO> comments;
    // 작성자 이름 (JOIN으로 가져온 값)
    private String writerName;
    
    private List<String> likedMemberNums;

    public List<String> getLikedMemberNums() {
        return likedMemberNums;
    }

    public void setLikedMemberNums(List<String> likedMemberNums) {
        this.likedMemberNums = likedMemberNums;
    }
}
