package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;

import finalProject.command.MemberCommand;
import finalProject.domain.MemberDTO;

@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);

    public String memberNumAutoSelect();
    
    public MemberDTO memSelectOne(String memberNum);


}
