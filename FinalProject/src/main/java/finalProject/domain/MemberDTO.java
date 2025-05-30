package finalProject.domain;

import java.util.Date;

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
	String memberImg;
}
