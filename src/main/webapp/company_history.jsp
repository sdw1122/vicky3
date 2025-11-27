<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.vicky.dao.CompanyDAO"%>
<%@ page import="com.vicky.dto.CompanyDTO"%>

<jsp:include page="header.jsp" />

<%
    // 파라미터 받기
    String pCountry = request.getParameter("country");
    String pName = request.getParameter("name");
    String pApplied = request.getParameter("applied");
    String pIndustrial = request.getParameter("industrial");
    String pLuxury = request.getParameter("luxuryStatus");
    
    // 모드 확인 (my_fav: 나만의 조합 보기)
    String mode = request.getParameter("mode");

    CompanyDAO dao = new CompanyDAO();
    List<String> countryList = dao.getCountryList(); // 국가 목록
    
    List<CompanyDTO> list = null;

    if ("my_fav".equals(mode)) {
        // 쿠키에서 즐겨찾기 ID 목록 읽기
        String favIds = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("myFavCompanies".equals(c.getName())) {
                    // 쿠키 값 디코딩 (특수문자 처리 등 안전장치)
                    favIds = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
                    break;
                }
            }
        }
        // 즐겨찾기 목록 조회
        list = dao.getFavoriteCompanies(favIds);
    } else {
        // 기존 검색 로직 수행
        list = dao.searchCompanies(pCountry, pName, pApplied, pIndustrial, pLuxury);
    }
%>

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

<div class="tm-section tm-section-pad tm-bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="tm-section-title tm-color-primary mb-5 text-center" style="color: black;">Historical Companies DB</h2>
                <div class="form-group tm-form-element tm-form-element-2" style="margin-left: 10px;">
						    <% if ("my_fav".equals(mode)) { %>
						        <a href="company_history.jsp" class="btn btn-secondary tm-btn-search">전체 목록 돌아가기</a>
						    <% } else { %>
						        <a href="company_history.jsp?mode=my_fav" class="btn btn-warning tm-btn-search" style="color: white;">나만의 조합 보기</a>
						    <% } %>
						</div>
                <div class="tm-bg-white tm-p-4 tm-bg-white-shadow">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
						    <thead class="thead-dark">
						        <tr>
						            <th style="width: 10%" class="text-center">국가</th>
						            <th style="width: 25%">기업명</th>
						            <th style="width: 20%">적용 건물</th>
						            <th style="width: 15%">산업권 건물</th>
						            <th style="width: 10%" class="text-center">고품격 상품</th>
						            <th style="width: 15%">번영 효과</th>
						            <th style="width: 5%" class="text-center">선택</th>
						        </tr>
						    </thead>
						    <tbody>
						        <%
						            // 리스트 조회 로직 (기존 코드 유지)
									list = dao.searchCompanies(pCountry, pName, pApplied, pIndustrial, pLuxury);
						            if(list != null && list.size() > 0) {
						                for(CompanyDTO dto : list) {
						        %>
						        <tr>
						            <td class="text-center font-weight-bold"><%= dto.getCountry() %></td>
						            <td>
						                <span class="tm-color-primary font-weight-bold"><%= dto.getName() %></span><br>
						                <small class="text-muted"><%= dto.getEnglishName() %></small>
						            </td>
						            <td><%= dto.getAppliedBuildings() %></td>
						            <td><%= dto.getIndustrialBuildings() %></td>
						            <td class="text-center">
						                <% if(dto.getLuxuryProduct() != null && !dto.getLuxuryProduct().equals("―") && !dto.getLuxuryProduct().isEmpty()) { %>
						                    <span class="badge badge-warning"><%= dto.getLuxuryProduct() %></span>
						                <% } else { %>
						                    <span class="text-muted">-</span>
						                <% } %>
						            </td>
						            <td><small><%= dto.getProsperityEffect() %></small></td>
						            <td class="text-center">
						                <input type="checkbox" name="selectedCompany" value="<%= dto.getId() %>" onclick="toggleFavorite(this)">
						            </td>
						        </tr>
						        <%
						                }
						            } else {
						        %>
						        <tr>
						            <td colspan="7" class="text-center py-5">
						                <% if ("my_fav".equals(mode)) { %>
						                    <h4>저장된 기업 조합이 없습니다.</h4>
						                    <p class="text-muted">기업 목록에서 체크박스를 선택해 나만의 조합을 만들어보세요.</p>
						                <% } else { %>
						                    <h4>검색 결과가 없습니다.</h4>
						                    <p class="text-muted">다른 조건으로 검색해 보세요.</p>
						                <% } %>
						            </td>
						        </tr>
						        <%
						            }
						        %>
						</table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 쿠키 설정 함수
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    // 쿠키 조회 함수
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

    // 페이지 로드 시 실행: 쿠키에 저장된 기업 ID들을 읽어와 체크박스 상태 복원
    window.onload = function() {
        var savedIds = getCookie("myFavCompanies");
        if (savedIds) {
            // [수정] 쿠키 값을 디코딩하여 원래 문자열(콤마 포함)로 변환
            savedIds = decodeURIComponent(savedIds);
            
            var idArray = savedIds.split(",");
            for (var i = 0; i < idArray.length; i++) {
                var checkbox = document.querySelector('input[type="checkbox"][value="' + idArray[i] + '"]');
                if (checkbox) {
                    checkbox.checked = true;
                }
            }
        }
    };

    // 체크박스 클릭 시 실행: 개수 제한 확인 및 쿠키 업데이트
    function toggleFavorite(checkbox) {
        // 현재 체크된 박스들 가져오기
        var checkedBoxes = document.querySelectorAll('input[name="selectedCompany"]:checked');
        // 6개 초과 선택 방지
        if (checkedBoxes.length > 6) {
            alert("기업 조합은 최대 6개까지만 선택할 수 있습니다.");
            checkbox.checked = false;
            return;
        }

        // 선택된 ID들을 배열로 수집
        var idList = [];
        checkedBoxes.forEach(function(box) {
            idList.push(box.value);
        });
        
        // [수정] 배열을 콤마로 합친 후, 반드시 인코딩(encodeURIComponent)하여 저장
        // 이렇게 해야 서버(Java)의 URLDecoder와 호환되며, 콤마로 인한 쿠키 잘림 현상을 방지함
        setCookie("myFavCompanies", encodeURIComponent(idList.join(",")), 30);
    }
</script>

<jsp:include page="footer.jsp" />