<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.vicky.dao.CompanyDAO"%>
<%@ page import="com.vicky.dto.CompanyDTO"%>
<%@ page import="com.vicky.dto.CombinationDTO"%>
<%@ page import="java.text.SimpleDateFormat"%>

<jsp:include page="header.jsp" />

<%
    String memberId = (String) session.getAttribute("userID");
    if(memberId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CompanyDAO dao = new CompanyDAO();
    List<CombinationDTO> historyList = dao.getCombinationHistory(memberId);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<div class="tm-section tm-section-pad tm-bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="tm-section-title tm-color-primary mb-5 text-center navbar-brand mr-auto" style="color:black">빅토리아3 기업 포트폴리오 만들기</h2>
                
                <div style="text-align: right; margin-bottom: 20px;">
                    <a href="company_history.jsp" class="btn btn-primary">새로운 조합 만들기</a>
                </div>

                <% if(historyList != null && historyList.size() > 0) { 
                    for(CombinationDTO log : historyList) {
                        List<CompanyDTO> items = dao.getCombinationItems(log.getLogId());
                %>
                    <div class="tm-bg-white tm-p-4 tm-bg-white-shadow" style="margin-bottom: 30px;">
                        <h4 style="border-bottom: 2px solid #ddd; padding-bottom: 10px;">
                            <%= log.getCombinationName() %> 
                            <small class="text-muted" style="font-size: 0.6em; float: right; margin-top: 10px;">
                                저장일: <%= sdf.format(log.getRegDate()) %>
                            </small>
                        </h4>
                        
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead class="thead-light">
                                    <tr>
                                        <th>국가</th>
                                        <th>기업명</th>
                                        <th>번영 효과</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for(CompanyDTO item : items) { %>
                                    <tr>
                                        <td><%= item.getCountry() %></td>
                                        <td><%= item.getName() %></td>
                                        <td><small><%= item.getProsperityEffect() %></small></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <% 
                    }
                } else { 
                %>
                    <div class="tm-bg-white tm-p-4 tm-bg-white-shadow text-center">
                        <h4>저장된 조합이 없습니다.</h4>
                        <p>기업 목록에서 마음에 드는 기업을 선택해 저장해보세요.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />