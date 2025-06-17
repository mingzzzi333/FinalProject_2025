package finalProject.service.communitycomment;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityCommentDTO;
import finalProject.mapper.CommunityCommentMapper;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class CommunityCommentInsertService {

    @Autowired
    CommunityCommentMapper commentMapper;

    public void insertComment(CommunityCommentDTO dto, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("authInfo");

        System.out.println("🔍 [댓글 등록] 로그인 정보: " + auth);

        if (auth != null) {
            String userGrade = auth.getGrade();
            System.out.println("📌 로그인 등급: " + userGrade);

            if ("mem".equalsIgnoreCase(userGrade)) {
                // 작성자 정보 세팅
                dto.setMemberNum(auth.getUserNum());
                dto.setMemberName(auth.getUserName());
                dto.setCommentDate(new Date());

                // 로그 출력
                System.out.println("✅ 댓글 작성 시도");
                System.out.println("→ 게시글 번호: " + dto.getCommuNum());
                System.out.println("→ 댓글 내용: " + dto.getCommentContents());
                System.out.println("→ 작성자 번호: " + dto.getMemberNum());
                System.out.println("→ 작성자 이름: " + dto.getMemberName());

                // 대댓글 여부 판단
                if (dto.getParentCommentNum() != null) {
                    System.out.println("→ 🧷 대댓글 작성 (부모 댓글 번호: " + dto.getParentCommentNum() + ")");
                } else {
                    System.out.println("→ 📝 일반 댓글 작성");
                }

                // DB 등록
                commentMapper.insertComment(dto);
            } else {
                System.out.println("❌ 댓글 작성 실패 - 권한 부족 (grade=" + userGrade + ")");
            }
        } else {
            System.out.println("❌ 댓글 작성 실패 - 로그인 정보 없음 (세션 null)");
        }
    }
}
