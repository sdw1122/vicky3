package com.vicky.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.vicky.dto.MemberDTO;

public class MemberDAO {
    private final String URL = "jdbc:mysql://localhost:3306/VickyDB?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
    private final String UID = "root";
    private final String PWD = "1234";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, UID, PWD);
    }

    public int login(String id, String passwd) {
        String sql = "SELECT PASSWD FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    if (rs.getString("PASSWD").equals(passwd)) {
                        return 1; // 로그인 성공
                    } else {
                        return 0;
                    }
                }
                return -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }

    public String getUserName(String id) {
        String name = null;
        String sql = "SELECT NAME FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("NAME");
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return name;
    }
    
    public void insertMember(MemberDTO dto) {
        String sql = "INSERT INTO MEMBER (ID, PASSWD, NAME) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPasswd());
            pstmt.setString(3, dto.getName());
            
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean confirmId(String id) {
        String sql = "SELECT ID FROM MEMBER WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return true; // 이미 존재하는 아이디
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // 사용 가능한 아이디
    }
}