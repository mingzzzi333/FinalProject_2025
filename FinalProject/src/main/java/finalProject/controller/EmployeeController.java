package finalProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import finalProject.command.EmployeeCommand;
import finalProject.service.EmployeeAutoNumService;
import finalProject.service.EmployeeWriteService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    EmployeeWriteService employeeWriteService;

    @Autowired
    EmployeeAutoNumService employeeAutoNumService;

    //관리자 회원가입
    @GetMapping("/employeeWrite")
    public String write(Model model) {
        String autoNum = employeeAutoNumService.getAutoNum();
        model.addAttribute("employeeNum", autoNum);
        return "employee/employeeForm";
    }
    @PostMapping("/employeeWrite")
    public String write(EmployeeCommand employeeCommand) {
        employeeWriteService.execute(employeeCommand);
        return "login/login";
    }
    
}
