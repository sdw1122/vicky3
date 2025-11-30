package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.vicky.dto.CompanyDTO;

public class CompanyDAO {
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, UID, PWD);
    }
    
    public void insertCompany(CompanyDTO dto) {
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
    
    public List<CompanyDTO> getFavoriteCompanies(String idListStr) {
        List<CompanyDTO> list = new ArrayList<>();
        
        if (idListStr == null || idListStr.trim().isEmpty()) {
            return list;
        }

        String safeIds = idListStr.replaceAll("[^0-9,]", "");
        if (safeIds.isEmpty()) return list;

        String sql = "SELECT * FROM VICKY_COMPANY WHERE ID IN (" + safeIds + ") ORDER BY COUNTRY ASC, NAME ASC";

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
    
    
    public boolean saveCombination(String memberId, String name, String[] companyIds) {
        String masterSql = "INSERT INTO COMBINATION_LOG (MEMBER_ID, COMBINATION_NAME) VALUES (?, ?)";
        String detailSql = "INSERT INTO COMBINATION_ITEMS (LOG_ID, COMPANY_ID) VALUES (?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            pstmt = conn.prepareStatement(masterSql, java.sql.Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, memberId);
            pstmt.setString(2, (name == null || name.trim().isEmpty()) ? "나만의 조합" : name);
            pstmt.executeUpdate();
            
            rs = pstmt.getGeneratedKeys();
            int logId = 0;
            if (rs.next()) {
                logId = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            if (companyIds != null && companyIds.length > 0) {
                pstmt = conn.prepareStatement(detailSql);
                for (String companyId : companyIds) {
                    if (companyId == null || companyId.trim().isEmpty()) continue;
                    try {
                        pstmt.setInt(1, logId);
                        pstmt.setInt(2, Integer.parseInt(companyId.trim()));
                        pstmt.addBatch();
                    } catch (NumberFormatException nfe) { continue; }
                }
                pstmt.executeBatch();
            }
            
            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch(Exception ex) {}
            return false;
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch(Exception e) {}
        }
    }

    public List<com.vicky.dto.CombinationDTO> getCombinationHistory(String memberId) {
        List<com.vicky.dto.CombinationDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM COMBINATION_LOG WHERE MEMBER_ID = ? ORDER BY LOG_ID DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, memberId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    com.vicky.dto.CombinationDTO dto = new com.vicky.dto.CombinationDTO();
                    dto.setLogId(rs.getInt("LOG_ID"));
                    dto.setMemberId(rs.getString("MEMBER_ID"));
                    dto.setCombinationName(rs.getString("COMBINATION_NAME"));
                    dto.setRegDate(rs.getTimestamp("REG_DATE"));
                    list.add(dto);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<CompanyDTO> getCombinationItems(int logId) {
        List<CompanyDTO> list = new ArrayList<>();
        String sql = "SELECT C.* FROM VICKY_COMPANY C " +
                     "JOIN COMBINATION_ITEMS I ON C.ID = I.COMPANY_ID " +
                     "WHERE I.LOG_ID = ? " +
                     "ORDER BY C.COUNTRY ASC, C.NAME ASC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, logId);
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