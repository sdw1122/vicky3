package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

import com.vicky.dto.CompanyDTO;

public class CompanyDAO {
    // DB 연결 정보 (기존 유지)
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
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
    public List<CompanyDTO> getList() {
        List<CompanyDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM VICKY_COMPANY ORDER BY ID ASC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}