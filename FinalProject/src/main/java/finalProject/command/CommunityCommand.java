package finalProject.command;

import org.springframework.web.multipart.MultipartFile;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class CommunityCommand {

    @NotBlank(message = "제목을 입력해주세요")
    private String commuSubject;

    @NotEmpty(message = "내용을 입력해주세요")
    private String commuContents;

    // 단일 이미지 파일 업로드
    private MultipartFile commuImageFile;


    private MultipartFile commuFile;
    // 파일 이름 관련 필드
    private String commuImageOriginalName;
    private String commuImageStoreName;
    private String commuOriginalName;
    private String commuStoreName;
    
    // 작성자 정보
    private String memberNum;
    private String employeeNum;
    private String writerName;

    private Integer boardNum; 

}
