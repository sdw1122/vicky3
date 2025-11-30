<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // 파라미터 수신 로직
    String countryId = request.getParameter("adult");
    String startYear = request.getParameter("check-in");  
    String endYear = request.getParameter("check-out");   
    String typeId = request.getParameter("event_type");

    if(countryId == null) countryId = "";
    if(startYear == null) startYear = "";
    if(endYear == null) endYear = "";
    if(typeId == null) typeId = "";
%>

<style>
    /* 화면 너비가 992px 이상(PC)일 때만 20% 너비(한 줄에 5개) 적용 */
    @media (min-width: 992px) {
        .tm-search-form .tm-form-element-20 {
            width: 20%;
        }
    }
</style>
<%
    String language = request.getParameter("language");
    if(language != null && !language.isEmpty()) {
        session.setAttribute("language", language);
    } else {
        language = (String) session.getAttribute("language");
        if(language == null) language = "ko";
    }
%>
<fmt:setLocale value="<%=language %>" />

<fmt:bundle basename="bundle.message">

<form action="historical_event.jsp" method="post" class="tm-search-form tm-section-pad-2">
    <div class="form-row tm-search-form-row">
        <div class="form-group tm-form-element tm-form-element-20">
            <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
            <select name="adult" class="form-control tm-select">
                <option value="" <%= "".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.all_countries"/></option> 
                <option value="1" <%= "1".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.uk"/></option>
                <option value="2" <%= "2".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.germany"/></option>
                <option value="3" <%= "3".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.russia"/></option>
                <option value="4" <%= "4".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.usa"/></option>
                <option value="5" <%= "5".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.france"/></option>
                <option value="6" <%= "6".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.austria"/></option>
                <option value="7" <%= "7".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.italy"/></option>
                <option value="8" <%= "8".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.china"/></option>
                <option value="9" <%= "9".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.japan"/></option>
                <option value="10" <%= "10".equals(countryId) ? "selected" : "" %>><fmt:message key="event.search.country.joseon"/></option>
            </select>
        </div>

        <div class="form-group tm-form-element tm-form-element-20">
            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
            <input name="check-in" type="text" class="form-control" placeholder="<fmt:message key='event.search.placeholder.start'/>" value="<%= startYear %>">
        </div>

        <div class="form-group tm-form-element tm-form-element-20">
            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
            <input name="check-out" type="text" class="form-control" placeholder="<fmt:message key='event.search.placeholder.end'/>" value="<%= endYear %>">
        </div>

        <div class="form-group tm-form-element tm-form-element-20">
             <i class="fa fa-2x fa-user tm-form-element-icon"></i> 
             <select name="event_type" class="form-control tm-select"> 
                <option value="" <%= "".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.all"/></option>
                <option value="1" <%= "1".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.conflict"/></option>
                <option value="2" <%= "2".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.war"/></option>
                <option value="3" <%= "3".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.treaty"/></option>
                <option value="4" <%= "4".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.society"/></option>
                <option value="5" <%= "5".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.culture"/></option>
                <option value="6" <%= "6".equals(typeId) ? "selected" : "" %>><fmt:message key="event.search.type.technology"/></option>
            </select>
        </div>

        <div class="form-group tm-form-element tm-form-element-20">
            <button type="submit" class="btn btn-primary tm-btn-search"><fmt:message key="event.search.btn"/></button>
        </div>
    </div>
    
    <div class="form-row clearfix pl-2 pr-2 tm-fx-col-xs">
        <p class="tm-margin-b-0"><fmt:message key="event.search.description"/></p>
    </div>
</form>

</fmt:bundle>