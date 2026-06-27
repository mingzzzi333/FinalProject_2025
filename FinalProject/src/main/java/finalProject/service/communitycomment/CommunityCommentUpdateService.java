package finalProject.service.communitycomment;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityCommentDTO;
import finalProject.mapper.CommunityCommentMapper;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommunityCommentUpdateService {

    @Autowired
    private CommunityCommentMapper commentMapper;

    // 댓글 수정 처리
    public boolean updateComment(CommunityCommentDTO dto, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");

        if (auth == null) {
            System.out.println("❌ 댓글 수정 실패 - 로그인 정보 없음 (세션 null)");
            return false;
        }

        // 댓글 조회
        CommunityCommentDTO existingComment = commentMapper.selectCommentByCommentNum(dto.getCommentNum());
        if (existingComment == null) {
            System.out.println("❌ 댓글 수정 실패 - 해당 댓글 없음 (commentNum=" + dto.getCommentNum() + ")");
            return false;
        }

        // 작성자와 로그인 사용자 확인
        if (!auth.getUserNum().equals(existingComment.getMemberNum())) {
            System.out.println("❌ 댓글 수정 실패 - 작성자 불일치");
            return false;
        }

        // 댓글 내용 비어있는지 확인
        if (dto.getCommentContents() == null || dto.getCommentContents().trim().isEmpty()) {
            System.out.println("❌ 댓글 수정 실패 - 수정할 내용 없음");
            return false;
        }

        // 수정 수행
        commentMapper.updateComment(dto);
        System.out.println("✅ 댓글 수정 성공 (commentNum=" + dto.getCommentNum() + ")");
        return true;
    }

    // 댓글 조회 메서드 - 수정 폼에서 사용
    public CommunityCommentDTO getCommentByCommentNum(int commentNum) {
        return commentMapper.selectCommentByCommentNum(commentNum);
    }
}
