package finalProject.domain;

import lombok.Data;
import org.apache.ibatis.type.Alias;
import java.util.Date;


@Data
@Alias("comment")
public class CommunityCommentDTO {
    private int commentNum;
    private int commuNum;
    private String memberNum;
    private String memberName;
    private String commentContents;
    private Date commentDate; 
    private Integer parentCommentNum;
}
