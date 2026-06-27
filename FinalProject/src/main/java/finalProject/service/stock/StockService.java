package finalProject.service.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.StockA3;
import finalProject.mapper.StockMapper;

@Service
public class StockService {

    @Autowired
    StockMapper stockMapper;

    public List<StockA3> getStockData(String stockName) {
        return (List<StockA3>) stockMapper.selectLatestStockData(stockName);
    }
}
