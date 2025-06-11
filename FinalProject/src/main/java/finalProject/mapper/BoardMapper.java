package finalProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import finalProject.domain.BoardDTO;

@Mapper
public interface BoardMapper {
	public void insertBoard(BoardDTO dto);

	public int boardNumAutoSelect();
	
	public List<BoardDTO> selectBoardsList(String empNum);

}
