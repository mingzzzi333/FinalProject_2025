package finalProject.mapper;

import org.apache.ibatis.annotations.Mapper;

import finalProject.domain.AccountDTO;

@Mapper
public interface AccountMapper {

   AccountDTO selectByMemberNum(String memberNum);
   void insertAccount(AccountDTO dto);
   void updateAccount(AccountDTO dto);
}
