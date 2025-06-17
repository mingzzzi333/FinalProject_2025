package finalProject.service.community;

import finalProject.mapper.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class CommunityLikeService {

    @Autowired
    private CommunityMapper communityMapper;

    /**
     * 좋아요 토글 처리
     * 
     * @param targetType 좋아요 대상 타입 (예: "community")
     * @param targetId 대상 글 번호
     * @param memberNum 좋아요 누른 회원 번호
     * @return 토글 결과 정보 (성공 여부, 좋아요 상태, 좋아요 수)
     */
    @Transactional
    public Map<String, Object> toggleLike(String targetType, long targetId, String memberNum) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 1. 사용자가 이미 좋아요 했는지 확인
            boolean alreadyLiked = communityMapper.hasUserLiked(targetType, targetId, memberNum) > 0;

            // 2. 좋아요 토글 (이미 좋아요면 삭제, 아니면 추가)
            if (alreadyLiked) {
                communityMapper.deleteLike(targetType, targetId, memberNum);
            } else {
                communityMapper.insertLike(targetType, targetId, memberNum);
            }

            // 3. 최신 좋아요 개수 조회
            int likeCount = communityMapper.countLikes(targetType, targetId);

            // 4. COMMUNITY 테이블 좋아요 수 업데이트
            communityMapper.updateCommunityLikeCount(likeCount, (int) targetId);

            // 5. 결과 세팅
            result.put("success", true);
            result.put("isLiked", !alreadyLiked); // 토글 완료 후 상태
            result.put("likeCount", likeCount);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "좋아요 처리 중 오류가 발생했습니다.");
        }

        return result;
    }

    /**
     * 좋아요 수 조회
     */
    public int getLikeCount(String targetType, long targetId) {
        return communityMapper.countLikes(targetType, targetId);
    }

    /**
     * 사용자가 좋아요 했는지 여부 조회
     */
    public boolean isUserLiked(String targetType, long targetId, String memberNum) {
        return communityMapper.hasUserLiked(targetType, targetId, memberNum) > 0;
    }
}
