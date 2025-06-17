package finalProject.service.inquiry;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import finalProject.domain.InquiryDTO;
import finalProject.mapper.InquiryMapper;

@Service
public class InquiryService {

    @Autowired
    private InquiryMapper inquiryMapper;

    public void insertInquiry(InquiryDTO dto) {
        dto.setInquiryNum(UUID.randomUUID().toString());
        inquiryMapper.insertInquiry(dto);
    }

    public List<InquiryDTO> getInquiriesByMember(String memberNum) {
        return inquiryMapper.getInquiriesByMember(memberNum);
    }

    public List<InquiryDTO> getAllInquiries() {
        return inquiryMapper.getAllInquiries();
    }

    public InquiryDTO getInquiryByNum(String inquiryNum) {
        return inquiryMapper.getInquiryByNum(inquiryNum);
    }

    public void updateAnswer(InquiryDTO dto) {
        inquiryMapper.updateAnswer(dto);
    }
}
