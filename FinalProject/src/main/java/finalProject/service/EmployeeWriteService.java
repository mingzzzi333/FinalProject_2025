package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.command.EmployeeCommand;
import finalProject.domain.EmployeeDTO;
import finalProject.mapper.EmployeeMapper;

@Service
public class EmployeeWriteService {

    @Autowired
    EmployeeMapper employeeMapper;

    public void execute(EmployeeCommand command) {
        EmployeeDTO dto = new EmployeeDTO();

        dto.setEmployeeNum(command.getEmpNum());
        dto.setEmployeeId(command.getEmpId());
        dto.setEmployeePw(command.getEmpPw());
        dto.setEmployeeName(command.getEmpName());
        dto.setEmployeeBirth(command.getEmpBirth());
        dto.setEmployeeAddr(command.getEmpAddr());

        // ✅ 여기 진짜 핵심: 빈 문자열 방지
        if (command.getEmpPost() != null && !command.getEmpPost().isEmpty()) {
            dto.setEmployeePost(Integer.valueOf(command.getEmpPost()));
        } else {
            dto.setEmployeePost(null);
        }

        dto.setEmployeePhone(command.getEmpPhone());
        dto.setEmployeeEmail(command.getEmpEmail());
        dto.setEmployeeImg(command.getEmpImg());
        dto.setEmployeeHireDate(command.getEmpHireDate());

        employeeMapper.insertEmployee(dto);
    }
}
