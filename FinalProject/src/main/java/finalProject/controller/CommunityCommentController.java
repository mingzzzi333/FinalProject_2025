package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import finalProject.domain.CommunityCommentDTO;
import finalProject.service.communitycomment.CommunityCommentDeleteService;
import finalProject.service.communitycomment.CommunityCommentInsertService;
import finalProject.service.communitycomment.CommunityCommentUpdateService;
import jakarta.servlet.http.HttpSession;

@Controller
public class CommunityCommentController {

    @Autowired
    private CommunityCommentInsertService commentInsertService;

    @Autowired
    private CommunityCommentUpdateService commentUpdateService;

    @Autowired
    private CommunityCommentDeleteService commentDeleteService;

    // 댓글 등록 (일반 댓글 + 대댓글)
    @PostMapping("/community/commentInsert")
    public String insertReply(CommunityCommentDTO dto, HttpSession session) {
        commentInsertService.insertComment(dto, session);
        return "redirect:/community/detail/" + dto.getCommuNum();
    }

    // 댓글 수정
    @PostMapping("/community/commentUpdate")
    public String updateComment(CommunityCommentDTO dto, HttpSession session) {
        commentUpdateService.updateComment(dto, session);
        return "redirect:/community/detail/" + dto.getCommuNum();
    }

    // 댓글 삭제
    @PostMapping("/community/commentDelete")
    public String deleteComment(@RequestParam("commentNum") int commentNum,
                                @RequestParam("commuNum") int commuNum,
                                HttpSession session) {
        commentDeleteService.deleteComment(commentNum, session);
        return "redirect:/community/detail/" + commuNum;
    }
}
