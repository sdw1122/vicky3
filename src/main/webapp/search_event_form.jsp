<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 검색 상태 유지를 위한 파라미터 수신
    String countryId = request.getParameter("adult");     
    String startYear = request.getParameter("check-in");  
    String endYear = request.getParameter("check-out");   
    String typeId = request.getParameter("event_type");   

    // null 처리 (값이 없으면 빈 문자열로 설정)
    if(countryId == null) countryId = "";
    if(startYear == null) startYear = "";
    if(endYear == null) endYear = "";
    if(typeId == null) typeId = "";
%>

<form action="historical_event.jsp" method="get" class="tm-search-form tm-section-pad-2">
    <div class="form-row tm-search-form-row">
        <div class="form-group tm-form-element" style="width: 20%;">
            <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
            <select name="adult" class="form-control tm-select">
                <option value="" <%= "".equals(countryId) ? "selected" : "" %>>전체 국가</option> 
                <option value="1" <%= "1".equals(countryId) ? "selected" : "" %>>영국</option>
                <option value="2" <%= "2".equals(countryId) ? "selected" : "" %>>독일</option>
                <option value="3" <%= "3".equals(countryId) ? "selected" : "" %>>러시아</option>
                <option value="4" <%= "4".equals(countryId) ? "selected" : "" %>>미국</option>
                <option value="5" <%= "5".equals(countryId) ? "selected" : "" %>>프랑스</option>
                <option value="6" <%= "6".equals(countryId) ? "selected" : "" %>>오스트리아</option>
                <option value="7" <%= "7".equals(countryId) ? "selected" : "" %>>이탈리아</option>
                <option value="8" <%= "8".equals(countryId) ? "selected" : "" %>>중국</option>
                <option value="9" <%= "9".equals(countryId) ? "selected" : "" %>>일본</option>
                <option value="10" <%= "10".equals(countryId) ? "selected" : "" %>>조선</option>
            </select>
        </div>

        <div class="form-group tm-form-element" style="width: 20%;">
            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
            <input name="check-in" type="text" class="form-control" placeholder="시작 연도(1836~)" value="<%= startYear %>">
        </div>

        <div class="form-group tm-form-element" style="width: 20%;">
            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
            <input name="check-out" type="text" class="form-control" placeholder="종료 연도(~1936)" value="<%= endYear %>">
        </div>

        <div class="form-group tm-form-element" style="width: 20%;">
             <i class="fa fa-2x fa-user tm-form-element-icon"></i> 
             <select name="event_type" class="form-control tm-select"> 
                <option value="" <%= "".equals(typeId) ? "selected" : "" %>>전체 유형</option>
                <option value="1" <%= "1".equals(typeId) ? "selected" : "" %>>분쟁</option>
                <option value="2" <%= "2".equals(typeId) ? "selected" : "" %>>전쟁</option>
                <option value="3" <%= "3".equals(typeId) ? "selected" : "" %>>조약</option>
                <option value="4" <%= "4".equals(typeId) ? "selected" : "" %>>사회</option>
                <option value="5" <%= "5".equals(typeId) ? "selected" : "" %>>문화</option>
                <option value="6" <%= "6".equals(typeId) ? "selected" : "" %>>기술</option>
            </select>
        </div>

        <div class="form-group tm-form-element" style="width: 20%;">
            <button type="submit" class="btn btn-primary tm-btn-search">검색</button>
        </div>
    </div>
    
    <div class="form-row clearfix pl-2 pr-2 tm-fx-col-xs">
        <p class="tm-margin-b-0">원하는 국가의 역사적 이벤트를 검색해 보세요.</p>
    </div>
</form>