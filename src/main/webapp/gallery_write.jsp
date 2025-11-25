<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>갤러리 글쓰기 - Vicky Archive</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/tooplate-style.css">
</head>
<body>
    <div class="tm-main-content">
        <jsp:include page="header.jsp" />

        <div class="tm-section tm-section-pad tm-bg-gray">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="tm-bg-white p-5">
                            <h2 class="tm-color-primary mb-4">새 게시글 작성</h2>
                            
                            <form action="galleryUpload" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="title">제목</label>
                                    <input type="text" class="form-control" id="title" name="title" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="file">이미지 파일</label>
                                    <input type="file" class="form-control-file" id="file" name="file" accept="image/*">
                                </div>

                                <div class="form-group">
                                    <label for="content">내용</label>
                                    <textarea class="form-control" id="content" name="content" rows="6" required></textarea>
                                </div>

                                <div class="text-right">
                                    <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                                    <button type="submit" class="btn btn-primary tm-btn-primary">등록하기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </div>

    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>