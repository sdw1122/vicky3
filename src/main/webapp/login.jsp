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

<jsp:include page="header.jsp" />

<script type="text/javascript">
    function checkLogin() {
        var form = document.loginForm;
        var msgIdEmpty = "<fmt:message key='login.alert.id.empty'/>";
        var msgPwEmpty = "<fmt:message key='login.alert.pw.empty'/>";
        var msgIdLength = "<fmt:message key='login.alert.id.length'/>";

        if (form.id.value == "") {
            alert(msgIdEmpty);
            form.id.focus();
            return false;
        }

        if (form.passwd.value == "") {
            alert(msgPwEmpty);
            form.passwd.focus();
            return false;
        }

        if (form.id.value.length < 4 || form.id.value.length > 12) {
            alert(msgIdLength);
            form.id.select();
            return false;
        }

        form.submit();
    }
</script>

<div class="container" style="margin-top: 50px; margin-bottom: 50px;">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center">
                    <h3><fmt:message key="login.title"/></h3>
                </div>
            
                <div class="card-body">
                    <form name="loginForm" action="login_process.jsp" method="post">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="login.label.id"/></label>
                            <div class="col-sm-9">
                                <input type="text" name="id" class="form-control" placeholder="<fmt:message key='login.placeholder.id'/>">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="login.label.password"/></label>
                            <div class="col-sm-9">
                                <input type="password" name="passwd" class="form-control" placeholder="<fmt:message key='login.placeholder.password'/>">
                            </div>
                        </div>
                        <div class="form-group row text-center">
                            <div class="col-sm-12">
                                <div class="form-group row text-center">
								    <div class="col-sm-12">
								        <input type="button" class="btn btn-primary" value="<fmt:message key='login.btn.login'/>" onclick="checkLogin()">
								        <a href="register.jsp" class="btn btn-success"><fmt:message key="login.btn.register"/></a>
									</div>
								</div>
                             </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

</fmt:bundle>
</body>
</html>