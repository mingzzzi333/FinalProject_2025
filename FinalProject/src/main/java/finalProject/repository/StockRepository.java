package finalProject.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import finalProject.domain.StockA3;

@Repository
public class StockRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    public List<StockA3> stockSelect() {

    	sql = "SELECT " +
    		      "    TO_CHAR(trading_date, 'yyyy-MM-dd') AS trading_date, " +
    		      "    rn AS max_rn, " +
    		      "    symbol, " +
    		      "    price, " +
    		      "    volume, " +
    		      "    cumulative_volume, " +  // ✅ 기존 필드
    		      "    high_price, " +         // ✅ 고가 추가
    		      "    low_price " +           // ✅ 저가 추가
    		      "FROM ( " +
    		      "    SELECT " +
    		      "        ROW_NUMBER() OVER ( " +
    		      "            PARTITION BY TO_CHAR(trading_date, 'yyyy-MM-dd') " +
    		      "            ORDER BY trading_hours DESC " +
    		      "        ) AS rn, " +
    		      "        trading_date, " +
    		      "        symbol, " +
    		      "        price, " +
    		      "        volume, " +
    		      "        cumulative_volume, " +
    		      "        high_price, " +
    		      "        low_price " +
    		      "    FROM stockData " +
    		      "    WHERE REGEXP_LIKE(trading_hours, '^[0-9]+$') " + // 숫자 필터링
    		      "      AND ( " +
    		      "        CASE " +
    		      "          WHEN REGEXP_LIKE(trading_hours, '^[0-9]+$') THEN TO_NUMBER(trading_hours) " +
    		      "          ELSE NULL " +
    		      "        END <= 153000 " +
    		      "      ) " +
    		      "      AND ( " +
    		      "          TRUNC(trading_date) < TRUNC(SYSDATE) " +
    		      "          OR ( " +
    		      "              TRUNC(trading_date) = TRUNC(SYSDATE) " +
    		      "              AND TO_NUMBER(TO_CHAR(SYSDATE, 'HH24MI')) >= 1530 " +
    		      "          ) " +
    		      "      ) " +
    		      ") " +
    		      "WHERE rn = 1 " +
    		      "ORDER BY trading_date ASC";



        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(StockA3.class));
    }

    public List<StockA3> stockCurrentSelect() {
        sql = "SELECT * " +
              "FROM ( " +
              "    SELECT s.*, " +
              "           ROW_NUMBER() OVER ( " +
              "               PARTITION BY TO_CHAR(trading_date, 'yyyy-MM-dd'), trading_hours " +
              "               ORDER BY TO_CHAR(trading_date, 'yyyy-MM-dd') DESC, trading_hours DESC, ROWID DESC " +
              "           ) AS rn " +
              "    FROM stockData s " +
              "    WHERE TRUNC(trading_date) = TRUNC(SYSDATE) " +
              ") " +
              "WHERE rn = 1";

        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(StockA3.class));
    }
    
    
}
