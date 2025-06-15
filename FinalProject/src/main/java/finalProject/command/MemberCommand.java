package finalProject.command;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberCommand {
   String memNum;
   String memId;
   String memPw;
   String memName;
   String memPhone;
   String memEmail;
   String memBirth;
   String memAddr;
   String memDetailAddr;
   String memPost;
   MultipartFile  memImg;
   
   String memGender;
}

