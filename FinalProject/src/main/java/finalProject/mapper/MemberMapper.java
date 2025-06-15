package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.MemberDTO;

@Mapper
public interface MemberMapper {
   public void insertMember(MemberDTO dto);

    public String memberNumAutoSelect();
    
    public MemberDTO memSelectOne(String memberNum);

    MemberDTO selectByMemberNum(@Param("memberNum") String memberNum);
}
