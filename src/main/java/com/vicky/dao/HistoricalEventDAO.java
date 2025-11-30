package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.vicky.dto.HistoricalEventDTO;

public class HistoricalEventDAO {
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, UID, PWD);
    }

    // 데이터 업로드용 insert 메서드
    public void insertEvent(HistoricalEventDTO dto) {
        String sql = "INSERT INTO VICTORIA_EVENTS (COUNTRY, YEAR, EVENT_NAME, TARGET, EVENT_TYPE) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getCountry());
            pstmt.setInt(2, dto.getYear());
            pstmt.setString(3, dto.getEventName());
            pstmt.setString(4, dto.getTarget());
            pstmt.setString(5, dto.getEventType());
            pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 검색 메서드
    public List<HistoricalEventDTO> searchEvents(String countryId, String startYear, String endYear, String typeId) {
        List<HistoricalEventDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM VICTORIA_EVENTS WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (countryId != null && !countryId.isEmpty()) {
            String countryName = getCountryName(countryId);
            if (countryName != null) {
                sql.append(" AND COUNTRY = ?");
                params.add(countryName);
            }
        }

        if (startYear != null && !startYear.isEmpty()) {
            sql.append(" AND YEAR >= ?");
            params.add(Integer.parseInt(startYear));
        }
        if (endYear != null && !endYear.isEmpty()) {
            sql.append(" AND YEAR <= ?");
            params.add(Integer.parseInt(endYear));
        }

        if (typeId != null && !typeId.isEmpty()) {
            String typeName = getTypeName(typeId);
            if (typeName != null) {
                sql.append(" AND EVENT_TYPE = ?");
                params.add(typeName);
            }
        }

        sql.append(" ORDER BY YEAR ASC, COUNTRY ASC");

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    HistoricalEventDTO dto = new HistoricalEventDTO();
                    dto.setId(rs.getInt("ID"));
                    dto.setCountry(rs.getString("COUNTRY"));
                    dto.setYear(rs.getInt("YEAR"));
                    dto.setEventName(rs.getString("EVENT_NAME"));
                    dto.setTarget(rs.getString("TARGET"));
                    dto.setEventType(rs.getString("EVENT_TYPE"));
                    list.add(dto);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // home.jsp의 select option value를 실제 DB 텍스트로 변환
    private String getCountryName(String id) {
        switch (id) {
            case "1": return "영국";
            case "2": return "독일";
            case "3": return "러시아";
            case "4": return "미국";
            case "5": return "프랑스";
            case "6": return "오스트리아";
            case "7": return "이탈리아";
            case "8": return "중국";
            case "9": return "일본";
            case "10": return "조선";
            default: return null;
        }
    }

    private String getTypeName(String id) {
        switch (id) {
            case "1": return "분쟁";
            case "2": return "전쟁";
            case "3": return "조약";
            case "4": return "사회";
            case "5": return "문화";
            case "6": return "기술";
            default: return null;
        }
    }
}