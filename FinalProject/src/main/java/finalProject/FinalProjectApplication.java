package finalProject;

import finalProject.KrxCompanyBatchImporter;
import finalProject.CompanyBatchImporter;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@MapperScan("finalProject.mapper")
@SpringBootApplication
public class FinalProjectApplication {

    @Value("${app.import-data-on-startup}")
    private boolean importDataOnStartup;

    public static void main(String[] args) {
        SpringApplication.run(FinalProjectApplication.class, args);
    }

    @Bean
    public CommandLineRunner runBatch(CompanyBatchImporter importer, KrxCompanyBatchImporter csvImporter) {
        return args -> {
            if (importDataOnStartup) {
                try {
                    System.out.println("🚀 기업 데이터 자동 등록 시작");

                    // DART API 데이터 등록
                    importer.importAllCompaniesInBatches();

                    // CSV 데이터 등록
                    csvImporter.importFromCsv("D:/finalproject/DATA/상장법인목록.csv");

                    System.out.println("✅ 데이터 등록 완료");

                } catch (Exception e) {
                    System.err.println("❌ 전체 등록 중 예외 발생: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("ℹ️ 데이터 자동 등록이 비활성화 되어 있습니다.");
            }
        };
    }
}