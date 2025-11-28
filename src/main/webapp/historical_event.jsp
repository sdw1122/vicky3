<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.HistoricalEventDAO" %>
<%@ page import="com.vicky.dto.HistoricalEventDTO" %>
<%@ page import="java.util.List" %>
<jsp:include page="header.jsp" />

<div class="tm-section tm-bg-img" id="tm-section-1" style="padding-top: 100px; padding-bottom: 50px; height: auto;">
    <div class="tm-bg-white ie-container-width-fix-2">
        <div class="container ie-h-align-center-fix">
            <div class="row">
                <div class="col-xs-12 ml-auto mr-auto ie-container-width-fix">
                    
                    <jsp:include page="search_event_form.jsp" />
                    
                </div>                        
            </div>      
        </div>
    </div>                  
</div>

<%
    // 파라미터 수신 (검색 결과 조회용)
    // search_form.jsp 내부의 파라미터 수신은 화면 표시용이고, 여기서는 실제 DB 조회를 위해 다시 받습니다.
    String countryId = request.getParameter("adult");     
    String startYear = request.getParameter("check-in");  
    String endYear = request.getParameter("check-out");   
    String typeId = request.getParameter("event_type");   

    // DB 검색 수행
    HistoricalEventDAO dao = new HistoricalEventDAO();
    List<HistoricalEventDTO> events = dao.searchEvents(countryId, startYear, endYear, typeId);
%>

<div class="tm-section">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="tm-section-title">검색 결과</h2>
                <% if(events.isEmpty()) { %>
                    <p class="text-center">조건에 맞는 이벤트가 없습니다.</p>
                <% } else { %>
                    <table class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th>연도</th>
                                <th>국가</th>
                                <th>이벤트</th>
                                <th>대상/비고</th>
                                <th>유형</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(HistoricalEventDTO evt : events) { %>
                            <tr>
                                <td><%= evt.getYear() %></td>
                                <td><%= evt.getCountry() %></td>
                                <td class="font-weight-bold"><%= evt.getEventName() %></td>
                                <td><%= evt.getTarget() %></td>
                                <td><span class="badge badge-secondary"><%= evt.getEventType() %></span></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />