package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.mapper.EmployeeMapper;

@Service
public class EmployeeAutoNumService {

    @Autowired
    EmployeeMapper employeeMapper;

    public String getAutoNum() {
        String lastNum = employeeMapper.getLastEmployeeNum();
        if (lastNum == null) {
            return "EMP_10001";
        }
        int num = Integer.parseInt(lastNum.substring(4)) + 1;
        return "EMP_" + num;
    }
}
