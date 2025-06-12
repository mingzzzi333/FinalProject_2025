package finalProject;

import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import finalProject.domain.CompanyDTO;
import finalProject.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Component
public class KrxCompanyBatchImporter {

    @Autowired
    private CompanyService companyService;

    public void importFromCsv(String csvFilePath) throws Exception {
        try (
                InputStreamReader isr = new InputStreamReader(new FileInputStream(csvFilePath), "EUC-KR");
                CSVReader reader = new CSVReaderBuilder(isr).build();
        ) {
            String[] nextLine;
            boolean isFirst = true;
            List<CompanyDTO> list = new ArrayList<>();
            int limit = 100;  // 처리할 최대 갯수 설정
            
            while ((nextLine = reader.readNext()) != null) {
                if (isFirst) { 
                    isFirst = false; 
                    continue; // 첫 줄(헤더) skip 
                }

                // 갯수 제한 체크 - 데이터를 추가하기 전에 제한을 체크
                if (list.size() >= limit) {
                    break;  // 갯수 제한에 도달하면 더 이상 데이터를 추가하지 않음
                }

                CompanyDTO dto = new CompanyDTO();
                // 컬럼 인덱스: 0=회사명, 1=종목코드, 2=업종, 3=주요제품, 4=상장일, 5=결산월, 6=대표자명, 7=홈페이지, 8=지역
                dto.setCompanyNum(UUID.randomUUID().toString());  // 고유번호 생성 (companyNum으로 변경)
                dto.setCompanyName(nextLine[0]);                   // 회사명
                dto.setCompanyType(nextLine[2]);                   // 업종
                dto.setCompanyCeoName(nextLine[6]);                // 대표자명
                dto.setCompanyListDate(parseDate(nextLine[4]));    // 상장일 (yyyy.MM.dd 또는 yyyy-MM-dd)
                dto.setIndustry(nextLine[2]);                      // 업종명(같이 사용)
                dto.setEmployeeNum("SYSTEM");                      // 시스템 등록

                list.add(dto);
            }

            // 저장된 데이터를 DB에 추가
            for (CompanyDTO dto : list) {
                companyService.saveCompany(dto);  // companyService.saveCompany(dto) 호출
            }
            System.out.println("총 " + list.size() + "건 저장 완료!");
        }
    }



    private Date parseDate(String dateStr) {
        try {
            if (dateStr == null || dateStr.isBlank()) return null;
            // "YYYY.MM.DD" → "YYYY-MM-DD" 변환
            String replaced = dateStr.replace(".", "-");
            return Date.valueOf(replaced);
        } catch (Exception e) {
            return null;
        }
    }
}
