package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.AuthInfoDTO;

@Mapper
public interface LoginMapper {
    public AuthInfoDTO loginSelectOne(@Param("userId") String userId);
}
