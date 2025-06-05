package finalProject.command;

import lombok.Data;

@Data
public class EmployeeCommand {
     String empNum;
     String empId;
     String empPw;
     String empName;
     String empPhone;
     String empEmail;
     String empBirth;       // 날짜는 나중에 LocalDate로 바꿔도 됨
     String empAddr;
     String empDetailAddr;
     String empPost;  
     String empImg;
     String empGender;
     String empHireDate;    // 날짜도 추후 변경 가능
}
