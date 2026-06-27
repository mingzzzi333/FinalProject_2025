package finalProject.service.wish;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.MemberDTO;
import finalProject.domain.WishDTO;
import finalProject.mapper.MemberMapper;
import finalProject.mapper.WishMapper;
import finalProject.service.company.CompanyService;

@Service
public class WishService {
    
    @Autowired
    private MemberMapper memberMapper;
    
    @Autowired
    private WishMapper wishMapper;
    
    @Autowired
    private CompanyService companyService;
    
    /**
     * 회원 ID(userId)를 받아 찜 토글(추가/삭제) 처리
     * @param companyNum 회사 번호 (String)
     * @param userId 회원 아이디 (userId)
     * @return 성공 여부(true: 추가 혹은 삭제 성공)
     */
    public boolean toggleWish(String companyNum, String userId) {
        // userId로 회원 정보 조회
        MemberDTO member = memberMapper.selectById(userId);
        if (member == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 아이디입니다: " + userId);
        }
        String memberNum = member.getMemberNum();
        
        // 회사 존재 여부 확인
        if (companyService.getCompanyByNum(companyNum) == null) {
            throw new IllegalArgumentException("존재하지 않는 회사 번호입니다: " + companyNum);
        }
        
        // 기존 찜 여부 확인
        WishDTO existing = wishMapper.selectWish(companyNum, memberNum);
        
        if (existing == null) {
            // 찜 추가
            WishDTO wish = new WishDTO();
            wish.setCompanyNum(companyNum);
            wish.setMemberNum(memberNum);
            return wishMapper.insertWish(wish) > 0;
        } else {
            // 찜 삭제
            return wishMapper.deleteWish(companyNum, memberNum) > 0;
        }
    }
    
    /**
     * 회원 ID(userId)로 찜 목록 조회
     * @param userId 회원 아이디
     * @return 찜 목록 리스트
     */
    public List<WishDTO> getWishListByUserId(String userId) {
        // userId로 회원 정보 조회
        MemberDTO member = memberMapper.selectById(userId);
        if (member == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 아이디입니다: " + userId);
        }
        String memberNum = member.getMemberNum();
        
        // 찜 목록 조회
        return wishMapper.selectWishList(memberNum);
    }
    
    /**
     * 찜 삭제 처리
     * @param companyNum 회사 번호
     * @param userId 회원 아이디
     * @return 삭제 성공 여부
     */
    public boolean removeWish(String companyNum, String memberId) {
        System.out.println("removeWish 호출: companyNum = " + companyNum + ", memberId = " + memberId);
        
        MemberDTO member = memberMapper.selectById(memberId);
        if (member == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 아이디입니다: " + memberId);
        }

        int result = wishMapper.deleteWish(companyNum, memberId);
        System.out.println("삭제 쿼리 실행 결과: " + result);

        return result > 0;
    }


    
    /**
     * 특정 회사가 회원에 의해 찜되었는지 확인
     * @param companyNum 회사 번호
     * @param userId 회원 아이디
     * @return 찜 여부 (true: 찜함, false: 찜하지 않음)
     */
    public boolean isWished(String companyNum, String userId) {
        // userId로 회원 정보 조회
        MemberDTO member = memberMapper.selectById(userId);
        if (member == null) {
            return false; // 회원이 없으면 찜하지 않은 상태로 처리
        }
        String memberNum = member.getMemberNum();
        
        // 찜 여부 확인
        WishDTO wish = wishMapper.selectWish(companyNum, memberNum);
        return wish != null;
    }
    
    /**
     * 특정 회사가 회원에 의해 찜되었는지 확인 (별칭 메서드)
     * @param companyNum 회사 번호
     * @param userId 회원 아이디
     * @return 찜 여부 (true: 찜함, false: 찜하지 않음)
     */
    public boolean isWishedByUserId(String companyNum, String userId) {
        return isWished(companyNum, userId);
    }
}