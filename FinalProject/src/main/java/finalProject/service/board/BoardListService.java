package finalProject.service.board;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.BoardDTO;
import finalProject.mapper.BoardMapper;

@Service
public class BoardListService {

    @Autowired
    private BoardMapper boardMapper;

    public List<BoardDTO> getAll() {
        return boardMapper.selectAllBoards();
    }
}
