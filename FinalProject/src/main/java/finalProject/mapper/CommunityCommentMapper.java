package finalProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityCommentDTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface CommunityCommentMapper {
	@Component
	public class AutoLoginInterceptor implements HandlerInterceptor {
	    @Autowired LoginMapper loginMapper;

	    @Override
	    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) {
	        HttpSession session = req.getSession();
	        if (session.getAttribute("authInfo") == null) {
	            Cookie[] cookies = req.getCookies();
	            if (cookies != null) {
	                for (Cookie c : cookies) {
	                    if ("autoLogin".equals(c.getName()) && c.getValue() != null && !c.getValue().isEmpty()) {
	                        AuthInfoDTO auth = loginMapper.loginSelectOne(c.getValue());
	                        if (auth != null) session.setAttribute("authInfo", auth);
	                        break;
	                    }
	                }
	            }
	        }
	        return true;
	    }
	}

	 // 댓글 등록
    void insertComment(CommunityCommentDTO dto);

    // 댓글 목록 조회
    List<CommunityCommentDTO> selectCommentsByCommuNum(@Param("commuNum") int commuNum);

    void updateComment(CommunityCommentDTO dto);
    void deleteComment(int commentNum);
}
