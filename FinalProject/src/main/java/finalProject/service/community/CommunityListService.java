package finalProject.service.community;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.CommunityDTO;
import finalProject.mapper.CommunityMapper;

@Service
public class CommunityListService {

    @Autowired
    CommunityMapper communityMapper;

    // 전체 글 조회
    public List<CommunityDTO> getAll() {
        return communityMapper.selectAll();
    }
    
    // boardNum 기준으로 커뮤니티 글 조회
    public List<CommunityDTO> getListByBoardNum(Integer boardNum) {
        return communityMapper.selectByBoardNum(boardNum);
    }
    
// 단일 게시글 정보 조회
    public CommunityDTO getPostById(int commuNum) {
        return communityMapper.selectPostById(commuNum);
    }

    // commuNum 기준으로 게시글 상세 조회
    public CommunityDTO getCommunityById(int commuNum) {
        return communityMapper.selectCommunityById(commuNum);
    }
    
    // 조회수 증가
    public void incrementViews(int commuNum) {
        communityMapper.updateViews(commuNum);
    }
    
}
