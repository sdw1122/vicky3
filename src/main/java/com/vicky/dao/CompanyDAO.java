package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.vicky.dto.CompanyDTO;

public class CompanyDAO {
    // DB 연결 정보 (기존 유지)
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, UID, PWD);
    }
    
    public void insertCompany(CompanyDTO dto) {
        // ENGLISH_NAME 컬럼 추가
        String sql = "INSERT INTO VICKY_COMPANY (COUNTRY, NAME, ENGLISH_NAME, APPLIED_BUILDINGS, INDUSTRIAL_BUILDINGS, LUXURY_PRODUCT, PROSPERITY_EFFECT) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, dto.getCountry());
            pstmt.setString(2, dto.getName());
            pstmt.setString(3, dto.getEnglishName());
            pstmt.setString(4, dto.getAppliedBuildings());
            pstmt.setString(5, dto.getIndustrialBuildings());
            pstmt.setString(6, dto.getLuxuryProduct());
            pstmt.setString(7, dto.getProsperityEffect());
            
            pstmt.executeUpdate();
            System.out.println("저장 완료: " + dto.getName() + " (" + dto.getEnglishName() + ")");
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("저장 실패: " + dto.getName());
        }
    }

    // [추가] 국가 목록 조회 (Select 박스용)
    public List<String> getCountryList() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT COUNTRY FROM VICKY_COMPANY ORDER BY COUNTRY ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("COUNTRY"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // [수정] 검색 기능 (고품격 상품 유무 필터 추가)
    public List<CompanyDTO> searchCompanies(String country, String name, String applied, String industrial, String luxuryStatus) {
        List<CompanyDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM VICKY_COMPANY WHERE 1=1");
        List<String> params = new ArrayList<>();

        if (country != null && !country.trim().isEmpty() && !country.equals("ALL")) {
            sql.append(" AND COUNTRY = ?");
            params.add(country);
        }
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND (NAME LIKE ? OR ENGLISH_NAME LIKE ?)");
            params.add("%" + name.trim() + "%");
            params.add("%" + name.trim() + "%");
        }
        if (applied != null && !applied.trim().isEmpty()) {
            sql.append(" AND APPLIED_BUILDINGS LIKE ?");
            params.add("%" + applied.trim() + "%");
        }
        if (industrial != null && !industrial.trim().isEmpty()) {
            sql.append(" AND INDUSTRIAL_BUILDINGS LIKE ?");
            params.add("%" + industrial.trim() + "%");
        }
        // 고품격 상품 유무 필터
        if ("Y".equals(luxuryStatus)) {
            sql.append(" AND LUXURY_PRODUCT IS NOT NULL AND LUXURY_PRODUCT <> '―' AND LUXURY_PRODUCT <> ''");
        } else if ("N".equals(luxuryStatus)) {
            sql.append(" AND (LUXURY_PRODUCT IS NULL OR LUXURY_PRODUCT = '―' OR LUXURY_PRODUCT = '')");
        }

        sql.append(" ORDER BY ID ASC");

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int index = 1;
            for (String param : params) {
                pstmt.setString(index++, param);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CompanyDTO dto = new CompanyDTO();
                    dto.setId(rs.getInt("ID"));
                    dto.setCountry(rs.getString("COUNTRY"));
                    dto.setName(rs.getString("NAME"));
                    dto.setEnglishName(rs.getString("ENGLISH_NAME"));
                    dto.setAppliedBuildings(rs.getString("APPLIED_BUILDINGS"));
                    dto.setIndustrialBuildings(rs.getString("INDUSTRIAL_BUILDINGS"));
                    dto.setLuxuryProduct(rs.getString("LUXURY_PRODUCT"));
                    dto.setProsperityEffect(rs.getString("PROSPERITY_EFFECT"));
                    list.add(dto);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}