<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.vicky.dao.CompanyDAO"%>
<%@ page import="com.vicky.dto.CompanyDTO"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>

<jsp:include page="header.jsp" />

<%
    // 1. 파라미터 수신 (검색 및 모드 설정)
    String pCountry = request.getParameter("country");
    String pName = request.getParameter("name");
    String pApplied = request.getParameter("applied");
    String pIndustrial = request.getParameter("industrial");
    String pLuxury = request.getParameter("luxuryStatus");
    String mode = request.getParameter("mode"); // 'my_fav'일 경우 나만의 조합 보기 (Basket)

    // 2. 로그인 여부 확인
    String memberId = (String) session.getAttribute("userID");

    CompanyDAO dao = new CompanyDAO();
    List<String> countryList = dao.getCountryList(); // 검색창 국가 옵션용
    List<CompanyDTO> list = null;

    // 3. 데이터 조회 로직 분기
    if ("my_fav".equals(mode)) {
        // [CASE A] 나만의 조합 보기 (Basket) 모드: 쿠키에서 목록 조회
        String favIds = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("myFavCompanies".equals(c.getName())) {
                    favIds = URLDecoder.decode(c.getValue(), "UTF-8");
                    break;
                }
            }
        }
        list = dao.getFavoriteCompanies(favIds);
    } else {
        // [CASE B] 일반 검색 모드 (기존 기능)
        list = dao.searchCompanies(pCountry, pName, pApplied, pIndustrial, pLuxury);
    }
%>

<% if (!"my_fav".equals(mode)) { %>
<div class="tm-section tm-bg-img" id="tm-section-1">
    <div class="tm-bg-white ie-container-width-fix-2">
        <div class="container ie-h-align-center-fix">
            <div class="row">
                <div class="col-xs-12 ml-auto mr-auto ie-container-width-fix">
                    <form action="company_history.jsp" method="get" class="tm-search-form tm-section-pad-2">
                        <div class="form-row tm-search-form-row">
                            <div class="form-group tm-form-element tm-form-element-2">
                                <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
                                <select name="country" class="form-control tm-select">
                                    <option value="ALL">전체 국가</option>
                                    <% for(String c : countryList) { %>
                                        <option value="<%= c %>" <%= c.equals(pCountry) ? "selected" : "" %>><%= c %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group tm-form-element tm-form-element-2">
                                <i class="fa fa-diamond fa-2x tm-form-element-icon"></i>
                                <select name="luxuryStatus" class="form-control tm-select">
                                    <option value="ALL">고품격 상품 (전체)</option>
                                    <option value="Y" <%= "Y".equals(pLuxury) ? "selected" : "" %>>있음</option>
                                    <option value="N" <%= "N".equals(pLuxury) ? "selected" : "" %>>없음</option>
                                </select>
                            </div>
                            <div class="form-group tm-form-element tm-form-element-2">
                                <i class="fa fa-building fa-2x tm-form-element-icon"></i>
                                <input name="name" type="text" class="form-control" placeholder="기업명 검색..." value="<%= pName != null ? pName : "" %>">
                            </div>
                            <div class="form-group tm-form-element tm-form-element-2">
                                <button type="submit" class="btn btn-primary tm-btn-search">검색하기</button>
                            </div>
                        </div>
                        <div class="form-row tm-search-form-row mt-3">
                             <div class="form-group tm-form-element tm-form-element-50">
                                <i class="fa fa-industry fa-2x tm-form-element-icon"></i>
                                <input name="applied" type="text" class="form-control" placeholder="적용 건물 (예: 철도)" value="<%= pApplied != null ? pApplied : "" %>">
                            </div>
                            <div class="form-group tm-form-element tm-form-element-50">
                                <i class="fa fa-cogs fa-2x tm-form-element-icon"></i>
                                <input name="industrial" type="text" class="form-control" placeholder="산업권 건물 (예: 제강소)" value="<%= pIndustrial != null ? pIndustrial : "" %>">
                            </div>
                        </div>
                    </form>
                </div>                        
            </div>      
        </div>
    </div>                  
</div>
<% } %>

<div class="tm-section tm-section-pad tm-bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                
                <% if ("my_fav".equals(mode)) { %>
                    <h2 class="tm-section-title tm-color-primary mb-5 text-center">Selected Companies (Basket)</h2>
                    <p class="text-center">이 중에서 <strong>최대 6개</strong>를 선택하여 조합을 저장하세요.</p>
                <% } else { %>
                    <h2 class="tm-section-title tm-color-primary mb-5 text-center navbar-brand mr-auto" style="color: black">빅토리아3 기업 리스트</h2>
                <% } %>

                <div class="text-right mb-3">
                    <% if ("my_fav".equals(mode)) { %>
                        <a href="company_history.jsp" class="btn btn-secondary">더 담으러 가기</a>
                    <% } else { %>
                        <% if(memberId != null) { %>
                            <a href="my_combinations.jsp" class="btn btn-info">내 저장된 조합 보기</a>
                        <% } %>
                        <a href="company_history.jsp?mode=my_fav" class="btn btn-warning" style="color: white;">
                            담은 기업 확인하기
                        </a>
                    <% } %>
                </div>

                <form action="<%= "my_fav".equals(mode) ? "save_combination_process.jsp" : "#" %>" method="post" onsubmit="return validateSelection()">
                    
                    <% if ("my_fav".equals(mode)) { %>
                        <% if (memberId == null) { %>
                            <div class="alert alert-danger text-center"><strong>조합 저장 기능은 로그인 후에 이용 가능합니다.</strong></div>
                        <% } %>
                        <div class="input-group mb-3" style="max-width: 500px; margin: 0 auto;">
                            <input type="text" name="combinationName" class="form-control" placeholder="조합 이름을 입력하세요 (선택 사항)">
                            <div class="input-group-append">
                                <button class="btn btn-success" type="submit" <%= memberId == null ? "disabled" : "" %>>선택한 기업 조합 저장</button>
                            </div>
                        </div>
                    <% } %>

                    <div class="tm-bg-white tm-p-4 tm-bg-white-shadow">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th style="width: 10%" class="text-center">국가</th>
							            <th style="width: 25%" class="text-center">기업명</th>
							            <th style="width: 20%" class="text-center">적용 건물</th>
							            <th style="width: 15%" class="text-center">산업권 건물</th>
							            <th style="width: 10%" class="text-center">고품격 상품</th>
							            <th style="width: 15%" class="text-center">번영 효과</th>
                                        <th style="width: 5%" class="text-center">
                                            <%= "my_fav".equals(mode) ? "저장 선택" : "담기" %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    if(list != null && list.size() > 0) {
                                        for(CompanyDTO dto : list) {
                                    %>
                                    <tr>
                                        <td class="text-center font-weight-bold"><%= dto.getCountry() %></td>
                                        <td>
                                            <strong><%= dto.getName() %></strong><br>
                                            <small><%= dto.getEnglishName() %></small>
                                        </td>
                                        <td><%= dto.getAppliedBuildings() %></td>
                                        <td><%= dto.getIndustrialBuildings() %></td>
                                        <td class="text-center"><% if(dto.getLuxuryProduct() != null && !dto.getLuxuryProduct().equals("―") && !dto.getLuxuryProduct().isEmpty()) { %>
						                    <span class="badge badge-warning"><%= dto.getLuxuryProduct() %></span>
						                <% } else { %>
						                    <span class="text-muted">-</span>
						                <% } %>
						                </td>
                                        <td><small><%= dto.getProsperityEffect() %></small></td>
                                        <td class="text-center">
                                            <% if ("my_fav".equals(mode)) { %>
                                                <input type="checkbox" name="finalSelection" value="<%= dto.getId() %>">
                                            <% } else { %>
                                                <input type="checkbox" name="selectedCompany" value="<%= dto.getId() %>" onclick="toggleCookie(this)">
                                            <% } %>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr><td colspan="6" class="text-center py-5">
                                        <% if ("my_fav".equals(mode)) { %>
                                            <h4>담은 기업이 없습니다.</h4>
                                            <p class="text-muted">전체 목록으로 돌아가 '담기' 체크박스를 이용해 기업을 추가하세요.</p>
                                        <% } else { %>
                                            <h4>검색 결과가 없습니다.</h4>
                                            <p class="text-muted">다른 조건으로 검색해 보세요.</p>
                                        <% } %>
                                    </td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<script>
    // 1. 쿠키 설정/조회 함수 (기존 유지)
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    // 2. 페이지 로드 시 '담기' 상태 복원
    window.onload = function() {
        var savedIds = getCookie("myFavCompanies");
        if (savedIds) {
            savedIds = decodeURIComponent(savedIds);
            var idArray = savedIds.split(",");
            // 일반 모드일 때만 체크박스 복원
            var boxes = document.getElementsByName("selectedCompany");
            if(boxes.length > 0) {
                for(var i=0; i<boxes.length; i++) {
                     if(idArray.includes(boxes[i].value)) boxes[i].checked = true;
                }
            }
        }
    };

    // 3. '담기' 체크박스 클릭 시 쿠키 업데이트 (Basket 기능)
    function toggleCookie(checkbox) {
        var checkedBoxes = document.querySelectorAll('input[name="selectedCompany"]:checked');
        var idList = [];
        checkedBoxes.forEach(function(box) { idList.push(box.value); });
        setCookie("myFavCompanies", encodeURIComponent(idList.join(",")), 30);
    }

    // 4. '저장하기' 버튼 클릭 시 유효성 검사 (Basket 화면에서 실행)
    function validateSelection() {
        <% if(memberId == null) { %>
            alert("로그인 후 조합을 저장할 수 있습니다.");
            location.href = "login.jsp";
            return false;
        <% } %>

        var checked = document.querySelectorAll('input[name="finalSelection"]:checked');
        if (checked.length === 0) {
            alert("저장할 기업을 최소 1개 이상 선택해주세요.");
            return false;
        }
        if (checked.length > 6) {
            alert("최대 6개까지만 선택할 수 있습니다.");
            return false;
        }
        return confirm("선택한 " + checked.length + "개 기업으로 조합을 저장하시겠습니까?");
    }
</script>

<jsp:include page="footer.jsp" />