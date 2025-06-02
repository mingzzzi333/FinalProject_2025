package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.command.CommunityCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityDTO;
import finalProject.mapper.CommunityMapper;
import jakarta.servlet.http.HttpSession;

@Service
public class CommunityWriteService {
	@Autowired
	CommunityMapper communityMapper;

	public void execute(CommunityCommand communityCommand, HttpSession session) {
		CommunityDTO dto = new CommunityDTO();
		dto.setCommuSubject(communityCommand.getCommuSubject());
		dto.setCommuContents(communityCommand.getCommuContents());

		// 기본값 설정
		dto.setBoardNum("1"); // 게시판 번호 고정
		dto.setCompanyNum("C001"); // 회사번호 기본값 (원하면 동적으로 변경 가능)

		// 로그인 사용자 정보 꺼내기
		Object loginInfo = session.getAttribute("authInfo");
		if (loginInfo instanceof AuthInfoDTO authInfo) {
			String grade = authInfo.getGrade(); // MEMBER / EMPLOYEE
			String userId = authInfo.getUserId();
			String userName = authInfo.getUserName();

			if ("MEMBER".equalsIgnoreCase(grade)) {
				dto.setMemberNum(userId);
			} else if ("EMPLOYEE".equalsIgnoreCase(grade)) {
				dto.setEmployeeNum(userId);
			}
			dto.setCommuWriter(userName);
		} else {
			throw new RuntimeException("로그인 정보가 없습니다.");
		}

		// 파일 업로드 없는 버전
		communityMapper.insertCommunity(dto);
	}
}
