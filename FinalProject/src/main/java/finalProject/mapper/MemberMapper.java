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
    
    MemberDTO selectById(@Param("memberId") String memberId);


    // 회원 상세 조회
    MemberDTO getMemberInfo(String memberNum);

    // 회원 수정 (여기 추가됨 ✅)
    void updateMember(MemberDTO memberDTO);
    
}
