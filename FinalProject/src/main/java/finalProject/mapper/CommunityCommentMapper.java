package finalProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.CommunityCommentDTO;

@Mapper
public interface CommunityCommentMapper {

    // 댓글 (및 대댓글) 등록 - parentCommentNum이 null이면 일반댓글, 값이 있으면 대댓글
    void insertComment(CommunityCommentDTO dto);
    
    CommunityCommentDTO selectCommentByCommentNum(int commentNum);


    // 게시글 번호(commuNum) 기준 댓글 + 대댓글 목록 조회
    List<CommunityCommentDTO> selectCommentsByCommuNum(@Param("commuNum") int commuNum);

    // 댓글 수정
    void updateComment(CommunityCommentDTO dto);

    // 댓글 삭제
    void deleteComment(int commentNum);
    
    CommunityCommentDTO selectCommentByNum(int commentNum);
    
    // 대댓글 수정
    void updateReply(CommunityCommentDTO dto);

}
