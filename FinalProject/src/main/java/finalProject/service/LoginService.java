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
        return loginMapper.loginSelectOne(loginCommand.getUserId());
    }
}