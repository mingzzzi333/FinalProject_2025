package finalProject.service;

import finalProject.CorpCodeParser;
import finalProject.domain.CompanyDTO;
import finalProject.mapper.CompanyMapper;
import finalProject.mapper.IndustryMapper;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class CompanyService {

    private final String apiKey = "89e76675c6910dcdcbdb09fc5bb03e3795ea54dc";

    @Autowired
    private CompanyMapper companyMapper;

    public CompanyDTO fetchCompanyInfo(String corpCode) {
        try {
            JSONObject companyJson = getJson("https://opendart.fss.or.kr/api/company.json?crtfc_key=" + apiKey + "&corp_code=" + corpCode);

            if (companyJson == null) {
                System.err.println("❌ JSON 응답이 null입니다. corpCode=" + corpCode);
                return null;
            }

            String status = companyJson.optString("status");
            if (!"0000".equals(status)) {
                System.err.println("❌ DART API 실패: corpCode=" + corpCode + " / status=" + status + " / message=" + companyJson.optString("message"));
                return null;
            }

            CompanyDTO dto = new CompanyDTO();
            dto.setCompanyNum(corpCode);
            dto.setCompanyName(companyJson.optString("corp_name"));
            dto.setCompanyCeoName(companyJson.optString("ceo_nm"));
            dto.setCompanyYear(parseDate(companyJson.optString("est_dt")));
            dto.setCompanyType(IndustryMapper.map(companyJson.optString("induty_code")));
            dto.setIndustry(companyJson.optString("induty_code"));
            return dto;

        } catch (Exception e) {
            System.err.println("❌ 예외 발생: corpCode=" + corpCode);
            e.printStackTrace();
            return null;
        }
    }

    public void saveCompany(CompanyDTO company) {
        try {
            if (company.getCompanyName() == null || company.getCompanyName().isBlank()) {
                System.out.println("⛔ 기업명 없음 → 저장 안함");
                return;
            }

            String name = company.getCompanyName().trim();
            int exists = companyMapper.existsByCompanyName(name);
            if (exists == 0) {
                company.setCompanyName(name);
                companyMapper.insertCompanyInfo(company);
            } else {
                System.out.println("⚠️ 중복된 기업명: " + name);
            }
        } catch (Exception e) {
            System.err.println("❌ 회사 저장 실패: " + company.getCompanyName());
            e.printStackTrace();
        }
    }

    public int existsByCompanyName(String companyName) {
        return companyMapper.existsByCompanyName(companyName);
    }

    public List<CompanyDTO> getAllCompanies() {
        return companyMapper.selectAllCompanies();
    }

    public List<CompanyDTO> searchByCompanyName(String keyword) {
        return companyMapper.selectByCompanyName(keyword);
    }

    public List<CompanyDTO> getCompaniesPaged(int offset, int limit) {
        return companyMapper.selectPaged(offset, limit);
    }

    public List<CompanyDTO> searchByCompanyNamePaged(String keyword, int offset, int limit) {
        return companyMapper.searchByCompanyNamePaged(keyword, offset, limit);
    }

    public int getTotalCompanyCount() {
        return companyMapper.countAll();
    }

    public int countByCompanyName(String keyword) {
        return companyMapper.countByCompanyName(keyword);
    }

    public CompanyDTO getCompanyByNum(String companyNum) {
        return companyMapper.selectByCompanyNum(companyNum);
    }

    @Transactional
    public void saveCompanyList(List<CompanyDTO> list) {
        for (CompanyDTO dto : list) {
            saveCompany(dto);
        }
    }

    public String getCorpCodeByCompanyName(String companyName) {
        if (companyName == null) return null;
        return CorpCodeParser.getCorpCodeByName(companyName.trim());
    }

    private JSONObject getJson(String urlStr) {
        try {
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.err.println("❌ 응답 실패: HTTP " + responseCode + " → " + urlStr);
                return null;
            }

            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) sb.append(line);

                String jsonStr = sb.toString();
                if (jsonStr.isBlank() || !jsonStr.trim().startsWith("{")) {
                    System.err.println("❌ 응답 내용 없음 또는 비정상 형식: " + urlStr);
                    return null;
                }

                return new JSONObject(jsonStr);
            }

        } catch (Exception e) {
            System.err.println("❌ API 호출 예외: " + urlStr);
            e.printStackTrace();
            return null;
        }
    }

    private Date parseDate(String yyyymmdd) {
        if (yyyymmdd == null || yyyymmdd.length() != 8) return null;
        LocalDate localDate = LocalDate.parse(yyyymmdd, DateTimeFormatter.ofPattern("yyyyMMdd"));
        return Date.valueOf(localDate);
    }
}
