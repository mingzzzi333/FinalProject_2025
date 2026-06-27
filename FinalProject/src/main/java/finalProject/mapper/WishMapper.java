package finalProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.WishDTO;

@Mapper
public interface WishMapper {

    int insertWish(WishDTO wish);

    // DELETE 쿼리에서 companyNum, memberId 사용
    int deleteWish(@Param("companyNum") String companyNum, @Param("memberId") String memberId);

    // 단일 찜 조회 (companyNum, memberId)
    WishDTO selectWish(@Param("companyNum") String companyNum, @Param("memberId") String memberId);

    // 찜 목록 조회 (memberNum)
    List<WishDTO> selectWishList(@Param("memberNum") String memberNum);
}
