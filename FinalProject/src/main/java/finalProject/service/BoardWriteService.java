package finalProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.command.BoardCommand;
import finalProject.domain.BoardDTO;
import finalProject.mapper.BoardMapper;

@Service
public class BoardWriteService {
	@Autowired
	BoardMapper boardMapper;
	
	public void execute(BoardCommand boardCommand) {
		int autoNum = boardMapper.boardNumAutoSelect();

		BoardDTO dto = new BoardDTO();
		dto.setBoardNum(autoNum);
		dto.setBoardTitle(boardCommand.getBoardTitle());
		dto.setEmployeeNum(boardCommand.getEmpNum());

		boardMapper.insertBoard(dto);
	}
}
