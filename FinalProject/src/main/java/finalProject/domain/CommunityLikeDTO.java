package finalProject.domain;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Alias("communityLike")
@Data
public class CommunityLikeDTO {
    private String targetType;  // 좋아요 대상 타입 (예: 'COMMUNITY')
    private Long targetId;      // 좋아요 대상 ID (게시글 번호)
    private String memberNum;   // 좋아요 누른 회원 번호
}
