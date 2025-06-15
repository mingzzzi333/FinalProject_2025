package finalProject.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import finalProject.domain.MemberDTO;
import finalProject.mapper.MemberMapper;

@Service
public class MemberUpdateService {

    @Autowired
    MemberMapper memberMapper;

    public void execute(MemberDTO memberDTO) {
        MultipartFile file = memberDTO.getMemberImgFile();

        if (file != null && !file.isEmpty()) {
            // 파일 저장
            String originalFilename = file.getOriginalFilename();
            String newFilename = UUID.randomUUID().toString() + "_" + originalFilename;

            File dest = new File("C:/upload/" + newFilename);
            try {
                file.transferTo(dest);
                memberDTO.setMemberImg(newFilename); // 새 파일명 저장
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 비밀번호가 입력된 경우에만 수정
        if (memberDTO.getMemberPw() != null && !memberDTO.getMemberPw().isEmpty()) {
            // 그대로 사용하거나, 필요하면 암호화 처리 가능
        } else {
            // 비밀번호 미입력 시 null로 설정해서 updateMember에서 무시하게 할 수도 있음
            memberDTO.setMemberPw(null); // 또는 기존 비밀번호 유지
        }

        // DB 수정 실행
        memberMapper.updateMember(memberDTO);
    }
}
