package finalProject;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import lombok.Value;

@MapperScan("finalProject.mapper")
@SpringBootApplication
public class FinalProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinalProjectApplication.class, args);
	}
	@Bean
	public CommandLineRunner runBatch(CompanyBatchImporter importer, KrxCompanyBatchImporter csvImporter) {
	    return args -> {
	        try {
	            System.out.println("🚀 데이터 자동 등록 시작");

	            boolean dartEnabled = Boolean.parseBoolean(System.getProperty("dart.enabled", "false"));
	            if (dartEnabled) {
	                importer.importAllCompaniesInBatches();
	            } else {
	                System.out.println("⚠️ DART 자동 등록 비활성화됨");
	            }

	            csvImporter.importFromCsv("D:/finalproject/DATA/상장법인목록.csv");

	            System.out.println("✅ 데이터 등록 완료");

	        } catch (Exception e) {
	            System.err.println("❌ 전체 등록 중 예외 발생: " + e.getMessage());
	            e.printStackTrace();
	        }
	    };
	}


	
}