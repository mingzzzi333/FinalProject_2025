package finalProject.command;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class CommunityCommand {
	@NotBlank(message="제목을 입력해주세요")
	String commuSubject;
	@NotEmpty(message="내용을 입력해주세요")
	String commuContents;
	MultipartFile [] commuFile;
	MultipartFile commuImageFile;
}
