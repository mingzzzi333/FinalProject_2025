package finalProject;

import finalProject.domain.CompanyDTO;
import org.w3c.dom.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class CorpCodeParser {

    private static final Map<String, String> corpCodeMap = new HashMap<>();

    // ✅ 회사명으로 corp_code 조회
    public static String getCorpCodeByName(String name) {
        return corpCodeMap.get(name.trim());
    }

    // ✅ 전체 회사 목록 불러오기 + Map 세팅
    public static List<CompanyDTO> parseAllCompanyList() throws Exception {
        List<CompanyDTO> result = new ArrayList<>();

        File file = new File("src/main/resources/data/CORPCODE.xml");

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(file);

        NodeList list = doc.getElementsByTagName("list");
        for (int i = 0; i < list.getLength(); i++) {
            Element el = (Element) list.item(i);

            String corpCode = el.getElementsByTagName("corp_code").item(0).getTextContent();
            String corpName = el.getElementsByTagName("corp_name").item(0).getTextContent();

            if (corpCode != null && !corpCode.isBlank()) {
                // DTO 구성
                CompanyDTO dto = new CompanyDTO();
                dto.setCompanyNum(corpCode.trim());
                result.add(dto);

                // 이름 → 코드 맵에도 등록
                corpCodeMap.put(corpName.trim(), corpCode.trim());
            }
        }

        return result;
    }
}
