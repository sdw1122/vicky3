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
    
    CompanyDAO dao = new CompanyDAO();
    List<String> countryList = dao.getCountryList(); // 국가 목록
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
                                <input name="industrial" type="text" class="form-control" placeholder="산업 건물 (예: 제강소)" value="<%= pIndustrial != null ? pIndustrial : "" %>">
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
                
                <div class="tm-bg-white tm-p-4 tm-bg-white-shadow">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th style="width: 10%" class="text-center">국가</th>
                                    <th style="width: 25%">기업명</th>
                                    <th style="width: 20%">적용 건물</th>
                                    <th style="width: 20%">산업 건물</th>
                                    <th style="width: 10%" class="text-center">고품격 상품</th>
                                    <th style="width: 15%">번영 효과</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<CompanyDTO> list = dao.searchCompanies(pCountry, pName, pApplied, pIndustrial, pLuxury);
                                    
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
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center py-5">
                                        <h4>검색 결과가 없습니다.</h4>
                                        <p class="text-muted">다른 조건으로 검색해 보세요.</p>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />