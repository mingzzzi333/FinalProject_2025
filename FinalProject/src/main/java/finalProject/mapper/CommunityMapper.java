package finalProject.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import finalProject.domain.CommunityDTO;

@Mapper
public interface CommunityMapper {

    // 커뮤니티 글 등록
    void insertCommunity(CommunityDTO communityDTO);

    // 글 수정
    void updateCommunity(CommunityDTO dto);

    // 글 삭제
    void deleteCommunity(@Param("commuNum") int commuNum);

    // 조회수 증가
    void updateViews(@Param("commuNum") int commuNum);

    // 좋아요 여부 확인
    int hasUserLiked(@Param("targetType") String targetType, 
            @Param("targetId") long targetId, 
            @Param("memberNum") String memberNum);

    // 좋아요 등록
    void insertLike(@Param("targetType") String targetType, 
                    @Param("targetId") long targetId, 
                    @Param("memberNum") String memberNum);

    // 좋아요 취소
    void deleteLike(@Param("targetType") String targetType, 
                    @Param("targetId") long targetId, 
                    @Param("memberNum") String memberNum);

    // 좋아요 수 카운트
    int countLikes(@Param("targetType") String targetType, 
                   @Param("targetId") long targetId);

    // 좋아요 수 업데이트
    void updateCommunityLikeCount(@Param("commuGood") int likeCount, 
                                  @Param("commuNum") long commuNum);
    
    List<CommunityDTO> selectAll();
    CommunityDTO selectPostById(@Param("commuNum") int commuNum);


    // 게시글 목록 조회
    List<CommunityDTO> selectByBoardNum(@Param("boardNum") Integer boardNum);

    // 게시글 상세 조회
    CommunityDTO selectCommunityById(int commuNum);
    
    List<CommunityDTO> selectTop5ByLikes();


}
