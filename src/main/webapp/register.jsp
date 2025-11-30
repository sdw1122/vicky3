<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="header.jsp" />
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
<script type="text/javascript">
    function checkForm() {
        var form = document.memberForm;
        var id = form.id.value;
        var passwd = form.passwd.value;
        var passwdConfirm = form.passwdConfirm.value;
        var name = form.name.value;

        var msgIdLen = "<fmt:message key='register.alert.id.length'/>";
        var msgPwEmpty = "<fmt:message key='register.alert.pw.empty'/>";
        var msgPwLen = "<fmt:message key='register.alert.pw.length'/>";
        var msgPwMismatch = "<fmt:message key='register.alert.pw.mismatch'/>";
        var msgNameEmpty = "<fmt:message key='register.alert.name.empty'/>";
        var msgNameKo = "<fmt:message key='register.alert.name.korean'/>";

        if (id.length < 4 || id.length > 12) {
            alert(msgIdLen);
            form.id.select();
            return false;
        }

        if (passwd == "") {
            alert(msgPwEmpty);
            form.passwd.focus();
            return false;
        }
        if (passwd.length < 4) {
             alert(msgPwLen);
             form.passwd.focus();
             return false;
        }
        
        if (passwd != passwdConfirm) {
            alert(msgPwMismatch);
            form.passwdConfirm.select();
            return false;
        }

        var regExpName = /^[가-힣]*$/;
        if (name == "") {
            alert(msgNameEmpty);
            form.name.focus();
            return false;
        }
        if (!regExpName.test(name)) {
            alert(msgNameKo);
            form.name.select();
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
                    <h3><fmt:message key="register.title"/></h3>
                </div>
             
                <div class="card-body">
                    <form name="memberForm" action="register_process.jsp" method="post">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="register.label.id"/></label>
                 
                            <div class="col-sm-9">
                                <input type="text" name="id" class="form-control" placeholder="<fmt:message key='register.placeholder.id'/>">
                            </div>
                       
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="register.label.password"/></label>
                            <div class="col-sm-9">
              
                                <input type="password" name="passwd" class="form-control" placeholder="<fmt:message key='register.placeholder.password'/>">
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="register.label.passwordConfirm"/></label>
                            <div class="col-sm-9">
              
                                <input type="password" name="passwdConfirm" class="form-control" placeholder="<fmt:message key='register.placeholder.passwordConfirm'/>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><fmt:message key="register.label.name"/></label>
                            <div class="col-sm-9">
                                <input type="text" name="name" class="form-control" placeholder="<fmt:message key='register.placeholder.name'/>">
                            </div>
                        </div>
                        <div class="form-group row text-center">
                       
                             <div class="col-sm-12">
                                <input type="button" class="btn btn-primary" value="<fmt:message key='register.btn.submit'/>" onclick="checkForm()">
                                <input type="reset" class="btn btn-secondary" value="<fmt:message key='register.btn.reset'/>">
                     
                                <a href="login.jsp" class="btn btn-outline-secondary"><fmt:message key="register.btn.cancel"/></a>
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