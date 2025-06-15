package finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import finalProject.domain.StockA3;
import finalProject.repository.StockRepository;

@Controller
public class StockController {
	@Autowired
	StockRepository stockRepository;
		
	
	@GetMapping("/stockdata")
	public String realStock(Model model) {
		List<StockA3> list =  stockRepository.stockSelect();
		model.addAttribute("list", list);
		return "socket/stock";
	}
	
	@GetMapping("/stockCurrent")
	public @ResponseBody List<StockA3> currentDate(){
		System.out.println("q21341414");
		List<StockA3> list = stockRepository.stockCurrentSelect();
		System.out.println(list.size());
		return list;
	}

}
