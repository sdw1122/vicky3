package com.vicky.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.vicky.dto.GalleryDTO;

public class GalleryDAO {
    // PDF 환경에 맞춘 DB 연결 정보
    // serverTimezone=UTC 설정을 추가하여 8.0 버전에서 발생할 수 있는 시간대 오류 방지
	private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
    private final String UID = "root";
    private final String PWD = "1234"; // PDF 예제 비밀번호

    private Connection getConnection() throws Exception {
        // MySQL 8.0 이상 권장 드라이버 클래스
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        return DriverManager.getConnection(URL, UID, PWD);
    }

    // 게시글 저장
    public void insertGallery(GalleryDTO dto) {
        String sql = "INSERT INTO GALLERY_BOARD (TITLE, CONTENT, FILENAME) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getFileName());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시글 목록 조회
    public List<GalleryDTO> getList() {
        List<GalleryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM GALLERY_BOARD ORDER BY NO DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                GalleryDTO dto = new GalleryDTO();
                dto.setNo(rs.getInt("NO"));
                dto.setTitle(rs.getString("TITLE"));
                dto.setContent(rs.getString("CONTENT"));
                dto.setFileName(rs.getString("FILENAME"));
                dto.setRegDate(rs.getTimestamp("REGDATE"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}