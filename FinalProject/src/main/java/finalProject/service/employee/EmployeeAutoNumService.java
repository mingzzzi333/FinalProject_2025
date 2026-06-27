package finalProject.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.mapper.EmployeeMapper;

@Service
public class EmployeeAutoNumService {

    @Autowired
    EmployeeMapper employeeMapper;

    public String getAutoNum() {
        String lastNum = employeeMapper.getLastEmployeeNum();

        if (lastNum == null || !lastNum.startsWith("EMP_")) {
            // 등록된 직원이 없거나 포맷이 이상할 때 초기값
            return "EMP_10001";
        }

        try {
            int num = Integer.parseInt(lastNum.substring(4)); // "EMP_" 뒤 숫자만 추출
            return "EMP_" + (num + 1);
        } catch (NumberFormatException e) {
            // 포맷이 이상할 때도 초기값으로 복구
            return "EMP_10001";
        }
    }
}
