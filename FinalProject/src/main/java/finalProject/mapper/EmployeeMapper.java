package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;

import finalProject.domain.EmployeeDTO;

@Mapper
public interface EmployeeMapper {
    public void insertEmployee(EmployeeDTO dto);
    String getLastEmployeeNum();
}
