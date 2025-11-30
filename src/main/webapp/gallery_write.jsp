<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vicky.dao.CompanyDAO"%>
<%@ page import="com.vicky.dto.CompanyDTO"%>
<%@ page import="com.vicky.dto.CombinationDTO"%>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
%>
    <script>
        alert('로그인이 필요합니다.');
        location.href='login.jsp';
    </script>
<%
        return;
    }
    
    // DAO를 통해 저장된 조합 목록 가져오기
    CompanyDAO companyDao = new CompanyDAO();
    List<CombinationDTO> myCombs = companyDao.getCombinationHistory(userID);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vicky Archive - 갤러리 글쓰기</title>
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/tooplate-style.css">
    
    <script>
        // 조합 선택 시 본문에 내용 자동 입력하는 함수
        function loadCombination() {
            var select = document.getElementById("combinationSelect");
            var selectedOption = select.options[select.selectedIndex];
            
            if (selectedOption.value === "") return;

            // data-info 속성에서 조합 정보 가져오기
            var combInfo = selectedOption.getAttribute("data-info");
            var contentArea = document.getElementById("content");

            // 본문에 내용 추가
            if(contentArea.value.trim() !== "") {
                if(confirm("본문 내용 뒤에 선택한 조합 정보를 추가하시겠습니까?")) {
                    contentArea.value += "\n\n" + combInfo;
                }
            } else {
                contentArea.value = combInfo;
            }
        }
    </script>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="tm-section tm-bg-img" id="tm-section-1" style="height: 200px;"></div>

    <div class="tm-section tm-section-pad tm-bg-gray">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-10 col-lg-8 ml-auto mr-auto">
                    
                    <div class="tm-bg-white tm-p-4 tm-bg-white-shadow">
                        <h2 class="tm-section-title tm-color-primary mb-4 text-center" style="font-size: 2rem;">스크린샷 게시</h2>
                        <p class="text-center mb-5" style="color: #898989;">나만의 제국과 기업 조합을 공유해보세요.</p>
                        
                        <form action="gallery_write_process.jsp" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="writer_id" value="<%= userID %>">
                            
                            <div class="form-group">
                                <label for="title" class="tm-color-primary" style="font-weight:600;">제목</label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" required>
                            </div>

                            <div class="form-group" style="margin-bottom: 30px;">
                                <label for="combinationSelect" class="tm-color-primary" style="font-weight:600;">
                                    나의 저장된 기업 조합 불러오기
                                </label>
                                <select class="form-control tm-select" id="combinationSelect" onchange="loadCombination()" style="height: 45px;">
                                    <option value="">-- 조합을 선택하면 본문에 내용이 자동 입력됩니다 --</option>
                                    <%
                                        if (myCombs != null && !myCombs.isEmpty()) {
                                            for (CombinationDTO comb : myCombs) {
                                                // 각 조합별 상세 아이템(기업) 가져오기
                                                List<CompanyDTO> items = companyDao.getCombinationItems(comb.getLogId());
                                                
                                                // 본문에 넣을 텍스트 생성
                                                StringBuilder sb = new StringBuilder();
                                                sb.append("[기업 조합 공유]\n");
                                                sb.append("■ 조합명: ").append(comb.getCombinationName()).append("\n");
                                                sb.append("■ 구성 기업:\n");
                                                
                                                String companiesStr = "";
                                                if (items != null) {
                                                    for (CompanyDTO item : items) {
                                                        sb.append(" - ").append(item.getName())
                                                          .append(" (").append(item.getCountry()).append(") : ")
                                                          .append(item.getProsperityEffect()).append("\n");
                                                        
                                                        // 옵션 표시용 짧은 문자열
                                                        if (companiesStr.length() > 0) companiesStr += ", ";
                                                        companiesStr += item.getName();
                                                    }
                                                }
                                                String info = sb.toString();
                                                // 옵션 텍스트가 너무 길면 자르기
                                                if (companiesStr.length() > 30) companiesStr = companiesStr.substring(0, 30) + "...";
                                    %>
                                        <option value="<%= comb.getLogId() %>" data-info="<%= info %>">
                                            <%= comb.getCombinationName() %> [<%= companiesStr %>]
                                        </option>
                                    <%
                                            }
                                        } else {
                                    %>
                                        <option value="" disabled>저장된 조합이 없습니다.</option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="content" class="tm-color-primary" style="font-weight:600;">내용</label>
                                <textarea class="form-control" id="content" name="content" rows="8" placeholder="내용을 입력하세요." required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="fileName" class="tm-color-primary" style="font-weight:600;">이미지 파일</label>
                                <input type="file" class="form-control-file" id="fileName" name="fileName" required style="font-size: 0.9rem;">
                            </div>

                            <div class="text-center" style="margin-top: 40px;">
                                <button type="submit" class="btn btn-primary tm-btn-primary" style="width: auto; display: inline-block; padding: 12px 40px;">등록하기</button>
                                <a href="gallery.jsp" class="btn btn-primary tm-btn-white-bordered" style="color: #ee5057; border-color: #ee5057; margin-left: 10px;">취소</a>
                            </div>
                        </form>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>