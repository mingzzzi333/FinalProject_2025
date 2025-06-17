package finalProject.service.communitycomment;

import finalProject.domain.AuthInfoDTO;
import finalProject.mapper.CommunityCommentMapper;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommunityCommentDeleteService {

    @Autowired
    CommunityCommentMapper commentMapper;

    public void deleteComment(int commentNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");

        if (auth != null) {
            commentMapper.deleteComment(commentNum);
        }
    }
}
