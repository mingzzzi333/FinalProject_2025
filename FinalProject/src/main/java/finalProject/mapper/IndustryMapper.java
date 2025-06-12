package finalProject.mapper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import finalProject.IndustryCodeLoader;

public class IndustryMapper {

    private static Map<String, String> industryMap;

    static {
        try {
            // 로컬 경로에서 CSV 파일 로드
            industryMap = IndustryCodeLoader.loadIndustryMap("D:/finalproject/DATA/industry_mapping_updated.csv");
        } catch (IOException e) {
            System.err.println("❌ 업종코드 매핑 로딩 실패: " + e.getMessage());
            industryMap = new HashMap<>();
        }
    }

    public static String map(String code) {
        if (code == null || code.isBlank()) return "기타";
        code = code.trim().replace(".0", ""); // 여기서 소수점 제거
        String result = industryMap.getOrDefault(code, "기타");

        if ("기타".equals(result)) {
            System.out.println("🛑 매핑 실패 → induty_code = " + code);
        } else {
            System.out.println("✅ 매핑 성공 → " + code + " → " + result);
        }

        return result;
    }

}
