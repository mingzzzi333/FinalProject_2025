package finalProject.mapper;

import finalProject.domain.CompanyDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CompanyMapper {
    void insertCompanyInfo(CompanyDTO company);
    List<CompanyDTO> selectAllCompanies();
    List<CompanyDTO> selectByCompanyName(String keyword);
    List<CompanyDTO> selectPaged(@Param("offset") int offset, @Param("limit") int limit);
    List<CompanyDTO> searchByCompanyNamePaged(@Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit);
    int countAll();
    int countByCompanyName(@Param("keyword") String keyword);
    int existsByCompanyName(@Param("companyName") String companyName);

    CompanyDTO selectByCompanyNum(String companyNum);

}
