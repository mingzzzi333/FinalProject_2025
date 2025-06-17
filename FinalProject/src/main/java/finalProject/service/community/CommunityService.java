package finalProject.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.CommunityDTO;
import finalProject.mapper.CommunityMapper;

@Service
public class CommunityService {
	@Autowired
	CommunityMapper communityMapper;
	
	public List<CommunityDTO> selectTop5ByLikes() {
	    return communityMapper.selectTop5ByLikes();
	}

}
