package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import finalProject.mapper.BoardMapper;

@Service
public class BoardAutoNumService {
	@Autowired
    BoardMapper boardMapper;

    public void execute(Model model) {
        int boardNum = boardMapper.boardNumAutoSelect();
        model.addAttribute("boardNum", boardNum);   
    }
}
