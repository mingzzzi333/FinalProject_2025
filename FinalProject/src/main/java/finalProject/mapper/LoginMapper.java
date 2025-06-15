package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.EmployeeDTO;
import finalProject.domain.MemberDTO;

@Mapper
public interface LoginMapper {
    public AuthInfoDTO loginSelectOne(@Param("userId") String userId);
    
}
