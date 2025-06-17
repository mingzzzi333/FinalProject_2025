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

        // 커맨드에서 게시판 번호를 DTO에 세팅 (이게 핵심!)
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

            } catch (IOException e) {
                e.printStackTrace();
                // 필요하면 예외 처리 추가
            }
        }   
        

        // 제목, 내용 등 커맨드의 다른 데이터도 DTO에 세팅
        
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

        String uploadDir = "C:/upload/community/";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        MultipartFile image = command.getCommuImageFile();
        if (image != null && !image.isEmpty()) {
            String originalImg = image.getOriginalFilename();
            String storedImg = UUID.randomUUID().toString() + "_" + originalImg;
            try {
                image.transferTo(new File(uploadDir + storedImg));
                dto.setCommuImageOriginalName(originalImg);
                dto.setCommuImageStoreName(storedImg);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        communityMapper.updateCommunity(dto);
    }
    public void delete(int commuNum) {
        communityMapper.deleteCommunity(commuNum);
    }
    
}
