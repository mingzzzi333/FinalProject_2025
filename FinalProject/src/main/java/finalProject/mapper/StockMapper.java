package finalProject.mapper;

import java.util.List;

import finalProject.domain.StockA3;
import java.util.List;
import org.apache.ibatis.annotations.Param;

import finalProject.domain.StockA3;

public interface StockMapper {

    // 누적 거래량 최대값 기준 데이터 조회 (전일 기준)
    List<StockA3> stockSelect();

    // 당일 시간별 실시간 데이터 (최신값만)
    List<StockA3> stockCurrentSelect();
    
    StockA3 selectLatestStockData(@Param("stockName") String stockName);
}

