package finalProject.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {
	String memberNum;
	String memberId;
	String memberPw;
	String memberName;
	String memberPhone;
	String memberEmail;
	String memberBirth;
	String memberGender;
	String memberAddr;
	String memberDetailAddr;
	int memberPost;
	MultipartFile memberImgFile; // ✅ 업로드된 파일을 받는 필드

    // DB에 저장할 파일명
    String memberImg; // ✅ 저장된 파일 이름 (ex: UUID_원본파일명)
    
}
