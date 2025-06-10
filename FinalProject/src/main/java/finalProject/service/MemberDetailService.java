package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import finalProject.domain.MemberDTO;
import finalProject.mapper.MemberMapper;

@Service
public class MemberDetailService {
	@Autowired
	MemberMapper memberMapper;
	
	public void execute(Model model, String memberNum) {
	    MemberDTO dto = memberMapper.memSelectOne(memberNum);
	    model.addAttribute("memberCommand", dto);
	}


}
