package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.command.MemberCommand;
import finalProject.domain.MemberDTO;
import finalProject.mapper.MemberMapper;

@Service
public class MemberWriteService {
	@Autowired
	MemberMapper memberMapper;
	
	public void execute(MemberCommand memberCommand) {
		memberCommand.setMemNum(memberCommand.getMemNum());
		MemberDTO dto = new MemberDTO();
		dto.setMemberAddr(memberCommand.getMemAddr());
		dto.setMemberBirth(memberCommand.getMemBirth());
		dto.setMemberDetailAddr(memberCommand.getMemDetailAddr());
		dto.setMemberEmail(memberCommand.getMemEmail());
		dto.setMemberGender(memberCommand.getMemGender());
		dto.setMemberId(memberCommand.getMemId());
		dto.setMemberImg(memberCommand.getMemImg());
		dto.setMemberName(memberCommand.getMemName());
		dto.setMemberNum(memberCommand.getMemNum());
		dto.setMemberPhone(memberCommand.getMemPhone());
		dto.setMemberPost(Integer.parseInt(memberCommand.getMemPost()));
		dto.setMemberPw(memberCommand.getMemPw());
		memberMapper.insertMember(dto);
	}
}
