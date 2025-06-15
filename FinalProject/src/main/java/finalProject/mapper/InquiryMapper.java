package finalProject.mapper;

import finalProject.domain.InquiryDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InquiryMapper {
    void insertInquiry(InquiryDTO dto);
    List<InquiryDTO> getInquiriesByMember(String memberNum);
    List<InquiryDTO> getAllInquiries();
    InquiryDTO getInquiryByNum(String inquiryNum);
    void updateAnswer(InquiryDTO dto);
}