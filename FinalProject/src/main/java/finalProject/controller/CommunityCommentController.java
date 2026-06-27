package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityCommentDTO;
import finalProject.service.communitycomment.CommunityCommentDeleteService;
import finalProject.service.communitycomment.CommunityCommentInsertService;
import finalProject.service.communitycomment.CommunityCommentUpdateService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community")
public class CommunityCommentController {

    @Autowired
    private CommunityCommentInsertService commentInsertService;

    @Autowired
    private CommunityCommentUpdateService commentUpdateService;

    @Autowired
    private CommunityCommentDeleteService commentDeleteService;

    // 댓글 등록 (일반 댓글 + 대댓글)
    @PostMapping("/commentInsert")
    public String insertComment(CommunityCommentDTO dto, HttpSession session) {
        commentInsertService.insertComment(dto, session);
        return getRedirectUrl(dto.getCommuNum());
    }

    // 댓글 수정 처리
    @PostMapping("/commentUpdate")
    public String updateComment(CommunityCommentDTO dto, HttpSession session, RedirectAttributes rttr) {
        boolean updated = commentUpdateService.updateComment(dto, session);
        if (!updated) {
            rttr.addFlashAttribute("errorMessage", "댓글 수정에 실패했습니다.");
        }
        return "redirect:/community/detail?commuNum=" + dto.getCommuNum();
    }

    // 댓글 삭제
    @PostMapping("/commentDelete")
    public String deleteComment(@RequestParam("commentNum") int commentNum,
                                @RequestParam("commuNum") int commuNum,
                                HttpSession session) {
        commentDeleteService.deleteComment(commentNum, session);
        return getRedirectUrl(commuNum);
    }

    // 대댓글 작성
    @PostMapping("/commentReplyWrite")
    public String commentReplyWrite(@RequestParam("commuNum") int commuNum,
            @RequestParam("parentCommentNum") Integer parentCommentNum,
            @RequestParam("memberNum") String memberNum,
            @RequestParam("commentContents") String commentContents,
            HttpSession session) {
        CommunityCommentDTO dto = new CommunityCommentDTO();
        dto.setCommuNum(commuNum);
        dto.setParentCommentNum(parentCommentNum);
        dto.setMemberNum(memberNum);
        dto.setCommentContents(commentContents);

        commentInsertService.insertComment(dto, session);

        return getRedirectUrl(commuNum);
    }

    // 댓글 수정 폼 보여주기
    @GetMapping("/commentEdit/{commentNum}")
    public String showCommentEditForm(@PathVariable("commentNum") int commentNum, Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");
        if (auth == null) {
            return "redirect:/login";  // 로그인 페이지로 리다이렉트하거나 적절히 처리
        }

        CommunityCommentDTO comment = commentUpdateService.getCommentByCommentNum(commentNum);
        if (comment == null) {
            return "redirect:/community/list"; // 댓글 없으면 목록으로
        }

        if (!auth.getUserNum().equals(comment.getMemberNum())) {
            return "redirect:/community/detail?commuNum=" + comment.getCommuNum(); // 작성자가 아니면 상세보기로
        }

        model.addAttribute("comment", comment);
        return "community/commentEditForm";  // 수정 폼 JSP 경로
    }

    private String getRedirectUrl(int commuNum) {
        return "redirect:/community/detail?commuNum=" + commuNum;
    }
}
