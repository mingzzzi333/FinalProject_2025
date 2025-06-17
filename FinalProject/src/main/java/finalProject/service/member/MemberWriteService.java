package finalProject.service.member;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import finalProject.command.MemberCommand;
import finalProject.domain.MemberDTO;
import finalProject.mapper.MemberMapper;

@Service
public class MemberWriteService {
	@Autowired
	MemberMapper memberMapper;
	
	public void execute(MemberCommand memberCommand) {
		memberCommand.setMemNum(memberCommand.getMemNum());
		MemberDTO dto = new MemberDTO();
		dto.setMemberAddr(memberCommand.getMemAddr());
		dto.setMemberBirth(memberCommand.getMemBirth());
		dto.setMemberDetailAddr(memberCommand.getMemDetailAddr());
		dto.setMemberEmail(memberCommand.getMemEmail());
		dto.setMemberGender(memberCommand.getMemGender());
		dto.setMemberId(memberCommand.getMemId());
		dto.setMemberName(memberCommand.getMemName());
		dto.setMemberNum(memberCommand.getMemNum());
		dto.setMemberPhone(memberCommand.getMemPhone());
		dto.setMemberPost(Integer.parseInt(memberCommand.getMemPost()));
		dto.setMemberPw(memberCommand.getMemPw());	
		// ⬇️ 파일 처리 추가
        MultipartFile file = memberCommand.getMemImg();
        if (file != null && !file.isEmpty()) {
            String originalFilename = file.getOriginalFilename();
            String storeFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            File saveFile = new File("C:/upload/", storeFilename); // 저장 경로 설정

            try {
                file.transferTo(saveFile);
                dto.setMemberImg(storeFilename); // ✅ 저장된 파일명만 DTO에 저장
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
		memberMapper.insertMember(dto);
	}
}
