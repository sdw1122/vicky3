<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<script type="text/javascript">
    function checkLogin() {
        var form = document.loginForm;

        // 1. 아이디 입력 유무 확인 (Ch08 예제 8-2 참고)
        if (form.id.value == "") {
            alert("아이디를 입력해주세요.");
            form.id.focus();
            return false;
        }

        // 2. 비밀번호 입력 유무 확인 (Ch08 예제 8-2 참고)
        if (form.passwd.value == "") {
            alert("비밀번호를 입력해주세요");
            form.passwd.focus();
            return false;
        }

        // 3. 아이디 길이 확인 (Ch08 예제 8-3 참고)
        // 아이디는 4~12자 이내로 입력해야 한다는 규칙 적용
        if (form.id.value.length < 4 || form.id.value.length > 12) {
            alert("아이디는 4~12자 이내로 입력 가능합니다!");
            form.id.select();
            return false;
        }

        // 유효성 검사 통과 시 전송
        form.submit();
    }
</script>

<div class="container" style="margin-top: 50px; margin-bottom: 50px;">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center">
                    <h3>로그인</h3>
                </div>
                <div class="card-body">
                    <form name="loginForm" action="login_process.jsp" method="post">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">아이디</label>
                            <div class="col-sm-9">
                                <input type="text" name="id" class="form-control" placeholder="아이디">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" name="passwd" class="form-control" placeholder="비밀번호">
                            </div>
                        </div>
                        <div class="form-group row text-center">
                            <div class="col-sm-12">
                                <div class="form-group row text-center">
								    <div class="col-sm-12">
								        <input type="button" class="btn btn-primary" value="로그인" onclick="checkLogin()">
								        <a href="register.jsp" class="btn btn-success">회원가입</a> </div>
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

</body>
</html>