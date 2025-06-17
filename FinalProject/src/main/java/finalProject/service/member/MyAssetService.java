package finalProject.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.AccountDTO;
import finalProject.mapper.AccountMapper;

@Service
public class MyAssetService {
    @Autowired
    AccountMapper accountMapper;

    public AccountDTO getAccountInfo(String memberNum) {
        return accountMapper.selectByMemberNum(memberNum);
    }

    public void saveOrUpdateAccount(AccountDTO dto) {
        if (dto.getAccountType() == null) {
            dto.setAccountType("기본값"); // 예: "일반", "기본", 등등
        }

        if (accountMapper.selectByMemberNum(dto.getMemberNum()) == null) {
            accountMapper.insertAccount(dto);
        } else {
            accountMapper.updateAccount(dto);
        }
    }

}