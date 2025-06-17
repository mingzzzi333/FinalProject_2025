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
    CommunityCommentMapper commentMapper;

    public void updateComment(CommunityCommentDTO dto, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");

        if (auth != null && dto.getMemberNum() != null &&
            dto.getMemberNum().equals(auth.getUserNum())) {
            commentMapper.updateComment(dto);
        } else {
            System.out.println("❌ 댓글 수정 권한 없음 또는 memberNum 누락");
        }
    }
}
