<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<script type="text/javascript">
    function checkForm() {
        var form = document.memberForm;
        var id = form.id.value;
        var passwd = form.passwd.value;
        var name = form.name.value;

        // 1. 아이디 체크 (4~12자)
        if (id.length < 4 || id.length > 12) {
            alert("아이디는 4~12자 이내로 입력해주세요.");
            form.id.select();
            return false;
        }

        // 2. 비밀번호 체크 (필수 입력 및 길이 확인)
        if (passwd == "") {
            alert("비밀번호를 입력해주세요.");
            form.passwd.focus();
            return false;
        }
        if (passwd.length < 4) {
             alert("비밀번호는 4자 이상이어야 합니다.");
             form.passwd.focus();
             return false;
        }

        var regExpName = /^[가-힣]*$/;
        if (name == "") {
            alert("닉네임을 입력해주세요.");
            form.name.focus();
            return false;
        }
        if (!regExpName.test(name)) {
            alert("닉네임은 한글만 입력해주세요!");
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
                    <h3>회원가입</h3>
                </div>
                <div class="card-body">
                    <form name="memberForm" action="register_process.jsp" method="post">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">아이디</label>
                            <div class="col-sm-9">
                                <input type="text" name="id" class="form-control" placeholder="아이디 (4~12자)">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" name="passwd" class="form-control" placeholder="비밀번호 (4자 이상)">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">이름</label>
                            <div class="col-sm-9">
                                <input type="text" name="name" class="form-control" placeholder="이름 (한글)">
                            </div>
                        </div>
                        <div class="form-group row text-center">
                            <div class="col-sm-12">
                                <input type="button" class="btn btn-primary" value="가입하기" onclick="checkForm()">
                                <input type="reset" class="btn btn-secondary" value="다시작성">
                                <a href="login.jsp" class="btn btn-outline-secondary">취소</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />