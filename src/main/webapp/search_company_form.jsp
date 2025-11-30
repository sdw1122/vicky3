<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.CompanyDAO" %>
<%@ page import="java.util.List" %>

<%
    // 검색 조건 유지를 위한 파라미터 수신
    request.setCharacterEncoding("UTF-8");
    String scCountry = request.getParameter("country");
    String scName = request.getParameter("name");
    String scApplied = request.getParameter("applied");
    String scIndustrial = request.getParameter("industrial");
    String scLuxury = request.getParameter("luxuryStatus");

    // 국가 목록 조회를 위한 DAO 호출 (이 폼이 어디에 포함되든 독립적으로 작동)
    CompanyDAO searchFormDao = new CompanyDAO();
    List<String> searchFormCountryList = searchFormDao.getCountryList();
%>

<form action="company_history.jsp" method="get" class="tm-search-form tm-section-pad-2">
    <div class="form-row tm-search-form-row">
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
            <select name="country" class="form-control tm-select">
                <option value="ALL">전체 국가</option>
                <% for(String c : searchFormCountryList) { %>
                    <option value="<%= c %>" <%= c.equals(scCountry) ? "selected" : "" %>><%= c %></option>
                <% } %>
            </select>
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-diamond fa-2x tm-form-element-icon"></i>
            <select name="luxuryStatus" class="form-control tm-select">
                <option value="ALL">고품격 상품 (전체)</option>
                <option value="Y" <%= "Y".equals(scLuxury) ? "selected" : "" %>>있음</option>
                <option value="N" <%= "N".equals(scLuxury) ? "selected" : "" %>>없음</option>
            </select>
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-building fa-2x tm-form-element-icon"></i>
            <input name="name" type="text" class="form-control" placeholder="기업명 검색..." value="<%= scName != null ? scName : "" %>">
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <button type="submit" class="btn btn-primary tm-btn-search">검색하기</button>
        </div>
    </div>
    
    <div class="form-row tm-search-form-row mt-3">
         <div class="form-group tm-form-element tm-form-element-50">
            <i class="fa fa-industry fa-2x tm-form-element-icon"></i>
            <input name="applied" type="text" class="form-control" placeholder="적용 건물 (예: 철도)" value="<%= scApplied != null ? scApplied : "" %>">
        </div>
        <div class="form-group tm-form-element tm-form-element-50">
            <i class="fa fa-cogs fa-2x tm-form-element-icon"></i>
            <input name="industrial" type="text" class="form-control" placeholder="산업권 건물 (예: 제강소)" value="<%= scIndustrial != null ? scIndustrial : "" %>">
        </div>
    </div>
    
    <div class="form-row clearfix pl-2 pr-2 tm-fx-col-xs">
        <p class="tm-margin-b-0">원하는 조건의 역사적 기업을 검색해 보세요.</p>
    </div>
</form>