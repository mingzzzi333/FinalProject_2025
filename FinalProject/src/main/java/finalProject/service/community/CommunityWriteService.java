package finalProject.service.community;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import finalProject.command.CommunityCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CommunityDTO;
import finalProject.mapper.CommunityMapper;
import jakarta.servlet.http.HttpSession;

@Service
public class CommunityWriteService {

    @Autowired
    private CommunityMapper communityMapper;

    public void execute(CommunityCommand command, CommunityDTO dto, HttpSession session) {
        // 로그인 사용자 정보 가져오기
        Object auth = session.getAttribute("authInfo");
        if (auth instanceof AuthInfoDTO authInfo) {
            dto.setWriterName(authInfo.getUserName());

            if ("mem".equalsIgnoreCase(authInfo.getGrade())) {
                dto.setMemberNum(authInfo.getUserNum());
            } else if ("emp".equalsIgnoreCase(authInfo.getGrade())) {
                dto.setEmployeeNum(authInfo.getUserNum());
            }
        }

        // 게시판 번호 세팅
        dto.setBoardNum(command.getBoardNum());

        // 이미지 업로드 처리
        MultipartFile file = command.getCommuImageFile();
        if (file != null && !file.isEmpty()) {
            String originalName = file.getOriginalFilename(); 
            String storedName = UUID.randomUUID().toString() + "_" + originalName;

            File uploadPath = new File("C:/upload/", storedName);
            try {
                file.transferTo(uploadPath);

                dto.setCommuImageOriginalName(originalName);
                dto.setCommuImageStoreName(storedName);

                // --- 디버깅 출력 ---
                System.out.println("원본 이미지명: " + originalName);
                System.out.println("저장 이미지명: " + storedName);
                System.out.println("DTO 저장 이미지명: " + dto.getCommuImageStoreName());

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 제목, 내용 설정
        dto.setCommuSubject(command.getCommuSubject());
        dto.setCommuContents(command.getCommuContents());

        // DB 저장
        communityMapper.insertCommunity(dto);
    }

    public void update(CommunityCommand command, int commuNum, HttpSession session) {
        CommunityDTO dto = new CommunityDTO();
        dto.setCommuNum(commuNum);
        dto.setCommuSubject(command.getCommuSubject());
        dto.setCommuContents(command.getCommuContents());

        Object loginInfo = session.getAttribute("authInfo");
        if (loginInfo instanceof AuthInfoDTO authInfo) {
            dto.setCommuWriter(authInfo.getUserName());
        }

        String uploadDir = "C:/upload/";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        MultipartFile image = command.getCommuImageFile();
        if (image != null && !image.isEmpty()) {
            String originalImg = image.getOriginalFilename();
            String storedImg = UUID.randomUUID().toString() + "_" + originalImg;
            try {
                image.transferTo(new File(uploadDir + storedImg));
                // 새 이미지 정보 DTO에 세팅
                dto.setCommuImageOriginalName(originalImg);
                dto.setCommuImageStoreName(storedImg);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 새 이미지 없으면 기존 이미지 정보 유지
            CommunityDTO existing = communityMapper.selectCommunityById(commuNum);
            dto.setCommuImageOriginalName(existing.getCommuImageOriginalName());
            dto.setCommuImageStoreName(existing.getCommuImageStoreName());
        }

        // 디버깅 출력
        System.out.println("Update DTO: " + dto);

        // DB 업데이트 호출
        communityMapper.updateCommunity(dto);
    }

    public void delete(int commuNum) {
        communityMapper.deleteCommunity(commuNum);
    }
}
