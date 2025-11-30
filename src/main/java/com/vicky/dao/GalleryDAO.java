package com.vicky.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.vicky.dto.GalleryDTO;

public class GalleryDAO {
	private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        return DriverManager.getConnection(URL, UID, PWD);
    }

    public void insertGallery(GalleryDTO dto) {
        String sql = "INSERT INTO GALLERY_BOARD (TITLE, CONTENT, FILENAME, WRITER, WRITER_ID) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getFileName());
            pstmt.setString(4, dto.getWriter());
            pstmt.setString(5, dto.getWriterId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

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
                dto.setWriter(rs.getString("WRITER"));
                dto.setRegDate(rs.getTimestamp("REGDATE"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public GalleryDTO getGallery(int no) {
        GalleryDTO dto = null;
        String sql = "SELECT * FROM GALLERY_BOARD WHERE NO = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, no);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new GalleryDTO();
                    dto.setNo(rs.getInt("NO"));
                    dto.setTitle(rs.getString("TITLE"));
                    dto.setContent(rs.getString("CONTENT"));
                    dto.setFileName(rs.getString("FILENAME"));
                    dto.setWriter(rs.getString("WRITER"));
                    dto.setWriterId(rs.getString("WRITER_ID"));
                    dto.setRegDate(rs.getTimestamp("REGDATE"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return dto;
    }
    
    public int deleteGallery(int no) {
        String sql = "DELETE FROM GALLERY_BOARD WHERE NO = ?";
        int result = 0;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, no);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}