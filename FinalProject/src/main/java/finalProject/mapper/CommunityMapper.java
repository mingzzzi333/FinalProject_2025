package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;

import finalProject.domain.CommunityDTO;

@Mapper
public interface CommunityMapper {
	public void insertCommunity(CommunityDTO dto);

}
