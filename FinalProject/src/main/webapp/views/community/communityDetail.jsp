<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="finalProject.domain.AuthInfoDTO" %>

<%
    finalProject.domain.AuthInfoDTO authInfo = (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    request.setAttribute("authInfo", authInfo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>INVEST YATRA - 게시글 상세보기</title>
    <!-- jQuery 및 FontAwesome -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap');

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f9fafb;
            margin: 0; padding: 0;
            color: #333;
            line-height: 1.6;
        }
        .header-line1 {
            background: #FF6B6B;
            color: #fff;
            padding: 20px 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            font-weight: 700;
            font-size: 28px;
            letter-spacing: 1.2px;
        }
        .header-line1 .auth-links {
            position: absolute;
            right: 24px;
            top: 50%;
            transform: translateY(-50%);
            font-weight: 500;
            font-size: 14px;
        }
        .header-line1 .auth-links a {
            color: #fff;
            margin-left: 16px;
            text-decoration: none;
            transition: color 0.3s;
        }
        .header-line1 .auth-links a:hover {
            color: #ffc3c3;
            text-decoration: underline;
        }

        .header-line2 {
            background: #ffe5e5;
            padding: 12px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
            font-size: 15px;
            color: #555;
        }
        .nav-links a {
            margin-right: 20px;
            color: #555;
            text-decoration: none;
            transition: color 0.3s;
        }
        .nav-links a:last-child {
            margin-right: 0;
        }
        .nav-links a:hover {
            color: #ff6b6b;
            text-decoration: underline;
        }

        .search-box form {
            display: flex;
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
            background: #fff;
        }
        .search-box input[type="text"] {
            padding: 10px 18px;
            font-size: 14px;
            border: none;
            width: 280px;
            outline: none;
        }
        .search-box button {
            background-color: #ff6b6b;
            border: none;
            color: white;
            padding: 0 18px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-box button:hover {
            background-color: #e85757;
        }

        /* 본문 영역 */
        .content-area {
            max-width: 900px;
            margin: 30px auto 60px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.1);
            padding: 30px 40px;
        }

        /* 게시글 박스 */
        .post-box {
            margin-bottom: 30px;
        }
        .post-title {
            font-size: 28px;
            font-weight: 700;
            color: #222;
            margin-bottom: 10px;
            border-bottom: 2px solid #ff6b6b;
            padding-bottom: 8px;
        }
        .post-meta {
            color: #777;
            font-size: 14px;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .post-content {
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 16px;
            white-space: pre-wrap;
            word-break: break-word;
            color: #444;
            line-height: 1.5;
            margin-bottom: 30px;
            padding: 20px 0;
        }
        .post-content img {
            border-radius: 10px;
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            box-shadow: 0 2px 10px rgb(0 0 0 / 0.1);
        }

        /* 좋아요 버튼 영역 (가운데 정렬) */
        .like-section {
            text-align: center;
            margin: 30px 0;
        }

        .like-btn {
            background: none;
            border: 2px solid #ff6b6b;
            padding: 12px 30px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #ff6b6b;
        }

        .like-btn:hover {
            background-color: #ff6b6b;
            color: white;
            transform: scale(1.05);
        }

        .like-btn.liked {
            color: white;
            background-color: #ff6b6b;
            border-color: #e85757;
        }

        /* 핑크색 구분선 */
        .divider {
            border-top: 2px solid #ff6b6b;
            margin: 5px 0;
        }

        /* 목록으로 버튼과 수정/삭제 버튼을 같은 줄에 배치 */
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            padding: 0 10px;
        }

        .back-button {
            margin: 0;
        }
        .back-button .btn {
            background-color: #6c757d;
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .back-button .btn:hover {
            background-color: #545b62;
        }

        /* 수정/삭제 버튼 영역 */
        .post-actions {
            margin: 0;
        }
        .post-actions form {
            display: inline-block;
            margin-left: 10px;
        }
        .post-actions button, .post-actions .btn {
            background-color: #ff6b6b;
            border: none;
            color: white;
            font-weight: 600;
            padding: 8px 18px;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .post-actions button:hover, .post-actions .btn:hover {
            background-color: #e85757;
        }
        .post-actions .btn-danger {
            background-color: #dc3545;
        }
        .post-actions .btn-danger:hover {
            background-color: #c82333;
        }

        /* 댓글 영역 */
        .comment-section {
            margin-top: 30px;
        }
        .comment-section h4 {
            color: #ff6b6b;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .comment {
            background: #fff0f0;
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            box-shadow: 0 1px 5px rgb(0 0 0 / 0.05);
        }
        .comment strong {
            font-weight: 700;
            color: #c0392b;
            font-size: 14px;
        }
        .comment-date {
            font-size: 12px;
            color: #999;
            margin-left: 12px;
        }
        .comment p {
            margin: 8px 0 0;
            white-space: pre-wrap;
            font-size: 15px;
            color: #444;
        }
    </style>
</head>
<body>

<div class="header-line1">
    <a href="/home" style="color: inherit; text-decoration: none;">INVEST YATRA</a>
    <div class="auth-links">
        <c:choose>
            <c:when test="${not empty authInfo}">
                <span>${authInfo.userId}님 (${authInfo.grade})</span>
                <a href="/logout">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="/login">로그인</a>
                <a href="/member/memberWrite">회원가입</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="header-line2">
    <div class="nav-links">
        <a href="/news">뉴스</a>
        <a href="/stock">인기주식</a>
        <a href="/communityMain">토론장</a>
    </div>
    <div class="search-box">
        <form action="/search" method="get" style="display:flex;">
            <input type="text" name="query" placeholder="검색어 입력" />
            <button type="submit">🔍</button>
        </form>
    </div>
</div>

<div class="content-area">

    <!-- 1. 게시글 내용 -->
    <div class="post-box">
        <div class="post-title">${commu.commuSubject}</div>
        <div class="post-meta">
            작성자: ${commu.writerName} |
            작성일: <fmt:formatDate value="${commu.commuRegist}" pattern="yyyy-MM-dd HH:mm" /> |
            조회수: ${commu.commuViews} |
            좋아요: <span id="likeCount-${commu.commuNum}">${commu.commuGood}</span>개
        </div>
         <div class="post-content">
                <pre>${commu.commuContents}</pre>
            
             <!-- 이미지 출력 -->
<!-- 이미지가 있을 경우 출력 -->
<c:if test="${not empty commu.commuImageStoreName}">
    <div style="margin-top: 20px;">
    📎 이미지 첨부:
            
        <img src="${pageContext.request.contextPath}/upload/${commu.commuImageStoreName}" 
             alt="첨부 이미지" 
             style="max-width: 100%; height: auto; border: 1px solid #ccc; border-radius: 8px;" />
        
    </div>
</c:if>

         </div>

        
    <!-- 2. 좋아요 버튼 (가운데 정렬, 개수 포함) -->
    <div class="like-section">
        <button id="likeBtn-${commu.commuNum}" class="like-btn" onclick="toggleLike(${commu.commuNum})">
            <i class="far fa-heart"></i> 좋아요 (<span id="likeCount-${commu.commuNum}">${commu.commuGood}</span>)
        </button>
    </div>

    <!-- 3. 첫 번째 핑크색 구분선 -->
    <div class="divider"></div>

    <!-- 4. 목록으로 버튼 (왼쪽)과 수정/삭제 버튼 (오른쪽) -->
    <div class="action-row">
        <div class="back-button">
            <a href="/community/list?boardNum=${boardNum}" class="btn">목록으로</a>
        </div>
        
        <c:if test="${sessionScope.authInfo.userNum == commu.memberNum}">
            <div class="post-actions">
                <a href="/community/edit/${commu.commuNum}" class="btn">수정</a>
                <form method="post" action="/community/delete" style="display: inline;">
                    <input type="hidden" name="commuNum" value="${commu.commuNum}"/>
                    <input type="hidden" name="boardNum" value="${boardNum}"/>
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </div>
        </c:if>
    </div>

    <!-- 5. 두 번째 핑크색 구분선 -->
    <!-- 댓글 영역 -->
<div class="comment-section">
    <h4>댓글</h4>

    <!-- 댓글 작성 폼 -->
    <c:if test="${not empty authInfo}">
        <div class="comment-form" style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
            <form action="/community/commentInsert" method="post">
                <input type="hidden" name="commuNum" value="${commu.commuNum}" />
                <textarea name="commentContents" rows="4" 
                         style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;" 
                         placeholder="댓글을 입력하세요" required></textarea>
                <div style="margin-top: 10px; text-align: right;">
                    <button type="submit" 
                            style="background-color: #ff6b6b; color: white; border: none; padding: 8px 20px; border-radius: 5px; cursor: pointer;">
                        댓글 등록
                    </button>
                </div>
            </form>
        </div>
    </c:if>
    
    <!-- 로그인하지 않은 경우 안내 메시지 -->
    <c:if test="${empty authInfo}">
        <div style="background: #fff3cd; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
            <p style="margin: 0; color: #856404;">댓글을 작성하려면 <a href="/login" style="color: #ff6b6b;">로그인</a>이 필요합니다.</p>
        </div>
    </c:if>

<!-- 댓글 목록 -->
<c:forEach var="comment" items="${parentComments}">
    <div class="comment">
        <strong>${comment.memberName}</strong>
        <span class="comment-date">
            <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/>
        </span>
        <p>${comment.commentContents}</p>

        <!-- 수정/삭제/답글 버튼 -->
        <div class="comment-actions" style="margin-top: 10px;">
            <c:if test="${not empty authInfo and authInfo.userNum == comment.memberNum}">
                <button type="button" 
<%--                 onclick="location.href='/community/commentEdit/${comment.commentNum}'"  --%>
                  onclick="toggleUpdateForm(${comment.commentNum})"
             style="background: #6c757d; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; margin-right: 5px;">
             수정
            </button>

                <form action="/community/commentDelete" method="post" style="display:inline;">
                    <input type="hidden" name="commentNum" value="${comment.commentNum}" />
                    <input type="hidden" name="commuNum" value="${commu.commuNum}" />
                    <button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');"
                            style="background: #dc3545; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">
                        삭제
                    </button>
                </form>
            </c:if>
            <!-- 답글 버튼 (로그인한 사용자만 보이도록) -->
            <c:if test="${not empty authInfo}">
                <button type="button" onclick="toggleReplyForm(${comment.commentNum})" 
                        style="background: #007bff; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; margin-left: 5px;">
                    답글
                </button>
            </c:if>
        </div>
        <!-- 수정폼 -->
        <c:if test="${not empty authInfo}">
        <div id="updateForm-${comment.commentNum}" class="comment-form" style="display:none; background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
            <form action="/community/commentUpdate" method="post">
             <input type="hidden" name="commuNum" value="${commu.commuNum}" />
             <input type="hidden" name="commentNum" value="${comment.commentNum}" />
             <textarea name="commentContents" rows="4"
                    style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;"
                    required>${comment.commentContents}</textarea>
             <div style="margin-top: 10px; text-align: right;">
                 <button type="submit"
                   style="background-color: #ff6b6b; color: white; border: none; padding: 8px 20px; border-radius: 5px; cursor: pointer;">
                  수정완료
                 </button>
             </div>
      </form>

        </div>
    </c:if>
        
        <!-- 대댓글 작성 폼 -->
        <c:if test="${not empty authInfo}">
            <div id="replyForm-${comment.commentNum}" style="display:none; margin-top: 15px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
                <form action="/community/commentReplyWrite" method="post">
                    <input type="hidden" name="commuNum" value="${commu.commuNum}" />
                    <input type="hidden" name="parentCommentNum" value="${comment.commentNum}" />
                    <input type="hidden" name="memberNum" value="${authInfo.userNum}" />
                    <textarea name="commentContents" rows="3" 
                             style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd; resize: vertical;" 
                             placeholder="답글을 입력하세요" required></textarea>
                    <div style="text-align: right; margin-top: 8px;">
                        <button type="button" onclick="toggleReplyForm(${comment.commentNum})" 
                                style="background: #6c757d; color: white; border: none; padding: 6px 15px; border-radius: 5px; cursor: pointer; margin-right: 5px;">
                            취소
                        </button>
                        <button type="submit" 
                                style="background: #28a745; color: white; border: none; padding: 6px 15px; border-radius: 5px; cursor: pointer;">
                            답글 등록
                        </button>
                    </div>
                </form>
            </div>
        </c:if>
        
    </div>

    <!-- 해당 댓글의 답글들 출력 -->
    <c:if test="${not empty repliesMap[comment.commentNum]}">
        <c:forEach var="reply" items="${repliesMap[comment.commentNum]}">
            <div class="comment reply" style="margin-left: 30px; margin-top: 10px; background: #f0f0f0;">
                <strong>↳ ${reply.memberName}</strong>
                <span class="comment-date">
                    <fmt:formatDate value="${reply.commentDate}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
                <p>${reply.commentContents}</p>

                <!-- 대댓글 수정/삭제 버튼 -->
                <div class="comment-actions" style="margin-top: 10px;">
                    <c:if test="${not empty authInfo and authInfo.userNum == reply.memberNum}">
                         <button type="button" onclick="replyupdateForm(${reply.commentNum})"
                                style="background: #6c757d; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; margin-right: 5px;">
                            수정
                        </button>
                        <form action="/community/commentDelete" method="post" style="display:inline;">
                            <input type="hidden" name="commentNum" value="${reply.commentNum}" />
                            <input type="hidden" name="commuNum" value="${commu.commuNum}" />
                            <button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');"
                                    style="background: #dc3545; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">
                                삭제
                            </button>
                        </form>
                    </c:if>
                </div>
                  <!-- 대댓글 작성 폼 대댓글의 수정폼 -->
              <!-- 대댓글 수정 폼 -->
            <c:if test="${not empty authInfo}">
                <div id="replyupdateForm-${reply.commentNum}" style="display:none; margin-top: 15px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
                 <form action="/community/commentUpdate" method="post">
            
                  <input type="hidden" name="commentNum" value="${reply.commentNum}" />
                  <input type="hidden" name="commuNum" value="${commu.commuNum}" />
            
               <!-- 댓글 수정 내용 -->
                  <textarea name="commentContents" rows="3" 
                      style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd; resize: vertical;" 
                      required>${reply.commentContents}</textarea>

                    <div style="text-align: right; margin-top: 8px;">
                      <button type="button" onclick="replyupdateForm(${reply.commentNum})" 
                        style="background: #6c757d; color: white; border: none; padding: 6px 15px; border-radius: 5px; cursor: pointer; margin-right: 5px;">
                       취소
                      </button>
                      <button type="submit" 
                           style="background: #28a745; color: white; border: none; padding: 6px 15px; border-radius: 5px; cursor: pointer;">
                       답글 수정
                         </button>
                  </div>
              </form>
          </div>
      </c:if>
            </div>
        </c:forEach>
    </c:if>
    
    
</c:forEach>
    
    <!-- 댓글이 없는 경우 -->
    <c:if test="${empty commentList}">
        <div style="text-align: center; padding: 30px; color: #999;">
            <p>첫 댓글을 작성해보세요!</p>
        </div>
    </c:if>
</div>
    <!-- 숨겨진 필드: commuNum -->
    
    <input type="hidden" id="commuNum" value="${commu.commuNum}"/>

</div>

<!-- JavaScript: 좋아요 토글 및 상태 로드 -->
<script>

   function replyupdateForm(commentNum) {
      const form = document.getElementById('replyupdateForm-' + commentNum);
      if (form) {
          if (form.style.display === 'none' || form.style.display === '') {
              form.style.display = 'block';
          } else {
           form.style.display = 'none';
          }
      }
   }

   function toggleUpdateForm(commentNum) {
      const form = document.getElementById('updateForm-' + commentNum);
      if (form) {
          if (form.style.display === 'none' || form.style.display === '') {
              form.style.display = 'block';
          } else {
           form.style.display = 'none';
          }
      }
   }
   function toggleReplyForm(commentNum) {
       const form = document.getElementById('replyForm-' + commentNum);
       if (form) {
           if (form.style.display === 'none' || form.style.display === '') {
               form.style.display = 'block';
           } else {
            form.style.display = 'none';
           }
       }
   }

   const currentCommuNum = ${commu.commuNum};  // 게시글 번호 JS 변수

    function showEditForm(commentNum) {
        const commentDiv = document.getElementById('comment-' + commentNum);
        const originalContent = commentDiv.querySelector('.comment-content').innerText;

        commentDiv.innerHTML = `
            <form method="post" action="/community/commentUpdate">
                <input type="hidden" name="commentNum" value="${commentNum}">
                <input type="hidden" name="commuNum" value="${currentCommuNum}">
                <textarea name="commentContents">${originalContent}</textarea>
                <button type="submit">수정 완료</button>
                <button type="button" onclick="cancelEdit(${commentNum})">취소</button>
            </form>
        `;
    }

    function cancelEdit(commentNum) {
        location.reload();
    }
    // 좋아요 토글 함수
    function toggleLike(commuNum) {
        $.ajax({
            url: '/community/good/ajax/' + commuNum,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    updateLikeButton(commuNum, response.isLiked, response.likeCount);
                } else {
                    alert(response.message || '오류가 발생했습니다.');
                    if (response.message === '로그인이 필요합니다.') {
                        window.location.href = '/login';
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error('좋아요 요청 실패:', error);
                alert('네트워크 오류가 발생했습니다.');
            }
        });
    }

    // 좋아요 버튼과 좋아요 개수 업데이트 함수
    function updateLikeButton(commuNum, isLiked, likeCount) {
        const likeBtn = $('#likeBtn-' + commuNum);

        if (isLiked) {
            likeBtn.addClass('liked');
            likeBtn.html('<i class="fas fa-heart"></i> 좋아요 (' + likeCount + ')');
        } else {
            likeBtn.removeClass('liked');
            likeBtn.html('<i class="far fa-heart"></i> 좋아요 (' + likeCount + ')');
        }
    }

    // 페이지 로드시 현재 좋아요 상태 로드
    function loadLikeStatus(commuNum) {
        $.ajax({
            url: '/community/like/status/' + commuNum,
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                updateLikeButton(commuNum, response.isLiked, response.likeCount);
            },
            error: function(xhr, status, error) {
                console.error('좋아요 상태 로드 실패:', error);
            }
        });
    }

    $(document).ready(function() {
        const commuNum = $('#commuNum').val();
        if (commuNum) {
            loadLikeStatus(commuNum);
        }
    });
    

      function cancelEdit(commentNum) {
        document.getElementById(`editForm-${commentNum}`).style.display = 'none';
        document.querySelector(`#comment-${commentNum} .content`).style.display = 'block';
      }
</script>

</body>
</html>