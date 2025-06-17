package finalProject;

import finalProject.domain.CompanyDTO;
import finalProject.service.company.CompanyService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class CompanyBatchImporter {

    @Autowired
    private CompanyService companyService;

    public void importAllCompaniesInBatches() {
        try {
            // ✅ CORPCODE.xml에서 기업 목록 파싱
            List<CompanyDTO> companyList = CorpCodeParser.parseAllCompanyList();
            int insertedCount = 0;

            for (CompanyDTO company : companyList) {
                try {
                    String corpCode = company.getCompanyNum(); // XML의 corp_code

                    // ✅ DART API에서 상세 정보 조회
                    CompanyDTO dto = companyService.fetchCompanyInfo(corpCode);
                    if (dto == null) {
                        System.err.println("⛔ 정보 없음: corpCode=" + corpCode);
                        continue;
                    }

                    dto.setEmployeeNum("SYSTEM");

                    // ✅ 중복 확인 및 저장
                    if (companyService.existsByCompanyName(dto.getCompanyName()) == 0) {
                        companyService.saveCompany(dto);
                        insertedCount++;

                        if (insertedCount % 100 == 0) {
                            System.out.println("✅ " + insertedCount + "건 등록 완료");
                        }
                    } else {
                        System.out.println("⚠️ 중복 생략: " + dto.getCompanyName());
                    }

                    // ✅ 과부하 방지 대기
                    Thread.sleep(300);

                } catch (Exception innerEx) {
                    System.err.println("❌ 등록 실패 (corpCode=" + company.getCompanyNum() + ")");
                    innerEx.printStackTrace();
                }
            }

            System.out.println("🏁 전체 완료: 총 " + insertedCount + "건 등록됨");

        } catch (Exception e) {
            System.err.println("💥 전체 처리 중 예외 발생");
            e.printStackTrace();
        }
    }
}
