<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.vicky.dao.CompanyDAO"%>
<%@ page import="com.vicky.dto.CompanyDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Victoria 3 Company List</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/tooplate-style.css">
<style>
    .container-fluid { padding: 30px; }
    h2 { margin-bottom: 20px; color: #333; }
    table { font-size: 14px; }
    th { background-color: #f8f9fa; text-align: center; }
    td { vertical-align: middle !important; }
</style>
</head>
<body>

    <%-- <jsp:include page="header.jsp" /> --%>

    <div class="container-fluid">
        <h2>📊 빅토리아 3 기업 DB 목록</h2>
        
        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th style="width: 5%">ID</th>
                        <th style="width: 10%">국가</th>
                        <th style="width: 15%">기업명 (한글)</th>
                        <th style="width: 15%">기업명 (영문)</th>
                        <th style="width: 15%">적용 건물</th>
                        <th style="width: 15%">산업 건물</th>
                        <th style="width: 10%">고품격 상품</th>
                        <th style="width: 15%">번영 효과</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        CompanyDAO dao = new CompanyDAO();
                        List<CompanyDTO> list = dao.getList();
                        
                        if(list != null && list.size() > 0) {
                            for(CompanyDTO dto : list) {
                    %>
                    <tr>
                        <td class="text-center"><%= dto.getId() %></td>
                        <td class="text-center font-weight-bold"><%= dto.getCountry() %></td>
                        <td><%= dto.getName() %></td>
                        <td><%= dto.getEnglishName() %></td>
                        <td><%= dto.getAppliedBuildings() %></td>
                        <td><%= dto.getIndustrialBuildings() %></td>
                        <td class="text-center"><%= dto.getLuxuryProduct() %></td>
                        <td><small><%= dto.getProsperityEffect() %></small></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" class="text-center">데이터가 없습니다. DB 연결이나 데이터를 확인해주세요.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-primary">메인으로 돌아가기</a>
        </div>
    </div>

    <%-- <jsp:include page="footer.jsp" /> --%>

</body>
</html>