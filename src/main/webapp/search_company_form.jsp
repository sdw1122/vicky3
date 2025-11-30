<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.CompanyDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
    request.setCharacterEncoding("UTF-8");
    String scCountry = request.getParameter("country");
    String scName = request.getParameter("name");
    String scApplied = request.getParameter("applied");
    String scIndustrial = request.getParameter("industrial");
    String scLuxury = request.getParameter("luxuryStatus");
    CompanyDAO searchFormDao = new CompanyDAO();
    List<String> searchFormCountryList = searchFormDao.getCountryList();
%>
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

<form action="company_history.jsp" method="post" class="tm-search-form tm-section-pad-2">
    <div class="form-row tm-search-form-row">
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
            <select name="country" class="form-control tm-select">
                <option value="ALL"><fmt:message key="company.search.all_countries"/></option>
                <% for(String c : searchFormCountryList) { %>
                <option value="<%= c %>" <%= c.equals(scCountry) ? "selected" : "" %>><%= c %></option>
                <% } %>
            </select>
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-diamond fa-2x tm-form-element-icon"></i>
            <select name="luxuryStatus" class="form-control tm-select">
                <option value="ALL"><fmt:message key="company.search.luxury.all"/></option>
                <option value="Y" <%= "Y".equals(scLuxury) ? "selected" : "" %>><fmt:message key="company.search.luxury.yes"/></option>
                <option value="N" <%= "N".equals(scLuxury) ? "selected" : "" %>><fmt:message key="company.search.luxury.no"/></option>
            </select>
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <i class="fa fa-building fa-2x tm-form-element-icon"></i>
            <input name="name" type="text" class="form-control" placeholder="<fmt:message key='company.search.placeholder.name'/>" value="<%= scName != null ? scName : "" %>">
        </div>
        <div class="form-group tm-form-element tm-form-element-2">
            <button type="submit" class="btn btn-primary tm-btn-search"><fmt:message key="company.search.btn"/></button>
        </div>
    </div>
    
    <div class="form-row tm-search-form-row mt-3">
         <div class="form-group tm-form-element tm-form-element-50">
            <i class="fa fa-industry fa-2x tm-form-element-icon"></i>
            <input name="applied" type="text" class="form-control" placeholder="<fmt:message key='company.search.placeholder.applied'/>" value="<%= scApplied != null ? scApplied : "" %>">
        </div>
  
       <div class="form-group tm-form-element tm-form-element-50">
            <i class="fa fa-cogs fa-2x tm-form-element-icon"></i>
            <input name="industrial" type="text" class="form-control" placeholder="<fmt:message key='company.search.placeholder.industrial'/>" value="<%= scIndustrial != null ? scIndustrial : "" %>">
        </div>
    </div>
    
    <div class="form-row clearfix pl-2 pr-2 tm-fx-col-xs">
        <p class="tm-margin-b-0"><fmt:message key="company.search.description"/></p>
    </div>
</form>

</fmt:bundle>