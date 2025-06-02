package finalProject.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("commu")
@Data
public class CommunityDTO {
	String commuNum;            
	String boardNum;             
	String employeeNum;          
	String memberNum;            
	String companyNum;           
	String commuWriter;          
	String commuRegist;          // sysdate로 자동 입력
	String commuUpdate;          // sysdate로 자동 입력
	String commuSubject;         
	String commuContents;       
	String commuOriginalName;        // 첨부 파일 원본
	String commuStoreName;           // 첨부 파일 저장명
	String commuImageOriginalName;   // 이미지 파일 원본
	String commuImageStoreName;      // 이미지 파일 저장명
}
