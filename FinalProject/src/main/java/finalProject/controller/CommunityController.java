package finalProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import finalProject.command.CommunityCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityCommentDTO;
import finalProject.domain.CommunityDTO;
import finalProject.mapper.CommunityCommentMapper;
import finalProject.service.community.CommunityLikeService;
import finalProject.service.community.CommunityListService;
import finalProject.service.community.CommunityWriteService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityWriteService communityWriteService;

    @Autowired
    private CommunityListService communityListService;

    @Autowired
    private CommunityLikeService communityLikeService;

    @Autowired
    private CommunityCommentMapper commentMapper;

    // 글 목록
    @GetMapping("/list")
    public String list(@RequestParam("boardNum") Integer boardNum, Model model) {
        List<CommunityDTO> list = communityListService.getListByBoardNum(boardNum);
        model.addAttribute("list", list);
        model.addAttribute("boardNum", boardNum);
        return "community/communityList";
    }

    // 글쓰기 폼
    @GetMapping("/write")
    public String writeForm(@RequestParam("boardNum") Integer boardNum, Model model, HttpSession session) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
        if (authInfo == null) return "redirect:/login";

        model.addAttribute("boardNum", boardNum);
        model.addAttribute("memNum", authInfo.getUserId());
        model.addAttribute("memName", authInfo.getUserName());
        return "community/communityForm";
    }

    // 글쓰기 처리
    @PostMapping("/write")
    public String write(
            @RequestParam("boardNum") Integer boardNum,
            @RequestParam("memNum") String memNum,
            @RequestParam("memName") String memName,
            @RequestParam("commuSubject") String subject,
            @RequestParam("commuContents") String contents,
            @RequestParam(value = "commuImageFile", required = false) MultipartFile commuImageFile,
            HttpSession session) {

        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
        if (authInfo == null) return "redirect:/login";

        CommunityCommand command = new CommunityCommand();
        command.setBoardNum(boardNum);
        command.setCommuSubject(subject);
        command.setCommuContents(contents);
        command.setCommuImageFile(commuImageFile);

        CommunityDTO dto = new CommunityDTO();
        communityWriteService.execute(command, dto, session);

        return "redirect:/community/list?boardNum=" + boardNum;
    }

    // 상세보기
    @GetMapping("/detail")
    public String communityDetail(@RequestParam("commuNum") int commuNum,
                                  @RequestParam(value = "boardNum", required = false) Integer boardNum,
                                  Model model) {

        communityListService.incrementViews(commuNum);
        model.addAttribute("commu", communityListService.getCommunityById(commuNum));
        model.addAttribute("boardNum", boardNum);

        List<CommunityCommentDTO> commentList = commentMapper.selectCommentsByCommuNum(commuNum);
        model.addAttribute("commentList", commentList);

        return "community/communityDetail";
    }

    // 좋아요 토글
    @PostMapping("/good/ajax/{commuNum}")
    @ResponseBody
    public Map<String, Object> togglePostLike(@PathVariable("commuNum") int commuNum,
                                              HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");

        if (authInfo == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        try {
            String memberNum = authInfo.getUserNum();
            return communityLikeService.toggleLike("COMMUNITY", commuNum, memberNum);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "좋아요 처리 중 오류가 발생했습니다.");
            return result;
        }
    }

    // 좋아요 상태 조회
    @GetMapping("/like/status/{commuNum}")
    @ResponseBody
    public Map<String, Object> getLikeStatus(@PathVariable("commuNum") int commuNum,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");

        try {
            int likeCount = communityLikeService.getLikeCount("COMMUNITY", commuNum);

            if (authInfo == null) {
                result.put("success", false);
                result.put("isLiked", false);
                result.put("likeCount", likeCount);
                return result;
            }

            String memberNum = authInfo.getUserNum();
            boolean isLiked = communityLikeService.isUserLiked("COMMUNITY", commuNum, memberNum);

            result.put("success", true);
            result.put("isLiked", isLiked);
            result.put("likeCount", likeCount);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상태 조회 중 오류 발생");
        }

        return result;
    }

    // 수정 폼
    @GetMapping("/edit/{commuNum}")
    public String editForm(@PathVariable("commuNum") int commuNum, Model model) {
        model.addAttribute("commu", communityListService.getCommunityById(commuNum));
        return "community/communityEdit";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(@ModelAttribute CommunityCommand communityCommand,
                         @RequestParam("commuNum") int commuNum,
                         HttpSession session) {
        communityWriteService.update(communityCommand, commuNum, session);
        return "redirect:/community/detail?commuNum=" + commuNum;
    }

    // 삭제 처리
    @PostMapping("/delete")
    public String delete(@RequestParam("commuNum") int commuNum,
                         @RequestParam("boardNum") Integer boardNum) {
        communityWriteService.delete(commuNum);
        return "redirect:/community/list?boardNum=" + boardNum;
    }
    
    
    
}
