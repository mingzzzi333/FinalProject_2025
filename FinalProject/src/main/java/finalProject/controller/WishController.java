package finalProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import finalProject.domain.AuthInfoDTO;
import finalProject.domain.CompanyDTO;
import finalProject.domain.WishDTO;
import finalProject.service.company.CompanyService;
import finalProject.service.wish.WishService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/wish")
public class WishController {
    
    private static final Logger logger = LoggerFactory.getLogger(WishController.class);
    
    @Autowired
    private WishService wishService;
    
    @Autowired
    private CompanyService companyService;
    
    /**
     * 찜 상태 토글 (추가/제거)
     * AJAX 요청으로 처리
     */
    @PostMapping("/toggle")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleWishlist(
            @RequestParam String companyNum, 
            HttpServletRequest request) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            HttpSession session = request.getSession();
            AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
            
            // 로그인 체크
            if (authInfo == null) {
                logger.warn("찜 토글 시도 - 로그인되지 않은 사용자");
                response.put("success", false);
                response.put("message", "로그인이 필요한 서비스입니다.");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }
            
            String userId = authInfo.getUserId();
            
            // 입력 검증
            if (companyNum == null || companyNum.trim().isEmpty()) {
                logger.warn("찜 토글 시도 - 잘못된 회사 번호: {}", companyNum);
                response.put("success", false);
                response.put("message", "잘못된 회사 정보입니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 회사 존재 여부 확인 (선택사항)
            CompanyDTO company = companyService.getCompanyByNum(companyNum);
            if (company == null) {
                logger.warn("찜 토글 시도 - 존재하지 않는 회사: {}", companyNum);
                response.put("success", false);
                response.put("message", "존재하지 않는 회사입니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 찜 상태 토글
            boolean isWished = wishService.toggleWish(companyNum, userId);
            
            logger.info("찜 상태 변경 - 사용자: {}, 회사: {}, 결과: {}", 
                       userId, companyNum, isWished ? "추가" : "제거");
            
            response.put("success", true);
            response.put("isWished", isWished);
            response.put("message", isWished ? "찜 목록에 추가되었습니다." : "찜 목록에서 제거되었습니다.");
            response.put("companyName", company.getCompanyName()); // 추가 정보
            
            return ResponseEntity.ok(response);
            
        } catch (IllegalArgumentException e) {
            logger.error("찜 토글 처리 중 잘못된 인수 오류: {}", e.getMessage());
            response.put("success", false);
            response.put("message", "잘못된 요청입니다.");
            return ResponseEntity.badRequest().body(response);
            
        } catch (Exception e) {
            logger.error("찜 토글 처리 중 서버 오류", e);
            response.put("success", false);
            response.put("message", "서버 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    /**
     * 사용자의 찜 목록 조회
     */
    @GetMapping("/wishList")
    public String wishListPage(HttpSession session, Model model) {
        try {
            AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
            
            if (authInfo != null) {
                String userId = authInfo.getUserId();
                List<WishDTO> wishList = wishService.getWishListByUserId(userId);
                
                logger.info("찜 목록 조회 - 사용자: {}, 찜 개수: {}", userId, wishList.size());
                
                model.addAttribute("wishList", wishList);
                model.addAttribute("wishCount", wishList.size());
                
            } else {
                logger.info("찜 목록 조회 - 로그인되지 않은 사용자");
                model.addAttribute("wishList", List.of());
                model.addAttribute("wishCount", 0);
                model.addAttribute("message", "로그인 후 찜 목록을 확인할 수 있습니다.");
            }
            
        } catch (Exception e) {
            logger.error("찜 목록 조회 중 오류", e);
            model.addAttribute("wishList", List.of());
            model.addAttribute("wishCount", 0);
            model.addAttribute("error", "찜 목록을 불러오는 중 오류가 발생했습니다.");
        }
        
        return "wish/wishList";
    }
    
    /**
     * 특정 찜 항목 삭제 (찜 목록 페이지에서 사용)
     */
    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeWish(
            @RequestParam String companyNum,
            HttpServletRequest request) {

        Map<String, Object> response = new HashMap<>();
        try {
            HttpSession session = request.getSession();
            AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");

            if (authInfo == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            String memberId = authInfo.getUserId(); // 로그인 시 저장된 회원 아이디 (memberId와 동일)
            boolean removed = wishService.removeWish(companyNum, memberId);

            if (removed) {
                response.put("success", true);
                response.put("message", "찜 목록에서 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "삭제할 찜 정보를 찾을 수 없습니다.");
            }

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }


    
    /**
     * 특정 회사의 찜 상태 확인 (AJAX)
     */
    @GetMapping("/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkWishStatus(
            @RequestParam String companyNum,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("authInfo");
            
            if (authInfo == null) {
                response.put("success", true);
                response.put("isWished", false);
                return ResponseEntity.ok(response);
            }
            
            String userId = authInfo.getUserId();
            boolean isWished = wishService.isWished(companyNum, userId);
            
            response.put("success", true);
            response.put("isWished", isWished);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            logger.error("찜 상태 확인 중 오류", e);
            response.put("success", false);
            response.put("isWished", false);
            return ResponseEntity.ok(response);
        }
    }
}