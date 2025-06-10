package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.command.LoginCommand;
import finalProject.domain.AuthInfoDTO;
import finalProject.mapper.LoginMapper;

@Service
public class LoginService {
    @Autowired
    LoginMapper loginMapper;

    public AuthInfoDTO execute(LoginCommand loginCommand) {
        AuthInfoDTO authInfo = loginMapper.loginSelectOne(loginCommand.getUserId());
        System.out.println("DEBUG userId: " + authInfo.getUserId());
        System.out.println("DEBUG userNum: " + authInfo.getUserNum()); // ← 이게 null이면 문제!
        return authInfo;
    }

}