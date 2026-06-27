package finalProject.domain;


import java.util.Date;

import lombok.Data;

@Data
public class StockA3 {
    String tradingDate;
    String tradingHours;
    String symbol;
    int price;
    int volume;
    int cumulativeVolume;

    // ✅ 추가
    int highPrice;
    int lowPrice;

	
}