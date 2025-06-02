package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import finalProject.mapper.MemberMapper;

@Service
public class MemberAutoNumService {
    @Autowired
    MemberMapper memberMapper;

    public void execute(Model model) {
        String memberNum = memberMapper.memberNumAutoSelect();
        model.addAttribute("memberNum", memberNum);   
    }
}