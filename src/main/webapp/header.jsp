<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String language = request.getParameter("language");
    if(language != null && !language.isEmpty()) {
        session.setAttribute("language", language);
    } 
    else {
        language = (String) session.getAttribute("language");
        if(language == null) {
            language = "ko";
        }
    }
%>

<fmt:setLocale value="<%=language %>" />


<fmt:bundle basename="bundle.message">

<!DOCTYPE html>
<html lang="<%=language %>">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><fmt:message key="welcome.title"/></title> <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick-theme.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/datepicker.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tooplate-style.css">
</head>

<body>
	<%
	    String userID = (String) session.getAttribute("userID");
	    String userName = (String) session.getAttribute("userName");
	%>
    <div class="tm-main-content" id="top">
        <div class="tm-top-bar-bg"></div>
        <div class="tm-top-bar" id="tm-top-bar">
            <div class="container">
                <div class="row">
                    <nav class="navbar navbar-expand-lg narbar-light">
                 
                        <a class="navbar-brand mr-auto" href="index.jsp">
                            <img src="${pageContext.request.contextPath}/img/logo.png" alt="Site logo">
                            <fmt:message key="header.brand"/>
                        </a>
      
                        <button type="button" id="nav-toggle" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#mainNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                    	<div class="row">
				            <div class="col text-right" style="text-align: right; margin-bottom: 20px;">
				                <a href="?language=ko" class="<%= "ko".equals(language) ? "font-weight-bold" : "" %>">Korean</a> | 
				                <a href="?language=en" class="<%= "en".equals(language) ? "font-weight-bold" : "" %>">English</a>
				            </div>
				        </div>
                        <div id="mainNav" class="collapse navbar-collapse tm-bg-white">
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp"><fmt:message key="menu.home"/></a>
                                </li>
                           
                                <li class="nav-item">
                                    <a class="nav-link" href="gallery.jsp"><fmt:message key="section.screenshot.title"/></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="historical_event.jsp"><fmt:message key="section.event.title"/></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="company_history.jsp"><fmt:message key="section.company.title"/></a>
                                </li>
                    
                                <% if (userID == null) { %>
							        <li class="nav-item">
                                        <a class="nav-link" href="login.jsp"><fmt:message key="menu.login"/></a>
                                    </li>
							    <% } else { %>
							        <li class="nav-item">
                                        <a class="nav-link" href="logout.jsp"><fmt:message key="menu.logout"/></a>
                                    </li>
							    <% } %>
                            </ul>
                        </div>                            
                    </nav>            
                </div>
            </div>
        </div>
        </fmt:bundle>