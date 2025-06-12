package finalProject;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class IndustryCodeLoader {

    public static Map<String, String> loadIndustryMap(String csvFilePath) throws IOException {
        Map<String, String> map = new HashMap<>();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFilePath), "UTF-8"))) {
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) {
                    first = false; // 첫 줄은 헤더라서 스킵
                    continue;
                }

                String[] parts = line.split(",", -1);
                if (parts.length >= 2) {
                    // ".0" 제거 + 따옴표 제거
                    String code = parts[0].trim().replace(".0", "").replace("\"", "");
                    String name = parts[1].trim().replace("\"", "");

                    if (!code.isBlank() && !name.isBlank()) {
                        map.put(code, name);
                        System.out.println("✅ 업종 매핑 → " + code + " → " + name);
                    }
                }
            }
        }

        System.out.println("📌 최종 업종 매핑 수: " + map.size());
        return map;
    }
}
